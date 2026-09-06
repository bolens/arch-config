#!/usr/bin/env bash
# Install checkout dependencies without starting application or host services.
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."
bash .devcontainer/smoke.sh
