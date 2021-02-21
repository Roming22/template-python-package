#!/bin/bash -e
#
# Generate the Python package with the correct version number
#
set -o pipefail
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
PROJECT_DIR="$(realpath "${SCRIPT_DIR}/../..")"

# Generate a new version
python tools/releasing/version.py
VERSION="$(python "${PROJECT_DIR}/src/mypackage/__version__.py")"

# Package the application
echo "Release: ${VERSION}}"
poetry build
git tag "${VERSION}}"
