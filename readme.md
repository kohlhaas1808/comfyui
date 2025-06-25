# do not use this testing repo!


# Dockerfile für ComfyUI mit Manager und JupyterLab

Dieses Dockerfile erstellt ein Image, das ComfyUI (inklusive Manager) und JupyterLab mit CUDA-Unterstützung enthält.

## Inhalte
- **CUDA 12.2**: Für GPU-Beschleunigung.
- **ComfyUI**: Open-Source-Bildgenerierungs-Framework.
- **ComfyUI Manager**: Ermöglicht das einfache Verwalten von Modulen und Erweiterungen.
- **JupyterLab**: Für Notebooks und interaktive Entwicklung.
 
## Verwendung
### Builden des Images
```bash
docker build -t comfyui-jupyter .
