{
  config,
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
    gnome.enable = mkProgramOption "gnome configurations";
    mail.enable = mkProgramOption "mail";
  };

  imports = [
    ./firefox.nix
    ./gnome.nix
    ./mail.nix
  ];
}
