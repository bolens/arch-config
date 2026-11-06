# Implementation plan

The repository owns the native pipeline, transition guide, and delivery docs.
Reuse the established pinned Nix container and pinned devenv CLI; the repository
lock and existing enterTest remain authoritative. Use fork approval and keep
all trust flags disabled. No publisher, registry credential, live host, shared
reusable workflow, or product-release boundary changes.

Validate YAML, workflow security and existing local gates; independently review
the diff. Activate the repo, test the actual PR head, squash normally, and verify
the genuine main. Retire only proven duplicates through a subsequent reviewed
change after checking required-check settings.
