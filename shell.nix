{ pkgs ? import <nixpkgs> {} }:
with pkgs;
mkShell rec {
  name = "sd-env";
  LD_LIBRARY_PATH = lib.makeLibraryPath [
    gcc-unwrapped
    zlib
    libglvnd
    glib
    linuxPackages.nvidia_x11
  ];
  buildInputs = [
    python310
    python310Packages.pip
    python3Packages.virtualenv # run virtualenv .
    git
  ];
  # fixes xcb issues :
  QT_PLUGIN_PATH=${qt5.qtbase}/${qt5.qtbase.qtPluginPrefix}
}
