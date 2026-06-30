{
  config,
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf config.home-config.programs.vscode.enable {
    programs.vscodium = {
      enable = true;
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
          "workbench.colorTheme" = "Dark Modern";
          "nix.enableLanguageServer" = true;
        };
      };
    };

    home.packages = with pkgs; [
      nixfmt
      nixd
    ];

    programs.vim.enable = true;
  };
}
