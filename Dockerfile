# Verwende ein Basis-Image mit CUDA-Unterstützung
FROM nvidia/cuda:12.4.0-devel-ubuntu22.04

# Umgebungsvariablen für Python und CUDA
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

# Update und grundlegende Abhängigkeiten installieren
RUN apt-get update && apt-get install -y \
    wget \
    git \
    build-essential \
    curl \
    ca-certificates \
    libjpeg-dev \
    libpng-dev \
    && rm -rf /var/lib/apt/lists/*

# Miniconda installieren
RUN curl -fsSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh && \
    bash miniconda.sh -b -p /opt/conda && \
    rm miniconda.sh && \
    /opt/conda/bin/conda clean -a -y

# Python-Umgebung initialisieren und Abhängigkeiten installieren
RUN conda install -y python=3.10 pip && conda clean -afy

# Installiere PyTorch mit CUDA 12.4
RUN pip install --no-cache-dir torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu124

# comfyUI klonen und installieren
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /comfyui
WORKDIR /comfyui

# Installiere die Hauptabhängigkeiten
RUN pip install --no-cache-dir -r requirements.txt

# JupyterLab installieren
RUN pip install --no-cache-dir jupyterlab

# Ports für JupyterLab und ComfyUI freigeben
EXPOSE 8888 8188

# JupyterLab-Server und ComfyUI gleichzeitig starten
CMD ["bash", "-c", "jupyter lab --ip=0.0.0.0 --allow-root & python main.py"]
