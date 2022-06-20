let
  # Don't forget to `a-agenix --rekey` when updating public keys
  user_rig = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOOZSriO6sNxrA55MGpuL/rg1Uej0m+/S76pa+Iw2AT7";
  user_blueboy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAIHvP/ols9rRoSXH8/vxZ8Gn5WeuuYLDaDV5SKgJoQT";
  user_rog = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG/bKOQ4P5Rz8qZciHunVhpcnX1lwyogNhE1YUqidM44";
  users = [ user_rig user_blueboy user_rog ];
in
{
  "secret.age".publicKeys = users;
  "wireguard-key.age".publicKeys = users;
  "wireguard-password.age".publicKeys = users;
}
