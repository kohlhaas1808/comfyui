from pathlib import Path
from urllib.parse import urlparse
from huggingface_hub import hf_hub_download


def download_from_hf_url(url: str, outdir: str = ".", token: str | None = None) -> str:
    """
    Nimmt eine HuggingFace-URL (mit /resolve/ oder /blob/) und lädt die Datei
    mit huggingface_hub nach outdir herunter.
    
    Gibt den lokalen Pfad zur Datei zurück.
    """
    parsed = urlparse(url)
    if parsed.netloc not in ("huggingface.co", "www.huggingface.co"):
        raise ValueError(f"Keine HuggingFace-URL: {url}")

    parts = parsed.path.strip("/").split("/")

    # Erwartet:
    # [user_or_org, repo, 'resolve'|'blob', rev, <file...>]
    if len(parts) < 5 or parts[2] not in ("resolve", "blob"):
        raise ValueError(f"Unerwartetes URL-Format: {url}")

    user_or_org, repo, _kind, rev, *file_parts = parts
    repo_id = f"{user_or_org}/{repo}"
    filename = "/".join(file_parts)
    revision = rev

    if not filename:
        raise ValueError(f"Keine Datei im URL gefunden: {url}")

    outdir_path = Path(outdir).resolve()
    outdir_path.mkdir(parents=True, exist_ok=True)

    local_path = hf_hub_download(
        repo_id=repo_id,
        filename=filename,
        revision=revision,
        token=token,
        local_dir=str(outdir_path),
        local_dir_use_symlinks=False,
    )

    return local_path

# Diffusion Models
download_from_hf_url(url="https://huggingface.co/Kijai/WanVideo_comfy_fp8_scaled/resolve/main/Wan22Animate/Wan2_2-Animate-14B_fp8_e4m3fn_scaled_KJ.safetensors",outdir="/workspace/ComfyUI/models/diffusion_models")
download_from_hf_url(url="https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_animate_14B_bf16.safetensors",outdir="/workspace/ComfyUI/models/diffusion_models")
 #Loras
download_from_hf_url(url="https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Lightx2v/lightx2v_I2V_14B_480p_cfg_step_distill_rank64_bf16.safetensors",outdir="/workspace/ComfyUI/models/loras")
download_from_hf_url(url="https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/LoRAs/Wan22_relight/WanAnimate_relight_lora_fp16.safetensors",outdir="/workspace/ComfyUI/models/loras")

 #Clip Vision
download_from_hf_url(url="https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/clip_vision/clip_vision_h.safetensors",outdir="/workspace/ComfyUI/models/clip_vision")
 #VAE
download_from_hf_url(url="https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors",outdir="/workspace/ComfyUI/models/vae")
 #text_encoders
download_from_hf_url(url="https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors",outdir="/workspace/ComfyUI/models/text_encoders")






