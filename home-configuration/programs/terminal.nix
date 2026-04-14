{
  config,
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf config.home-config.programs.terminal.enable {
    programs.zsh = {
      enable = true;

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
      };

      shellAliases = {
        nix-shell = "nix-shell --run zsh";
        nix-develop = "nix develop -c zsh";
        rebuild-switch = "sudo nixos-rebuild switch --flake /home/finns/.nixos";
      };
    };

    programs.starship = {
      enable = true;
    };
  };
}
