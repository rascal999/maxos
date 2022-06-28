let
  # Don't forget to `a-agenix --rekey` when updating public keys
  host_blueboy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGfxGYgiWarGdkmG3K+A3y/QR7vWVqddmEOscrory7Vf";
  host_galaxy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP4ocz0cS0v/JmgnyvqfMMYGaaAYflJCy2AJthWA6Met";
  host_rig = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFujWqx7S6oMZf8G4SvP3+LkKjxD9ZwyCBJVqmtUl/x7";
  host_rog = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAOpZ0o7uDjhBM2zTfrH8O964mQcqVVjqEckbLr1r2Jg";
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
