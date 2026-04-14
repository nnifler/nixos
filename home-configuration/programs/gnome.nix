{
  config,
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf config.home-config.programs.gnome.enable {
    home.packages = with pkgs; [
      gnome-themes-extra
    ];

    dconf.settings = {
      "org/gnome/shell" = {
        favorite-apps = [
          "firefox.desktop"
          "spotify.desktop"
        ];
      };
      "org/gnome/desktop/interface" = {
        gtk-theme = "Adwaita-dark";
        accent-color = "purple";
        color-scheme = "prefer-dark";
      };
    };
  };
}
