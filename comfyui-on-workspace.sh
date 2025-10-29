#!/bin/bash

# Ensure we have /workspace in all scenarios
mkdir -p /workspace

SOURCE_DIR=/ComfyUI
TARGET_DIR=/workspace/ComfyUI

# Seed the workspace copy if it is missing or corrupted (e.g. lost its .git metadata on the network drive)
if [[ ! -d "${TARGET_DIR}" || ! -d "${TARGET_DIR}/.git" ]]; then
	rm -rf "${TARGET_DIR}"
	cp -a "${SOURCE_DIR}" /workspace/
fi

# Replace the image copy with a symlink that points at the persistent workspace
rm -rf "${SOURCE_DIR}"
ln -s "${TARGET_DIR}" "${SOURCE_DIR}"

# Mark the workspace checkout as safe for git (prevents warnings when UID/GID differ on network storage)
if command -v git >/dev/null 2>&1; then
	git config --global --add safe.directory "${TARGET_DIR}" >/dev/null 2>&1 || true
fi
