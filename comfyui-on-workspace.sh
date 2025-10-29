#!/bin/bash

# Ensure we have /workspace in all scenarios
mkdir -p /workspace

SOURCE_DIR=/ComfyUI
TARGET_DIR=/workspace/ComfyUI

# Seed the workspace copy if it is missing; otherwise refresh git metadata/custom nodes without touching models
if [[ ! -d "${TARGET_DIR}" ]]; then
	cp -a "${SOURCE_DIR}" /workspace/
else
	if [[ ! -d "${TARGET_DIR}/.git" ]]; then
		cp -a "${SOURCE_DIR}/.git" "${TARGET_DIR}/"
	fi

	# Ensure bundled custom nodes exist while keeping user changes and models intact
	if [[ -d "${SOURCE_DIR}/custom_nodes" ]]; then
		mkdir -p "${TARGET_DIR}/custom_nodes"
		cp -an "${SOURCE_DIR}/custom_nodes/." "${TARGET_DIR}/custom_nodes/"

		for src_repo in "${SOURCE_DIR}/custom_nodes"/*; do
			[[ -d "${src_repo}" ]] || continue
			repo_name=$(basename "${src_repo}")
			dest_repo="${TARGET_DIR}/custom_nodes/${repo_name}"

			if [[ -d "${src_repo}/.git" && ! -d "${dest_repo}/.git" ]]; then
				cp -a "${src_repo}/.git" "${dest_repo}/"
			fi
		done
	fi
fi

# Replace the image copy with a symlink that points at the persistent workspace
rm -rf "${SOURCE_DIR}"
ln -s "${TARGET_DIR}" "${SOURCE_DIR}"

# Mark the workspace checkout and bundled repos as safe for git (prevents warnings when UID/GID differ on network storage)
if command -v git >/dev/null 2>&1; then
	git config --global --add safe.directory "${TARGET_DIR}" >/dev/null 2>&1 || true

	if [[ -d "${TARGET_DIR}/custom_nodes" ]]; then
		for repo_path in "${TARGET_DIR}/custom_nodes"/*; do
			[[ -d "${repo_path}/.git" ]] || continue
			git config --global --add safe.directory "${repo_path}" >/dev/null 2>&1 || true
		done
	fi
fi
