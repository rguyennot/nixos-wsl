{
  description = "NixOS-WSL Stable config with home-manager";
  
  # NixOS stable pour la base du système
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager pour la configuration utilisateur (shell, dotfiles, etc.)
    # https://nix-community.github.io/home-manager/index.xhtml
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Module pour gérer les secrets avec SOPS
    # https://github.com/Mic92/sops-nix
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, sops-nix, ... }@inputs:
    let
      system = "x86_64-linux";
      # Import de vars.nix pour pouvoir utiliser les variables plus bas
      vars = import ./vars.nix; 
    in {
      nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
        inherit system;
        # On passe les variables et les inputs aux modules système
        specialArgs = { inherit inputs vars; }; 
        
        modules = [
          ./hosts/wsl/configuration.nix

          # Modules de base pour NixOS-WSL
          nixos-wsl.nixosModules.default

          # Home Manager configuration
          home-manager.nixosModules.home-manager

          # Module pour SOPS (décommenter pour activer)
          # sops-nix.nixosModules.sops
            # Add sops settings...

          # Charge les modules personnalisés
          ./modules

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # Utilisation du fichier vars.nix
            home-manager.users."${vars.os_user}" = import ./home;
          }
        ];
      };
    };
}
