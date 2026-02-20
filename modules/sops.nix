# Manage by running `sops ~/nixos/config/secrets.yaml`

{ pkgs, ... }: # Ensure inputs is available if used

let
  # Import vars.nix pour utiliser les variables plus bas
  vars = import ../vars.nix; 
in

{
  environment.systemPackages = with pkgs; [
    sops
  ];

  sops = {
    defaultSopsFile = ../secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/${vars.os_user}/.config/sops/age/keys.txt";

    secrets.id_ed25519= {
        owner = vars.os_user;
        path = "/home/${vars.os_user}/.ssh/id_ed25519";
        mode = "0400";
    };
    secrets."id_ed25519.pub" = {
        owner = vars.os_user;
        path = "/home/${vars.os_user}/.ssh/id_ed25519.pub";
        mode = "0400";
    };
  };
}
