let
  # Don't forget to `a-agenix --rekey` when updating public keys
  user_rig = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFujWqx7S6oMZf8G4SvP3+LkKjxD9ZwyCBJVqmtUl/x7";
  user_blueboy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGfxGYgiWarGdkmG3K+A3y/QR7vWVqddmEOscrory7Vf";
  user_rog = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAOpZ0o7uDjhBM2zTfrH8O964mQcqVVjqEckbLr1r2Jg";
  users = [ user_rig user_blueboy user_rog ];
in
{
  "secret.age".publicKeys = users;
  "wireguard-key.age".publicKeys = users;
  "wireguard-password.age".publicKeys = users;
}
