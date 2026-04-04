{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.server-config.minecraft.enable {
    # nixpkgs.config.allowUnfreePredicate = pkg:
    #   builtins.elem (lib.getName pkg) [
    #     "minecraft-server"
    #   ];

    services.minecraft-server = {
      enable = true;
      eula = true;
      package = pkgs.papermc;
      declarative = true;
      openFirewall = true;
      
      whitelist = {
        LordFrostwolf = "aa84cf2a-f432-41c5-95bd-2d89b600a859";
        Lastand26 = "e8741330-9b02-453e-960a-79e20de198e6";
      };

      serverProperties = {
        white-list = true;
        allow-flight = true;
        motd = "Creating Mess";
      };

      jvmOpts = "-Xms4092M -Xmx4092M";
    };
  };
}