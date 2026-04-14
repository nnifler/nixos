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
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
          pkief.material-icon-theme
        ];
        userSettings = {
          "editor.formatOnSave" = true;
          "workbench.iconTheme" = "material-icon-theme";
          "explorer.confirmDragAndDrop" = false;
        };
      };
    };
  };
}
