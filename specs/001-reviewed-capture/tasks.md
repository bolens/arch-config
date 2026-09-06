# Tasks: Reviewed configuration capture

- [x] T001 Inspect the existing helper and document its conflict with PR delivery.
- [x] T002 Define preview, preservation, private-state, and failure requirements.
- [x] T003 Implement the capture helper and operator instructions.
- [x] T004 Exercise preview, apply, exclusion, invalid-input, and failure cases.
- [x] T005 Run native gates and separately review the complete change.
- [x] T006 Merge through a passing PR and verify the merged revision.

## Local verification

Six disposable capture tests pass, including preview preservation, safe relative
links, external/private exclusions, invalid input, package failure before writes,
and copy failure. The pre-push gate passes all Fish syntax checks, Actionlint,
and Zizmor. A separate self-review traced the timer invocation, rsync selection,
package publication, and Git authority boundary. No live capture was executed.
PR #14 merged at `2a6cdfa75aca99ac1ad587901be7b28eaed577e7`. All three
merge-revision workflows passed: CI, Spec Kit, and workflow lint. The capture
helper has not been applied to the live host.

## Follow-up destination audit

- [x] T007 Reproduce an external write through a destination user-config symlink.
- [x] T008 Reject symlinked capture roots before writes and cover all three roots,
  including dangling links, with disposable fixtures.

The follow-up suite passes seven tests, with six symlink-root cases in the new
regression. Existing preview, source-link, exclusion, and failure checks remain.
Current PR validation and delivery are tracked separately from the prior receipt.
