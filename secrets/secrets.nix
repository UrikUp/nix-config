let
  urik = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFZ5OGuQvxV2faWMHcfRgaPHQ1rmTi5w2/ju6pSWcoZj my vps key";
in {
  "password.age".publicKeys = [ urik ];
}
