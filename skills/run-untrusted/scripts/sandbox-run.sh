#!/usr/bin/env bash
set -euo pipefail

repo=${1:?usage: sandbox-run <repo-dir> <command...>}
shift
cmd=${*:?usage: sandbox-run <repo-dir> <command...>}

repo=$(cd "$repo" && pwd -P)

img=${SANDBOX_IMAGE:-docker.io/library/busybox:1.36}
net=${SANDBOX_NETWORK:-none}
work_size=${SANDBOX_WORK_SIZE:-2g}
tmp_size=${SANDBOX_TMP_SIZE:-256m}
mem=${SANDBOX_MEM:-4g}
pids=${SANDBOX_PIDS:-256}
cpus=${SANDBOX_CPUS:-2}
uid=${SANDBOX_UID:-65534}
runtime=${SANDBOX_RUNTIME:-}

[ "$uid" = "0" ] && { echo "sandbox-run: refusing SANDBOX_UID=0 (under rootless podman, container uid 0 maps to your host user, which voids the jail)" >&2; exit 2; }

args=(
  --rm
  --network "$net"
  --cap-drop ALL
  # SETUID/SETGID exist only so the trusted bootstrap below can drop to an
  # unprivileged uid; the untrusted command runs with CapEff 0 under no-new-privs
  # and cannot reacquire them. Removing these breaks the drop (exit 97), it does
  # not harden the jail.
  --cap-add SETUID
  --cap-add SETGID
  --security-opt no-new-privileges
  --read-only
  --tmpfs "/tmp:rw,size=$tmp_size,mode=1777,nosuid,nodev"
  --tmpfs "/work:rw,size=$work_size,mode=0777,nosuid,nodev"
  --volume "$repo:/src:ro"
  --memory "$mem"
  --memory-swap "$mem"
  --pids-limit "$pids"
  --cpus "$cpus"
  --ulimit "nofile=1024:1024"
  --ulimit "fsize=1073741824:1073741824"
  --workdir /work
  --entrypoint ""
  --env "SB_UID=$uid"
  --env "SB_IMAGE=$img"
)
[ -n "$runtime" ] && args+=(--runtime "$runtime")

exec podman run "${args[@]}" "$img" \
  /bin/sh -c '
    set -e
    cp -R /src/. /work/
    chmod -R a+rwX /work
    cd /work
    if command -v setpriv >/dev/null 2>&1 \
       && setpriv --reuid "$SB_UID" --regid "$SB_UID" --clear-groups true 2>/dev/null; then
      exec setpriv --reuid "$SB_UID" --regid "$SB_UID" --clear-groups /bin/sh -c "$0"
    elif command -v setuidgid >/dev/null 2>&1; then
      exec setuidgid "$SB_UID" /bin/sh -c "$0"
    elif command -v su-exec >/dev/null 2>&1; then
      exec su-exec "$SB_UID:$SB_UID" /bin/sh -c "$0"
    fi
    echo "sandbox-run: no setpriv/setuidgid/su-exec in image $SB_IMAGE to drop privileges" >&2
    exit 97
  ' "$cmd"
