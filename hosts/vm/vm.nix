{ config, pkgs, lib, ... }:

{
  virtualisation = {
    extraDisk = {
      label = "test";
      mountPoint = "/test";
      size = 10 * 1024;
    };
  };
}

