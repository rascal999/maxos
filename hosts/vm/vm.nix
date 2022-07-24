{ config, pkgs, lib, ... }:

{
  virtualbox = {
    extraDisk = {
      label = "test";
      mountPoint = "/test";
      size = 10 * 1024;
    };
  };
}

