# Claude Grimoire

A personal grimoire of [Claude Code](https://docs.claude.com/en/docs/claude-code) subagents - recipes for summoning specialized helpers.

## Agents

| Name | Role |
| :--- | :--- |
| [`jarvis`](agents/jarvis.md) | Mission-control orchestrator. Runs the full explore→plan→execute→verify loop in its own context and returns one actionable result. Best for outcome-described, multi-step briefs (`"the build is broken"`, `"design the migration plan"`). |
| [`moriarty`](agents/moriarty.md) | Offensive-security counsel. Recon planning, attack-surface mapping, and exploit reasoning on authorized targets (your systems, written scope, CTF/HTB). Requires authorization context before substantive analysis; refuses unauthorized targets. |
| [`heimdall`](agents/heimdall.md) | Defensive-security counsel. Hardening, detection engineering, and IR for systems you own or operate. Writes the rules and runbooks (sigma, yara, suricata, falco, audit) rather than just describing them. |

## Install

This repository follows the [Claude Code plugin layout](https://code.claude.com/docs/en/plugins-reference). Install it as a plugin via a marketplace, or symlink the agents into your user directory.

### As a plugin (recommended)

1. Add this repository as a plugin marketplace source: `/plugin marketplace add lov3g00d/claude-grimoire`
2. Install: `/plugin install claude-grimoire`

### As a symlink (fast path)

```sh
git clone git@github.com:lov3g00d/claude-grimoire.git ~/Projects/personal/claude-grimoire
ln -s ~/Projects/personal/claude-grimoire/agents/jarvis.md ~/.claude/agents/jarvis.md
```

Restart Claude Code to pick up the new agent file.

## Use

```text
@agent-jarvis investigate why the build is failing and fix it
```

Or natural language: `Jarvis, …`. For an explicit whole-session default: `claude --agent jarvis`.

## License

[MIT](LICENSE)
