let
  # Don't forget to `a-agenix --rekey` when updating public keys
  host_rig = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFujWqx7S6oMZf8G4SvP3+LkKjxD9ZwyCBJVqmtUl/x7";
  host_blueboy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGfxGYgiWarGdkmG3K+A3y/QR7vWVqddmEOscrory7Vf";
  host_rog = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAOpZ0o7uDjhBM2zTfrH8O964mQcqVVjqEckbLr1r2Jg";
  hosts = [ host_rig host_blueboy host_rog ];
in
{
  "ddclient-password.age".publicKeys = hosts;
  "secret.age".publicKeys = hosts;
  "wireguard-env.age".publicKeys = hosts;
}
