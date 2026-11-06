# Woodpecker validation transition

The native pipeline runs the existing locked `devenv test` in a disposable
Linux container on the shared CI site. It does not apply configuration to a
workstation. The clone and runtime images are immutable; there are no host
mounts, Docker sockets, privileged containers, or publishing secrets.

## Delivery plan

1. Add the native pipeline and activate this repository with fork approval.
2. Require the existing GitHub checks and the actual native PR result before
   squash merging the reviewed source.
3. Verify the genuine main pipeline and its exact source revision.
4. Move duplicate Linux validation after native proof and required-check
   settings agree. Preserve macOS, actual Docker, administrative automation,
   source lint, and any checks not covered by this pipeline.

Local validation is evidence for the source; it does not establish native
runner success. Failure leaves existing GitHub validation available. Recover
through a corrective PR, without changing live workstation configuration.

Review image pins monthly and after security releases against the official
registries. Existing dependency automation does not discover these Woodpecker
YAML image references; updates require a reviewed PR and native execution.
