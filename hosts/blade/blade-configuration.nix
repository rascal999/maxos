{ config, pkgs, lib, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
{
  networking.hostName = "blade";
  hardware.nvidia.modesetting.enable = true;
  hardware.opengl.enable = true;

  environment.systemPackages = with pkgs; [
    nvidia-offload
    openrazer-daemon
    razergenie
  ];

  # X11 / i3
  services.xserver = {
    enable = true;
    desktopManager.plasma5.enable = true;
    displayManager = {
      defaultSession = "plasma";
      lightdm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = "user";
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.prime = {
    offload.enable = true;

    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
    intelBusId = "PCI:0:2:0";

    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
    nvidiaBusId = "PCI:1:0:0";
  };
}
