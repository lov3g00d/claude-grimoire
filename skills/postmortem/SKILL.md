---
name: postmortem
description: Write a blameless incident postmortem in a consistent, learning-focused structure. Use when the user wants to document an incident or outage, run a post-incident review, capture a root-cause writeup, or turn an incident timeline into a durable record. Produces a lean, blameless record (impact, timeline, contributing factors, action items) grounded in the Google SRE and PagerDuty conventions.
---

# Postmortem

Write a blameless record of an incident so the organization learns from it and the same failure does not recur. The record examines systems and processes, never individuals. Favor a record that drives real action items over a complete-looking one: every section earns its place, and a small incident stays short.

## Steps

1. **Gather the incident.** Establish what broke, the impact, the timeline with timestamps, how it was detected and resolved, and the contributing factors. Pull from the incident channel, alerts, dashboards, and the people who responded. Anchor the timeline to evidence, not memory.
2. **Draft from the template.** Follow `references/template.md`. Include only the sections this incident needs; do not expand a brief outage into empty headings.
3. **Lint for blamelessness.** Apply the blameless-language and concision checks in the template. Rewrite any agentive "person did X" into systemic "the system allowed X". Every action item gets an owner and a tracked ticket.
4. **Place the record.** Suggest a location and filename, but treat both as conventions, not mandates. Confirm where the user wants it, then write the file.

## Rules

- Blameless throughout. Investigate the systematic reasons a failure was possible, not who to hold responsible. You cannot fix people; you can fix systems and processes.
- Assume good intent: everyone acted reasonably on the information they had. Name contributing causes without indicting any person or team.
- Evidence over recollection: anchor the timeline and impact to logs, alerts, and metrics with timestamps.
- Action items are the payoff. Each is concrete, owned, and tracked, or it will not happen.
- Do not hardcode a repo path, ticketing tool, or severity scheme. Suggest the convention and let the user place the file.
- Sized to the incident: omit a section rather than pad it. A short postmortem is a feature, not a gap.
