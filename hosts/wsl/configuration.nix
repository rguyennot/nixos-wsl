{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
in

{
  system.stateVersion = "25.11";

  networking.hostName = "nixos-wsl";

  ####################################
  # WSL Core
  ####################################

  wsl = {
    enable = true;
    defaultUser = vars.os_user;

    wslConf = {
      automount.root = "/mnt";
      automount.options = "metadata,umask=22,fmask=11";

      network.generateHosts = true;
      network.generateResolvConf = true;

      interop.appendWindowsPath = false;
    };
  };

  ####################################
  # User
  ####################################

  users.users.${vars.os_user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
  };

  security.sudo.wheelNeedsPassword = false;

  ####################################
  # Default packages
  ####################################

  # Autorise les paquets non-free
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    htop
    unzip
    tree
    vim
    bzip2
    gcc
  ];

  ####################################
  # Locale / timezone
  ####################################

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";

  ####################################
  # Nix settings
  ####################################

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    # Augmente la taille du tampon à 256 Mo ( 64 Mo par défaut)
    download-buffer-size = 256000000;
  };

  ####################################
  # Faster rebuilds
  ####################################

  documentation.enable = false;
}
