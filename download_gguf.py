from huggingface_hub import hf_hub_download

hf_hub_download(repo_id="city96/FLUX.1-dev-gguf", local_dir="/workspace/ComfyUI/models/unet" , filename="flux1-dev-Q8_0.gguf")
hf_hub_download(repo_id="city96/t5-v1_1-xxl-encoder-gguf", local_dir="/workspace/ComfyUI/models/clip" , filename="t5-v1_1-xxl-encoder-Q8_0.gguf")
hf_hub_download(repo_id="cocktailpeanut/xulf-dev", local_dir="/workspace/ComfyUI/models/vae" , filename="ae.sft")
hf_hub_download(repo_id="comfyanonymous/flux_text_encoders", local_dir="/workspace/ComfyUI/models/clip" , filename="clip_l.safetensors")

# Fill Model
hf_hub_download(repo_id="YarvixPA/FLUX.1-Fill-dev-gguf", local_dir="/workspace/ComfyUI/models/unet" , filename="flux1-fill-dev-Q8_0.gguf")

#Canny
hf_hub_download(repo_id="SporkySporkness/FLUX.1-Canny-dev-GGUF", local_dir="/workspace/ComfyUI/models/unet" , filename="flux1-canny-dev-fp16-Q8_0-GGUF.gguf")

#Redux
hf_hub_download(repo_id="second-state/FLUX.1-Redux-dev-GGUF", local_dir="/workspace/ComfyUI/models/unet" , filename="flux1-redux-dev-Q8_0.gguf")



# Depth
hf_hub_download(repo_id="SporkySporkness/FLUX.1-Depth-dev-GGUF", local_dir="/workspace/ComfyUI/models/unet" , filename="flux1-depth-dev-fp16-Q8_0-GGUF.gguf")

#Dep Lora

#für COntrolnet
#apt-get update && apt-get install ffmpeg libsm6 libxext6  -y