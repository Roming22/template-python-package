#!/bin/bash -e
set -o pipefail
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
PROJECT_DIR="$(realpath "${SCRIPT_DIR}/..")"

# Start fresh
make nuke

# Ask user for the new name
CURRENT_NAME="mypackage"
read -p "Package name: " -r NEW_NAME
read -p "GitHub project URL (git@github.com:user/repo.git): " -r GITHUB_URL

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
make install
make test

# Remove script and commit the change
rm -rf ".git" "$0"
git init
git add .
git commit -m "Initial commit (from https://github.com/Roming22/template-python-package)"
git remote add origin "${GITHUB_URL}"
for BRANCH in "release/0.0" "dev"; do
    git checkout -b "${BRANCH}"
    git push --set-upstream origin "${BRANCH}"
done
