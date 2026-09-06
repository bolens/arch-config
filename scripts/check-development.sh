#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."
# Capture tests supply disposable roots and a stub package inventory command.
python3 -m unittest discover -s tests -v
while IFS= read -r -d '' file; do
  fish --no-execute "$file"
done < <(git ls-files -z -- '*.fish')
shellcheck scripts/check-development.sh
ruff check scripts/development-container.py tests
actionlint
zizmor --offline --min-severity medium --min-confidence medium .github
markdownlint-cli2 'docs/development-environments.md' 'specs/002-development-environments/*.md'
