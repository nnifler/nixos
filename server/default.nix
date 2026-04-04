{
  config,
  lib,
  ...
}:
with lib; 
let
  mkServerOption =
    name:
    mkOption {
      type = types.bool;
      default = config.server-config.enable;
      description = "Enables" ++ name;
    };
in
{
  options.server-config.enable = lib.mkOption {
    type = types.bool;
    default = false;
    description = "Options for a server";
  };

  options.server-config = {
    minecraft.enable = mkServerOption "minecraft server";
  };

  imports = [
    ./minecraft.nix
  ];
}