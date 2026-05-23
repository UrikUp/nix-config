{ inputs }: [
  inputs.nur.overlays.default
  # inputs.nix-cachyos-kernel.overlays.default
  (_: prev: {
    openldap = prev.openldap.overrideAttrs {
      doCheck = !prev.stdenv.hostPlatform.isi686;
    };
  })
]
