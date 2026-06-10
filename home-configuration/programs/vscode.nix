{
  config,
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf config.home-config.programs.vscode.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      profiles.default = {
        extensions = with pkgs.vscode-marketplace; [
          jnoortheen.nix-ide
          pkief.material-icon-theme
          dnut.rewrap-revived
        ];
        userSettings = {
          "editor.rulers" = [ 80 ];
          "editor.formatOnSave" = true;
          "workbench.iconTheme" = "material-icon-theme";
          "explorer.confirmDragAndDrop" = false;
        };
      };
    };

    home.packages = with pkgs; [
      nixd
    ];
  };
}
