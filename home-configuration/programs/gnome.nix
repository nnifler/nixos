{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.home-config.programs.gnome.no-sleep = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Disables Automatic Suspend";
  };

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
        show-battery-percentage = true;
      };
      "org/gnome/desktop/peripherals/touchpad" = {
        disable-while-typing = false;
      };
      "org/gnome/settings-daemon/plugins/power" = lib.mkIf config.home-config.programs.gnome.no-sleep {
        sleep-inactive-ac-type = "nothing";
      };
    };
  };
}
