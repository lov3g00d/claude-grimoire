# ADR template

Compose the record from the sections below, in this order. Each carries an **include when** rule. Drop any section that would be thin or empty; a record with three tight sections beats one with seven padded ones. The core is Nygard's (context, decision, consequences); the optional fields are drawn from MADR.

## Sections

**Title** (always) - `ADR-NNNN: <short noun phrase>`. Name the decision, not the problem. Prefer "ADR-0007: Serve tiles from an internal cache" over "ADR-0007: Tile performance".

**Status** (always, once more than one ADR exists) - one of `proposed | rejected | accepted | deprecated | superseded by ADR-XXXX`. This is how supersession works; it is one line and cheap.

**Date** (always) - `YYYY-MM-DD`. Anchors the decision in time.

**Context** (always, 1-3 short paragraphs) - the forces at play: technical, organizational, and project-local. Neutral and factual. State the problem and the constraints without arguing for an answer.

**Decision** (always, 1-3 sentences) - the response chosen, in active voice: "We will...". If a short "because" clarifies the choice, include it.

**Considered options** (only when the choice was contested) - the alternatives weighed and, in a line each, why they lost. Omit for a forced or obvious decision. This is the most valuable optional field when it applies and pure padding when it does not.

**Consequences** (always) - the resulting context after the decision, positive and negative. Name the new constraints, the follow-on work, and what gets harder. A reader trusts the record that lists its downsides.

## Concision rules

- Lead with the point. No preamble, no "this document describes".
- Prose over bullets for context and consequences; a decision is an argument, not a checklist.
- One decision per record. Never restate the title in the body.
- Omit a section rather than write "N/A" or a placeholder.
- Keep it to one or two pages. If it runs longer, the decision is probably two decisions.

## Example (accepted decision, options included because the choice was contested)

    # ADR-0012: Store session state in Redis, not the primary database
    Status: accepted
    Date: 2026-02-18

    ## Context
    Session lookups run on every authenticated request and now account for a
    third of primary-database load. Sessions are ephemeral, high-churn, and
    never queried relationally. The database is the bottleneck under peak load.

    ## Decision
    We will move session state to a dedicated Redis instance with a TTL equal
    to the session lifetime, because it removes the hot path from the primary
    database and gives us expiry for free.

    ## Considered options
    - Keep sessions in the database, add a read replica: does not remove write
      load, and sessions are the write-heavy part.
    - Signed stateless JWTs: no server-side revocation, which we require.

    ## Consequences
    Session reads leave the primary database, cutting peak load. We now run and
    monitor a Redis instance, and a Redis outage logs everyone out rather than
    degrading. Session data is no longer covered by database backups; loss on
    restart is acceptable because sessions are disposable.
