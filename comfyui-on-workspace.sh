#!/bin/bash

# Ensure we have /workspace in all scenarios
mkdir -p /workspace

SOURCE_DIR=/ComfyUI
PERSIST_ROOT=/workspace
TARGET_DIR=${PERSIST_ROOT}/ComfyUI

mkdir -p "${TARGET_DIR}"

# Persist only selected directories so code stays in the container image
PERSIST_SUBDIRS=("models" "input" "output" "user" "custom_nodes")

for subdir in "${PERSIST_SUBDIRS[@]}"; do
	src_path="${SOURCE_DIR}/${subdir}"
	dst_path="${TARGET_DIR}/${subdir}"

	if [[ -d "${src_path}" ]]; then
		if [[ ! -e "${dst_path}" ]]; then
			cp -a "${src_path}" "${dst_path}"
		fi
	else
		mkdir -p "${dst_path}"
	fi

	# Always ensure the destination exists before linking
	mkdir -p "${dst_path}"

	rm -rf "${src_path}"
	ln -s "${dst_path}" "${src_path}"
done

# If git is available, mark persisted custom node repositories as safe
if command -v git >/dev/null 2>&1 && [[ -d "${TARGET_DIR}/custom_nodes" ]]; then
	for repo_path in "${TARGET_DIR}/custom_nodes"/*; do
		[[ -d "${repo_path}/.git" ]] || continue
		git config --global --add safe.directory "${repo_path}" >/dev/null 2>&1 || true
	done
fi
