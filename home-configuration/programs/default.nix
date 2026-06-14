{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  mkProgramOption =
    name:
    mkOption {
      type = types.bool;
      default = config.home-config.programs.enable;
      description = "Enables" ++ name;
    };
in
{
  options.home-config.programs.enable = lib.mkOption {
    type = types.bool;
    default = false;
    description = "Program options for home configuration";
  };

  options.home-config.programs = {
    firefox.enable = mkProgramOption "firefox";
    git.enable = mkProgramOption "git";
    gnome.enable = mkProgramOption "gnome configurations";
    mail.enable = mkProgramOption "mail";
    terminal.enable = mkProgramOption "terminal";
    vscode.enable = mkProgramOption "vscode";
  };

  imports = [
    ./firefox.nix
    ./git.nix
    ./gnome.nix
    ./mail.nix
    ./terminal.nix
    ./vscode.nix
  ];

  config = lib.mkIf config.home-config.programs.enable {
    # nixpkgs.config.allowUnfreePredicate =
    #   pkg:
    #   builtins.elem (lib.getName pkg) [
    #     "obsidian"
    #   ];

    home.packages = with pkgs; [
      prismlauncher
      spotify
      signal-desktop
      # bitwarden-desktop # Wait for update to newer electron
      emacs # TODO: emacs config via home-manager
      nixfmt
      xournalpp
      obsidian
      texliveFull
      gnupg
    ];
  };
}
