let
  # Don't forget to `a-agenix --rekey` when updating public keys
  host_blueboy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGfxGYgiWarGdkmG3K+A3y/QR7vWVqddmEOscrory7Vf";
  host_galaxy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP4ocz0cS0v/JmgnyvqfMMYGaaAYflJCy2AJthWA6Met";
  host_rig = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBEHhsgw+RqLwv8HjBuC5hNpfc+KTBUypsK8yw1Ay4XP";
  host_rog = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJzSkIhetIXA8SWm95Ewq10rqZvEYr+bwrjv2AWskORL";
  hosts = [ host_blueboy host_galaxy host_rig host_rog ];
in
{
  "api-nist.age".publicKeys = hosts;
  "api-shodan.age".publicKeys = hosts;
  "api-telegram.age".publicKeys = hosts;
  "api-virustotal.age".publicKeys = hosts;
  "password-ddclient.age".publicKeys = hosts;
  "secret.age".publicKeys = hosts;
  "vpn-mullvad.age".publicKeys = hosts;
  "wireguard-env.age".publicKeys = hosts;
}
