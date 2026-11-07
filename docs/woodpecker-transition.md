# Woodpecker validation transition

The native pipeline runs the existing locked `devenv test` in a disposable
Linux container on the shared CI site. It does not apply configuration to a
workstation. The clone and runtime images are immutable; there are no host
mounts, Docker sockets, privileged containers, or publishing secrets.

## CI organization

The [shared purpose phases](https://github.com/bolens/.github/blob/main/docs/woodpecker-transition.md#ci-organization)
organize the existing `devenv test` gate. It delegates to
`bash scripts/check-development.sh`; focused rows identify its component checks.

| Phase | Check group / canonical local command | Native workflow / step | Retained hosted owner / boundary |
| --- | --- | --- | --- |
| `validate` | Fish syntax, source/workflow policy and selected development docs: `devenv test` | `woodpecker` / `development-environment` | PR, main push and native manual validation; Fish is parsed once per tracked file without loading configuration |
| `test` | Disposable capture and adapter fixtures: `python3 -m unittest discover -s tests -v` | Included in the same development gate | Fixture roots and package inventories are isolated; live workstation state is not captured or applied |
| `test` | Development platforms: commands in the [development guide](development-environments.md) | Separate hosted acceptance | Native macOS plus actual Docker/editor image validation retain their existing selection |

The `woodpecker` alias and current required checks remain stable. Reviewed
`main` records desired configuration. Applying it to a workstation remains an
explicit operational action outside these CI groups.

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
