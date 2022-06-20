let
  user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOOZSriO6sNxrA55MGpuL/rg1Uej0m+/S76pa+Iw2AT7";
  users = [ user ];
in
{
  "secret.age".publicKeys = [ user ];
}
