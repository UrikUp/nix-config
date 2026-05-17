{ config, pkgs, ... }:

{
  # Ollama service
  services.ollama = {
    enable = true;
    # acceleration = null;  # CPU, no GPU
  };
}
