#!/bin/bash -e
set -o pipefail
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
PROJECT_DIR="$(realpath "${SCRIPT_DIR}/..")"

# Ask user for the new name
CURRENT_NAME="mypackage"
read -p "Package name: " -r NEW_NAME

# Update files content
git ls-files | while read -r FILE; do
    sed -i -e "s:$CURRENT_NAME:$NEW_NAME:g" "${FILE}"
done

# Update paths
find "${PROJECT_DIR}" -depth -not -path '*/.git/*' | while read -r CURRENT_PATH; do
    if [[ "$(basename "${CURRENT_PATH}" | grep -c "${CURRENT_NAME}")" = "1" ]]; then
        NEW_PATH="$(dirname "${CURRENT_PATH}")/$(basename "${CURRENT_PATH}" | sed "s:${CURRENT_NAME}:${NEW_NAME}:")"
        mv "${CURRENT_PATH}" "${NEW_PATH}"
    fi
done

# Deploy the new package
poetry install

# Remove script and commit the change
git rm -f "$0"
git add .
git commit -m "Rename package to ${NEW_NAME}"