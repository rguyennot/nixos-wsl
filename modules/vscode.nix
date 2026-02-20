# Compatibilité VSCode Remote et binaires dynamiques
{ config, pkgs, ... }:

{
  # nix-ld permet d'exécuter des binaires non-Nix (VSCode, etc.)
  programs.nix-ld = {
    enable = true;
    # Bibliothèques communes requises par VSCode et autres outils
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      openssl
      curl
      glib
      util-linux
      icu
      libunwind
      libuuid
      # Pour VSCode
      xorg.libX11
      xorg.libXcursor
      xorg.libXrandr
    ];
  };
}