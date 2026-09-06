# Tasks: Reviewed configuration capture

- [x] T001 Inspect the existing helper and document its conflict with PR delivery.
- [x] T002 Define preview, preservation, private-state, and failure requirements.
- [x] T003 Implement the capture helper and operator instructions.
- [x] T004 Exercise preview, apply, exclusion, invalid-input, and failure cases.
- [x] T005 Run native gates and separately review the complete change.
- [ ] T006 Merge through a passing PR and verify the merged revision.

## Local verification

Six disposable capture tests pass, including preview preservation, safe relative
links, external/private exclusions, invalid input, package failure before writes,
and copy failure. The pre-push gate passes all Fish syntax checks, Actionlint,
and Zizmor. A separate self-review traced the timer invocation, rsync selection,
package publication, and Git authority boundary. No live capture was executed.
Hosted evidence remains pending on the implementation PR.
