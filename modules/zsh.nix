# Configuration Zsh avec Oh My Zsh
{ config, pkgs, ... }:

{
  # Définir Zsh comme shell par défaut
  users.defaultUserShell = pkgs.zsh;

  # Configuration de Zsh avec Oh My Zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = false;

    # Active la complétion
    interactiveShellInit = ''
      # Activer la complétion pour les alias
      setopt COMPLETE_ALIASES
      # Charger le menu de sélection interactif
      zstyle ':completion:*' menu select
      
      # Grouper les résultats par catégorie (fichiers, répertoires, etc.)
      zstyle ':completion:*' group-name ""
      zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
      
      # Rendre la complétion insensible à la casse et tolérante aux erreurs
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
    '';

    # Oh My Zsh
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";  # ou "agnoster", "powerlevel10k", etc.
      plugins = [ "git" "sudo" "docker" "kubectl" "fzf" "zoxide" ];
    };

    # Aliases personnalisés
    shellAliases = {
      ff = "fastfetch";
      # NixOS
      rebuild = "sudo nixos-rebuild switch --flake /mnt/c/Users/<user>/Nixos-WSL#wsl";
      gc = "sudo nix-collect-garbage -d";
      # Directory (eza)
      history = "atuin search";
      l  = "eza -bGF --header --git --color=always --group-directories-first --icons";
      ls = "eza --color=always --group-directories-first --icons";
      ll = "eza -l --octal-permissions --group-directories-first --icons";
      la = "eza --long --all --group --group-directories-first --icons";
      lt = "eza --tree --level=2 --icons"; # tree
      md = "mkdir -p";
      # Editors
      vi = "nvim";
      vim = "nvim";
      # KubeCM
      kc = "kubecm";
      # Velero
      v = "velero";
    };
  };

  # Paquets requis pour les plugins Oh My Zsh
  environment.systemPackages = with pkgs; [
    zoxide           # requis pour le plugin zoxide
    kubectl          # requis pour le plugin kubectl
  ];
}