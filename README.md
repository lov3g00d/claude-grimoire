# Claude Grimoire

A personal grimoire of [Claude Code](https://code.claude.com/docs/en/overview) subagents - recipes for summoning specialized helpers.

## Agents

| Name | Role |
| :--- | :--- |
| [`jarvis`](agents/jarvis.md) | Mission-control orchestrator. Runs the full explore→plan→execute→verify loop in its own context and returns one actionable result. Best for outcome-described, multi-step briefs (`"the build is broken"`, `"design the migration plan"`). |
| [`moriarty`](agents/moriarty.md) | Offensive-security counsel. Recon planning, attack-surface mapping, and exploit reasoning on authorized targets (your systems, written scope, CTF/HTB). Requires authorization context before substantive analysis; refuses unauthorized targets. |
| [`heimdall`](agents/heimdall.md) | Defensive-security counsel. Hardening, detection engineering, and IR for systems you own or operate. Writes the rules and runbooks (sigma, yara, suricata, falco, audit) rather than just describing them. |
| [`chiron`](agents/chiron.md) | Offensive-security mentor. Methodology coach for picking the right surface frame, phase, and tool category with their counter-indications. Teaches the craft (PTES, OWASP WSTG, MASTG, NIST SP 800-115, OSSTMM); coaches methodology rather than operating on live targets. |
| [`vision`](agents/vision.md) | Observability & SRE analyst. Characterizes reliability and performance from logs, metrics, and traces, root-causes incidents, and forecasts trends with confidence intervals. Writes the queries (PromQL, LogQL), the SLO/capacity report, and the forecast (RED, USE, Four Golden Signals, error budgets); stays on operational signal, not security. |

## Install

This repository is both a [Claude Code plugin](https://code.claude.com/docs/en/plugins-reference) and its own [marketplace](https://code.claude.com/docs/en/plugin-marketplaces). Install it as a plugin, or symlink the agents into your user directory. Either way you need a Claude Code version with plugin support (run `/plugin`; if the command is missing, update Claude Code).

### As a plugin (recommended)

1. Add the marketplace: `/plugin marketplace add lov3g00d/claude-grimoire`
2. Install the plugin: `/plugin install claude-grimoire@grimoire`

The marketplace registers under the name `grimoire`; the plugin it serves is `claude-grimoire`.

### As a symlink (fast path)

```sh
git clone git@github.com:lov3g00d/claude-grimoire.git ~/Projects/personal/claude-grimoire
mkdir -p ~/.claude/agents
for a in ~/Projects/personal/claude-grimoire/agents/*.md; do
  ln -s "$a" ~/.claude/agents/
done
```

Restart Claude Code to pick up the new agent files.

## Use

```text
@agent-jarvis investigate why the build is failing and fix it
```

Symlinked agents are invoked by their bare name (`@agent-jarvis`). Plugin-installed agents are scoped by the plugin name (`@agent-claude-grimoire:jarvis`). Natural language works too: `Jarvis, …`. For an explicit whole-session default: `claude --agent jarvis`.

## License

[MIT](LICENSE)
