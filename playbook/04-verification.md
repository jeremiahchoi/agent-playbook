# 04 — Verification: the biggest quality lever

The creator of Claude Code calls verification "the most important thing to get great results" — worth 2–3x output quality. It matters more than any documentation practice in this playbook.

The principle: an agent stops when the work *looks* done. Without a check it can run, you are the verification loop and every mistake waits for you to notice. Give it something that returns pass/fail and the loop closes itself: work → run check → read result → iterate.

## Give every project a check the agent can run

Any signal readable in-conversation works:

- Test suite (prefer single-test commands — document them in CLAUDE.md)
- Build/typecheck exit codes
- Linters
- A script that diffs output against a fixture
- Browser screenshot compared against a design (frontend)
- iOS/Android simulator (mobile)
- Actually starting the service and hitting it (backend)

Bake the domain-specific version into a `verify-app` subagent (the kit ships a template) so "verify your work" means the same thing for everyone on the team.

## Put verification in the prompt, not after it

Weak: "implement email validation."
Strong: "implement `validateEmail`; test cases: `user@example.com` → true, `invalid` → false, `user@.com` → false. Run the tests after implementing."

And for bugs: "write a failing test that reproduces it, then fix it. Address the root cause; don't suppress the error."

## Escalate how hard the check gates

1. **In the prompt** — "run the check and iterate until it passes." Works everywhere, today.
2. **Per phase of a plan** — every plan phase names its verification (see [03](03-workflow.md)); the agent doesn't advance until it passes.
3. **Hooks** — a Stop hook runs your check as a script and blocks the turn from ending until it passes; PostToolUse hooks auto-format after every edit so CI never fails on style.
4. **Adversarial review** — a fresh-context subagent reviews the diff against the plan: "check every requirement is implemented, listed edge cases have tests, nothing out of scope changed. Report gaps, not style preferences." Fresh context = no bias toward code it just wrote.

## Demand evidence, not assertions

Have the agent show the test output, the command and what it returned, or the screenshot — not "done, everything works." Reviewing evidence is faster than re-running checks yourself, and it's the only way to trust sessions you didn't watch. If you can't verify it, don't ship it.

One calibration note: a reviewer prompted to find gaps will always find some. Tell reviewers to flag only what affects correctness or stated requirements — chasing every finding produces defensive over-engineering.
