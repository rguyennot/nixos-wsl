# Configuration Starship prompt
{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    # Transforme la conf TOML directement en set Nix
    settings = builtins.fromTOML ''
      #------------------------------------------------------------------------------------------
      # Github setups share discussion : https://github.com/starship/starship/discussions/1107
      # Post: https://github.com/starship/starship/discussions/1107#discussioncomment-13327320
      #------------------------------------------------------------------------------------------
      "$schema" = 'https://starship.rs/config-schema.json'

      format = """
      [╭](fg:bold blue)$username\
      $directory\
      $git_branch\
      $git_commit\
      $git_state\
      $git_status\
      $rust\
      $golang\
      $nodejs\
      $php\
      $java\
      $kotlin\
      $kubernetes\
      $haskell\
      $python\
      $lua\
      $docker_context\
      $jobs\
      $battery\
      $time\
      $line_break$character"""

      palette = "nord"

      [palettes.nord]
      rosewater = "#f0c674"
      flamingo = "#cc6666"
      pink = "#b294bb"
      orange = "#de935f"
      red = "#cc6666"
      maroon = "#a54242"
      peach = "#d08770"
      yellow = "#f0c674"
      green = "#8abeb7"
      teal = "#8abeb7"
      sky = "#81a2be"
      sapphire = "#81a2be"
      blue = "#5e81ac"
      lavender = "#b48ead"
      text = "#d8dee9"
      subtext1 = "#e5e9f0"
      subtext0 = "#eceff4"
      overlay2 = "#4c566a"
      overlay1 = "#434c5e"
      overlay0 = "#3b4252"
      surface2 = "#2e3440"
      surface1 = "#2e3440"
      surface0 = "#2e3440"
      base = "#2e3440"
      mantle = "#3b4252"
      crust = "#434c5e"

      # Username Module
      [username]
      show_always = true
      style_user = "fg:blue"
      style_root = "fg:blue"
      format = "[ $user ]($style)"

      # Local IP Module
      [localip]
      ssh_only = false
      style = "fg:surface0"
      format = "[ $localipv4 ]($style)"
      disabled = false

      # Directory Module
      [directory]
      style = "fg:yellow"
      format = "[ $path ]($style)"
      truncation_length = 3
      truncation_symbol = "…/"

      # Time Module
      [time]
      #disabled = false
      time_format = "%R"
      style = "fg:peach"
      format = "[[  $time ](fg:purple)]($style)"

      # Line Break Module
      [line_break]
      disabled = false

      # Character Module
      [character]
      format = """
      [╰─$symbol](fg:bold blue) """
      success_symbol = "[](fg:bold blue)"
      #success_symbol = "[λ](fg:overlay1)"
      error_symbol = '[×](fg:bold red)'

      [kubernetes]
      format = '[$symbol $context $symbol (⎈ $namespace)]($style) '
      #style = "bright-green"
      style = "cyan bold"
      symbol = "⎈"
      disabled = false
      contexts = [
          { context_pattern = ".*int.*", style = "bright-green", symbol = "⎈"},
          { context_pattern = ".*iac.*", style = "brightgreen", symbol = "⎈"},
          { context_pattern = ".*horsprod.*", style = "bright-yellow", symbol = "⎈"},
          { context_pattern = ".*production.*", style = "bright-red", symbol = "⎈"},
      ]

      [helm]
      format = "via [⎈ $version](bold white) "

      [env_var.SOFTWARE_UPDATE_AVAILABLE]
      variable = "SOFTWARE_UPDATE_AVAILABLE"
      format = "[$env_value]($style)"
      default = ""
      style = "cyan"

      [env_var.DOTFILES_UPDATE_AVAILABLE]
      variable = "DOTFILES_UPDATE_AVAILABLE"
      format = "[$env_value]($style)"
      default = ""
      style = "cyan"
    '';
  };
}
