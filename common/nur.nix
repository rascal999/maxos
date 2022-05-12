{ ... }: {

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball {
      url = "https://github.com/nix-community/NUR/archive/f69cfc11e9b2312a294b8a6291de721d0d207819.zip";
      sha256 = "1hgawnbg8ahcck38bxlw2d1lsymazyrng3yfpqrxpsz5l1pijrsy";
    }) {
      inherit pkgs;
    };
  };

}
