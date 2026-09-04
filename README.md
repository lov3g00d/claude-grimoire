# Claude Grimoire

A personal grimoire of [Claude Code](https://code.claude.com/docs/en/overview) subagents and skills - recipes for summoning specialized helpers.

## Agents

| Name | Role |
| :--- | :--- |
| [`jarvis`](agents/jarvis.md) | Mission-control orchestrator. Runs the full explore→plan→execute→verify loop in its own context and returns one actionable result. Best for outcome-described, multi-step briefs (`"the build is broken"`, `"design the migration plan"`). Delegates domain slices to the specialists below. |
| [`shuri`](agents/shuri.md) | Infrastructure-as-code and platform engineer. Designs and reviews IaC modules, reads the plan or diff before it lands, hunts drift, and shapes Kubernetes manifests, Helm charts, and GitOps sync. Previews changes and leaves the apply or sync for you to trigger; works through whatever IaC and delivery tooling the repo already uses. |
| [`quicksilver`](agents/quicksilver.md) | Release and delivery engineer. Designs and reviews CI/CD pipelines, plans cutovers and rollbacks, works out versioning and changelogs, and promotes an immutable artifact between environments. Rehearses the machinery and writes the ordered cutover plan; leaves the production trigger for you to pull. |
| [`sage`](agents/sage.md) | Data and database engineer. Designs and reviews schemas, writes and rehearses migrations with their rollback, tunes slow queries from their plans, and reasons about backup and restore correctness. Rehearses a migration and its rollback on representative data before it runs; leaves the destructive production step for you to trigger. Tends the data inside the store, not the instance shuri provisions. |
| [`forge`](agents/forge.md) | System craftsman. Housekeeping, cleanup, configuration, and debugging for the local machine you run. Works through the system's own management model (declarative or imperative) instead of assuming one, establishes a rollback point before any change, and leaves privileged activation (a rebuild or switch) to you. |
| [`vision`](agents/vision.md) | Observability and SRE analyst. Characterizes reliability and performance from logs, metrics, and traces, root-causes incidents, and forecasts trends with confidence intervals. Writes the queries (PromQL, LogQL), the SLO/capacity report, and the forecast (RED, USE, Four Golden Signals, error budgets); stays on operational signal, not security. |
| [`heimdall`](agents/heimdall.md) | Defensive-security counsel. Hardening, detection engineering, and IR for systems you own or operate. Writes the rules and runbooks (Sigma, YARA, Suricata, Falco, audit) rather than just describing them. |
| [`loki`](agents/loki.md) | Offensive-security counsel. Recon planning, attack-surface mapping, and exploit reasoning on authorized targets (your systems, written scope, CTF/HTB). Requires authorization context before substantive analysis; refuses unauthorized targets. |
| [`taskmaster`](agents/taskmaster.md) | Offensive-security mentor. Methodology coach for picking the right surface frame, phase, and tool category with their counter-indications. Teaches the craft (PTES, OWASP WSTG, MASTG, NIST SP 800-115, OSSTMM); coaches methodology rather than operating on live targets. |
| [`fury`](agents/fury.md) | Research and intelligence analyst. Investigates a topic across many sources, establishes non-obvious facts, and compares options on the evidence. Prefers the primary source, cross-checks load-bearing claims, anchors version- and time-sensitive answers to what it verified, and marks each claim verified, inferred, or assumed. |
| [`urich`](agents/urich.md) | Technical writer. Prose that ships under your name: pull requests, ADRs, READMEs, runbooks, release notes, announcements. Reads the source it describes before writing, mirrors the venue's existing voice, and strips the patterns that read as machine-generated. |
| [`uatu`](agents/uatu.md) | Memory housekeeper. Consolidates, dedupes, and prunes the file-based agent-memory stores: merges overlapping entries, normalizes dates, repairs `[[links]]` and index pointers, enforces the type taxonomy and don't-save rules, and keeps each `MEMORY.md` under the 200-line injection cap. Operates on memory files only; proposes destructive changes as a diff first. |

## Skills

| Name | Role |
| :--- | :--- |
| [`jira-task`](skills/jira-task/SKILL.md) | Jira issue authoring. Turns a request or discussion into a lean, best-practice ticket (problem, work, acceptance criteria), resolves the project and issue type at runtime, and creates it via the Atlassian MCP after you confirm. |

## Install

This repository is both a [Claude Code plugin](https://code.claude.com/docs/en/plugins-reference) and its own [marketplace](https://code.claude.com/docs/en/plugin-marketplaces). Install it as a plugin, or symlink the agents into your user directory. Either way you need a Claude Code version with plugin support (run `/plugin`; if the command is missing, update Claude Code).

### As a plugin (recommended)

1. Add the marketplace: `/plugin marketplace add lov3g00d/claude-grimoire`
2. Install the plugin: `/plugin install claude-grimoire@grimoire`

The marketplace registers under the name `grimoire`; the plugin it serves is `claude-grimoire`.

### As a symlink (fast path)

```sh
git clone git@github.com:lov3g00d/claude-grimoire.git ~/Projects/personal/claude-grimoire
mkdir -p ~/.claude/agents ~/.claude/skills
for a in ~/Projects/personal/claude-grimoire/agents/*.md; do
  ln -s "$a" ~/.claude/agents/
done
for s in ~/Projects/personal/claude-grimoire/skills/*/; do
  ln -s "$s" ~/.claude/skills/
done
```

Restart Claude Code to pick up the new agent and skill files.

## Use

```text
@agent-jarvis investigate why the build is failing and fix it
```

Symlinked agents are invoked by their bare name (`@agent-jarvis`). Plugin-installed agents are scoped by the plugin name (`@agent-claude-grimoire:jarvis`). Natural language works too: `Jarvis, …`. For an explicit whole-session default: `claude --agent jarvis`.

## License

[MIT](LICENSE)
