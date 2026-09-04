# Postmortem template

Compose the record from the sections below, in this order. Each carries an **include when** rule. Drop any section that would be thin or empty; a record with five tight sections beats one with a dozen padded ones. The core is the convergence of Google SRE and PagerDuty; the optional fields are included only when they carry weight.

## Sections

**Title** (always) - `<incident name> (#NNN)`. Name what broke, not the fix. Prefer "Checkout API returning 503s (#42)" over "Checkout incident".

**Summary** (always, 2-3 sentences) - what broke, how long it lasted, and the impact, in plain language. A reader who reads only this line should understand the incident.

**Metadata** (always, one line) - severity, date, and duration. Add authors or a review link only if your tooling expects them.

**Impact** (always) - quantified damage: who and what was affected, for how long, and by how much. Use a table when it carries the numbers better than prose (requests failed, users affected, revenue, SLO burn).

**Timeline** (always) - chronological events with timestamps (state the zone, prefer UTC), each linked to its evidence: the alert, the graph, the deploy, the message. Detection and resolution are points on this line.

**Detection** (only when detection was slow or a problem) - how the incident was found and how long that took. This is where mean-time-to-detect action items come from. If detection was immediate and clean, fold it into the timeline.

**Trigger** (only when distinct from the root cause) - the proximate event that activated a latent fault. Separating the spark from the underlying condition sharpens the analysis; if they are the same, omit this.

**Contributing factors / Root cause(s)** (always) - the systemic reasons the incident was possible, in the plural. Write about systems and processes, not people. Most incidents have several contributing conditions rather than one culprit.

**Resolution** (always) - what actually stopped the bleeding: the mitigation that restored service and the fix that addressed the cause. Distinguish the two if they differ.

**Lessons learned** (always) - what went well and what went wrong, honestly. Add a "where we got lucky" note when a near-miss in the response is worth surfacing, so the next response does not rely on luck.

**Action items** (always) - the follow-ups that prevent recurrence, each with an **owner** and a **tracked ticket**. An unowned action item is a wish. Prefer systemic fixes over "be more careful".

## Blameless-language check

- Rewrite agentive failure into systemic failure: not "Alice pushed a bad config" but "the deploy path had no validation to catch the bad config".
- Name no one as a cause. People appear as responders and roles, never as the reason it broke.
- Frame causes as conditions the system permitted, so the fix targets the system.

## Concision rules

- Lead with the point. No preamble, no "this document is a postmortem of".
- One event per timeline entry, in order, with its timestamp.
- Quantify impact; "significant impact" tells a reader nothing.
- Omit a section rather than write "N/A" or a placeholder.
- Every action item is verifiable and owned. Cut aspirations that no one will track.

## Example (brief outage, granular sections rightly omitted)

    # Checkout API returning 503s (#42)
    Summary: A config change removed the checkout service's database
    connection pool limit, exhausting connections and returning 503s for
    38 minutes. Roughly 4,100 checkout attempts failed.
    Severity: SEV-2 | Date: 2026-08-30 | Duration: 38m (14:02-14:40 UTC)

    ## Impact
    - ~4,100 failed checkout attempts (100% of checkout traffic for 38m)
    - Estimated $12k in abandoned orders
    - No data loss; failed requests were not charged

    ## Timeline (UTC)
    - 14:02  Config deploy #881 ships, dropping `db.pool.max`.
    - 14:05  Connection count climbs; latency alert fires.
    - 14:11  On-call acknowledges, opens incident.
    - 14:33  Deploy #881 identified as the trigger.
    - 14:40  Rollback to #880 completes; 503s stop.

    ## Contributing factors
    The pool limit lived in a config file with no schema validation, so an
    empty value silently disabled the cap rather than being rejected. Load
    tests run against a fixed pool size and never exercised an unbounded one.

    ## Resolution
    Rolled back to deploy #880, which restored the pool limit and cleared the
    connection exhaustion. The bad value was corrected in config before the
    next deploy.

    ## Lessons learned
    - What went well: the latency alert fired within three minutes.
    - What went wrong: 22 minutes passed before the deploy was suspected;
      recent deploys were not the first thing checked.

    ## Action items
    - Add schema validation rejecting an empty `db.pool.max`. Owner: @dbteam, TICKET-501.
    - Surface recent deploys in the incident channel on alert. Owner: @sre, TICKET-502.
