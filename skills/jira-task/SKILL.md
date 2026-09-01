---
name: jira-task
description: Create a well-formed Jira issue in a consistent, best-practice structure. Use when the user wants to create a Jira ticket, task, story, or bug, turn a discussion or a bug into an issue, or file work in Jira. Produces a lean, scannable ticket (problem, work, acceptance criteria) and creates it through the Atlassian MCP after the user confirms.
---

# Jira task

Turn a request or a discussion into a well-formed Jira issue. Favor a short, scannable ticket over a complete-looking one: every section earns its place, and a one-line task stays one line.

## Steps

1. **Resolve the target.** Find the site with `getAccessibleAtlassianResources` and the project. If the project or issue type is ambiguous, ask rather than guess. Read the project's issue types with `getJiraProjectIssueTypesMetadata`, map the work to Task, Story, or Bug, and note any required or custom fields.
2. **Draft from the template.** Follow `references/template.md`. Include only the sections this ticket needs; do not expand a small task into empty headings.
3. **Lint.** Apply the INVEST and concision checks in the template. Cut restated summary, filler, and duplicated content. Make every acceptance criterion testable.
4. **Confirm, then create.** Show the rendered ticket with the resolved project, issue type, and labels. On approval, create it with `createJiraIssue` (description as markdown) and return the issue key and URL.

## Rules

- Draft, confirm, then create. Never create an issue before the user has seen it.
- Resolve the project's real issue types and required fields at runtime. Do not hardcode a project key, field, or site.
- Evidence over assertion: name the log, metric, PR, or issue that motivates the work.
- Sized to the work: omit a section rather than pad it. A short ticket is a feature, not a gap.
