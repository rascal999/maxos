{ ... }: {

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball {
      url = "https://github.com/nix-community/NUR/commit/f69cfc11e9b2312a294b8a6291de721d0d207819";
      sha256 = "f69cfc11e9b2312a294b8a6291de721d0d207819";
    ) {
      inherit pkgs;
    };
  };

}
