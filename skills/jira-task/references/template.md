# Ticket template

Compose the description from the sections below, in this order. Each carries an **include when** rule. Drop any section that would be thin or empty; a ticket with three tight sections beats one with eight padded ones.

## Sections

**Title** (always) - outcome-oriented, specific, one line. Name the change and where. Prefer "Repoint OSRM callers to the internal Service" over "Fix OSRM".

**Context** (when the reason is not obvious from the title) - one or two sentences of background: why this exists now, what it depends on.

**Problem** or **Goal** (always, 1-3 sentences) - for a fix, what is wrong and its impact; for a feature, the outcome wanted. Use "Problem" for defects, "Goal" for new work.

**Findings** (only with real investigation data) - dated evidence: measurements, a small table, references to logs, errors, or PRs. This is where challenges and constraints live. No data means no section.

**Work** (for anything non-trivial) - a numbered plan of what will be done. Keep steps concrete and ordered. Mark a suggested approach as a suggestion, not a mandate.

**Out of scope** (when scope could creep) - one or two bullets naming what this ticket deliberately excludes.

**Acceptance criteria** (always, for a Task or Story) - a testable bullet checklist that defines done. Each item is verifiable by someone other than the author.

**Links** (when they exist) - related issues and PRs, one line.

## Concision rules

- Lead with the point. No preamble, no "this ticket is about".
- One idea per sentence. Cut adjectives that carry no information.
- Never restate the title in the body.
- Omit a section rather than write "N/A" or a placeholder.
- Use a table or code block only when it carries data prose cannot.

## INVEST check (stories)

Independent, Negotiable, Valuable, Estimable, Small, Testable. If a story fails Small, split it. If it fails Testable, the acceptance criteria are not concrete enough yet.

## Example (small task, most sections rightly omitted)

    Title: Cap osrm-customize threads to fix CPU oversubscription

    ## Problem
    osrm-customize runs with no thread cap, sizing its pool from host cores
    (~16) inside a 4-core quota. Customize thrashes, starves the readiness
    probe, and pods flap NotReady on every reload.

    ## Work
    1. Set `-t (cores-1)` and `nice -n 19` in the traffic-updater template.
    2. Benchmark customize wall-time vs threads to find where it stops scaling.

    ## Acceptance criteria
    - No readiness flapping during reloads.
    - Customize wall-time measured and reduced from the current ~56s.
