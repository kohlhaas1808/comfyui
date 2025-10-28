#!/usr/bin/env bash
set -Eeuo pipefail

SRC="/ComfyUI"            # Container-Pfad
DST="/workspace/ComfyUI"  # Persistenter Workspace (Netzpfad)

# Workspace-Basis sichern
mkdir -p /workspace

# Zielordner existiert? So lassen. Sonst LEER anlegen (kein Kopieren!).
[[ -d "$DST" ]] || mkdir -p "$DST"

# /ComfyUI freimachen (nur wenn kein Mountpoint), damit der Symlink gesetzt werden kann
if [[ -e "$SRC" && ! -L "$SRC" ]]; then
  if command -v mountpoint >/dev/null 2>&1 && mountpoint -q "$SRC"; then
    printf '[WARN] %s ist ein Mountpoint – Symlink wird nicht gesetzt.\n' "$SRC"
    exit 0
  fi
  rm -rf --one-file-system "$SRC"
fi

# Nur verlinken – keinerlei Datenübernahme
ln -sfn "$DST" "$SRC"
printf '[INFO] %s -> %s\n' "$SRC" "$DST"