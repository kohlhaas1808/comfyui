from huggingface_hub import hf_hub_download

hf_hub_download(repo_id="city96/FLUX.1-dev-gguf", local_dir="/workspace/ComfyUI/models/unet" , filename="flux1-dev-Q8_0.gguf")
hf_hub_download(repo_id="city96/t5-v1_1-xxl-encoder-gguf", local_dir="/workspace/ComfyUI/models/clip" , filename="t5-v1_1-xxl-encoder-Q8_0.gguf")
hf_hub_download(repo_id="cocktailpeanut/xulf-dev", local_dir="/workspace/ComfyUI/models/vae" , filename="ae.sft")
hf_hub_download(repo_id="comfyanonymous/flux_text_encoders", local_dir="/workspace/ComfyUI/models/clip" , filename="clip_l.safetensors")

# Kontext
hf_hub_download(repo_id="bullerwins/FLUX.1-Kontext-dev-GGUF", local_dir="/workspace/ComfyUI/models/unet" , filename="flux1-kontext-dev-Q8_0.gguf")

