{ config, pkgs, lib, ... }: {
  services.dhcpd4 = {
    enable = true;
    interfaces = [ "eno1" ];
    extraConfig = ''
      option domain-name-servers 1.1.1.1;
      option subnet-mask 255.255.255.0;

      subnet 192.168.0.0 netmask 255.255.255.0 {
        authoritative;
        default-lease-time 3600;
        max-lease-time 3600;
        option broadcast-address 192.168.0.255;
        option routers 192.168.0.1;
        interface eno1;
        range 192.168.0.20 192.168.0.200;
        next-server 192.168.0.10;
        filename "netboot.xyz.efi";
      }
    '';
  };
}
