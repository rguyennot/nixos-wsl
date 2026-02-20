{ config, pkgs, ... }:

let
  vars = import ../vars.nix;
in

{
  home.username = vars.os_user;
  home.homeDirectory = "/home/${vars.os_user}";

  # Ne pas modifier cette valeur, elle correspond à la version 
  # de home-manager lors de ta première installation.
  home.stateVersion = "25.11"; 

  # Paquets spécifiques à l'utilisateur
  home.packages = with pkgs; [
    bat
    jq
    yq
    git-lfs
    ripgrep
    eza
    fastfetch
    atuin
    pre-commit
    age
    sops
    direnv
    pipenv
    tmux
    screen
  ];

  fonts = { fontconfig.enable = true; };

  # Configuration de Git via home-manager
  programs.git = {
    enable = true;
    settings.user.name = vars.vcs_user;
    settings.user.email = vars.vcs_email;
  };

  # Configuration d'Atuin via home-manager
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      inline_height = 25;
      invert = true;
      style = "full";
    };
    flags = [ "--disable-up-arrow" ];
  };

  # On active le module fzf pour gérer les options globales
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;  # Si vous utilisez Zsh
    # Personnalisation de la palette de couleurs FZF_DEFAULT_OPTS
    defaultOptions = [
      # "--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'"
      "--color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1"
      "--color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1"
      "--color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac"
      "--color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b"
    ];
  };

  programs.neovim = {
    enable = true;
    # On installe le plugin via la liste des paquets nixpkgs
    plugins = with pkgs.vimPlugins; [
      nord-nvim  # C'est le nom exact du thème de shaunsingh dans Nix
    ];
    # On active le thème via une configuration Lua
    extraLuaConfig = ''
      -- Configuration optionnelle (voir doc du plugin)
      vim.g.nord_contrast = true
      vim.g.nord_borders = false
      vim.g.nord_disable_background = false
      vim.g.nord_italic = true

      -- Charger le thème
      require('nord').set()
    '';
  };

  programs.home-manager.enable = true;
}
