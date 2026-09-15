{ config, lib, pkgs, ... }:

# MaxOS Packer Tool Module (Layer 4 - Applications)
#
# Provides HashiCorp Packer for building machine images, following
# layered architecture conventions (docs/layered-architecture.md).

with lib;

let
  cfg = config.maxos.tools.packer;

  dependenciesValid =
    config.maxos.user.enable or true;

in {
  options.maxos.tools.packer = {
    enable = mkEnableOption "Packer — HashiCorp machine image builder";

    enablePlugins = mkOption {
      type = types.bool;
      default = false;
      description = "Provision plugin cache directory and shell aliases";
    };

    configDir = mkOption {
      type = types.str;
      default = "/home/${config.maxos.user.name}/.packer.d";
      description = "Packer configuration and plugin cache directory";
    };
  };

  config = mkIf (cfg.enable && dependenciesValid) {
    assertions = [
      {
        assertion = dependenciesValid;
        message = "MaxOS packer tool requires user module to be enabled";
      }
    ];

    environment.systemPackages = with pkgs; [
      packer
    ];

    systemd.tmpfiles.rules = mkIf cfg.enablePlugins [
      "d ${cfg.configDir} 0755 ${config.maxos.user.name} users -"
      "d ${cfg.configDir}/plugins 0755 ${config.maxos.user.name} users -"
    ];

    environment.variables = mkIf cfg.enablePlugins {
      PACKER_PLUGIN_PATH = "${cfg.configDir}/plugins";
    };

    environment.shellInit = mkIf cfg.enablePlugins ''
      alias pi='packer init'
      alias pb='packer build'
      alias pv='packer validate'
      alias pf='packer fmt'
    '';
  };
}