# Outils CLI pour le développement
{ config, pkgs, ... }:

{
  # Importation des modules
  imports = [
    ./zsh.nix
    ./starship.nix
    ./k8s.nix
    ./vscode.nix
    # ./sops.nix  (décommenter pour activer)
    # => dans la phase building sops-install-secrets-0.0.1, le disk usage grime à 100% !) 
  ];
}