---
name: adr
description: Capture an architecture decision as a well-formed ADR in a consistent, lightweight structure. Use when the user wants to record a technical decision, document why an approach was chosen over the alternatives, write an ADR, or turn a design discussion into a durable record. Produces a lean record (context, decision, consequences) grounded in the Nygard and MADR conventions.
---

# ADR

Capture an architecture decision as a short, durable record. An ADR explains why a choice was made so a future reader does not have to reverse-engineer it. Favor a record a reader finishes in two minutes over a complete-looking one: every section earns its place, and a forced decision stays short.

## Steps

1. **Gather the decision.** Establish what was decided, the forces that shaped it, and the alternatives that were genuinely on the table. If the decision itself is still open, say so; an ADR records a decision, it does not make one.
2. **Draft from the template.** Follow `references/template.md`. Include only the sections this decision needs; do not expand a forced or obvious choice into empty headings.
3. **Lint.** Apply the concision checks in the template. State the decision in active voice ("We will..."). List consequences honestly, the negative ones too. Cut restated context and advocacy.
4. **Number and place.** Suggest the next `NNNN-short-title.md` in sequence and a location, but treat both as conventions, not mandates. Confirm where the user wants it, then write the file.

## Rules

- One decision per record. If the draft covers two decisions, split it.
- Record the decision, do not relitigate it. Context is neutral and factual; advocacy belongs in the discussion, not the ADR.
- Consequences are the point. A reader trusts an ADR that names its downsides.
- Include "Considered options" only when the choice was contested and a reader will ask "why not X?". For a forced decision, cut it.
- Do not hardcode a repo path or numbering scheme. Suggest the convention and let the user place the file.
- Sized to the decision: omit a section rather than pad it. A short ADR is a feature, not a gap.
