{
  config,
  lib,
  pkgs,
  ...
}:
let
  forgemc = pkgs.callPackage ../packaged/forgemc {
    links = [
      "https://cdn.modrinth.com/data/2cMuAZAp/versions/XoIASRVU/alexsmobs-1.22.9.jar"
      "https://cdn.modrinth.com/data/ulloLmqG/versions/S9tNKT5R/another_furniture-forge-1.20.1-3.0.4.jar"
      "https://cdn.modrinth.com/data/XxWD5pD3/versions/7KVs6HMQ/appliedenergistics2-forge-15.4.10.jar"
      "https://cdn.modrinth.com/data/t1VgucWo/versions/hfQ3VSpz/chunkloaders-1.2.9-forge-mc1.20.1.jar"
      "https://cdn.modrinth.com/data/jJfV67b1/versions/oD1qDb1C/citadel-2.6.2-1.20.1.jar"
      "https://cdn.modrinth.com/data/UT2M39wf/versions/ibcPwZZT/copycats-3.0.2+mc.1.20.1-forge.jar"
      "https://cdn.modrinth.com/data/rLLJ1OZM/versions/6rPDKAT8/coroutil-forge-1.20.1-1.3.7.jar"
      "https://cdn.modrinth.com/data/LNytGWDc/versions/JjPQsQVw/create-1.20.1-6.0.6.jar"
      "https://cdn.modrinth.com/data/JWGBpFUP/versions/E8bB0Vws/create_enchantment_industry-1.3.3-for-create-6.0.6.jar"
      "https://cdn.modrinth.com/data/kU1G12Nn/versions/9LgyB6Yb/createaddition-1.20.1-1.3.3.jar"
      "https://cdn.modrinth.com/data/sMvUb4Rb/versions/e9gaSRMd/createdeco-2.0.3-1.20.1-forge.jar"
      "https://cdn.modrinth.com/data/R2OftAxM/versions/8rPF1pFi/FarmersDelight-1.20.1-1.2.9.jar"
      "https://cdn.modrinth.com/data/8BmcQJ2H/versions/aVW7Z5da/geckolib-forge-1.20.1-4.8.2.jar"
      "https://cdn.modrinth.com/data/s3dmwKy5/versions/pYPZ5MNI/GlitchCore-forge-1.20.1-0.0.1.1.jar"
      "https://cdn.modrinth.com/data/RYtXKJPr/versions/q9kZE5Xo/gravestone-forge-1.20.1-1.0.35.jar"
      "https://cdn.modrinth.com/data/Ck4E7v7R/versions/9YGnKYDF/guideme-20.1.14.jar"
      "https://cdn.modrinth.com/data/nvQzSEkH/versions/LecuGude/Jade-1.20.1-Forge-11.13.2.jar"
      "https://cdn.modrinth.com/data/xuDOzCLy/versions/AvIT9ADi/JadeAddons-1.20.1-Forge-5.5.0.jar"
      "https://cdn.modrinth.com/data/u6dRKJwZ/versions/zzpNSbJZ/jei-1.20.1-forge-15.20.0.116.jar"
      "https://cdn.modrinth.com/data/F8BQNPWX/versions/Cx95h37p/naturalist-5.0pre3+forge-1.20.1.jar"
      "https://cdn.modrinth.com/data/2gvRmQXx/versions/n947JjJH/radium-mc1.20.1-0.12.4+git.26c9d8e.jar"
      "https://cdn.modrinth.com/data/e0bNACJD/versions/YXTfAkOf/SereneSeasons-forge-1.20.1-9.1.0.2.jar"
      "https://cdn.modrinth.com/data/TyCTlI4b/versions/CC5uOKlH/sophisticatedbackpacks-1.20.1-3.24.10.1404.jar"
      "https://cdn.modrinth.com/data/nmoqTijg/versions/TeINP0pI/sophisticatedcore-1.20.1-1.2.106.1235.jar"
      "https://cdn.modrinth.com/data/ZzjhlDgM/versions/ezVPFGKZ/Steam_Rails-1.6.13-alpha+forge-mc1.20.1.jar"
      "https://cdn.modrinth.com/data/guitPqEi/versions/8raubcF4/StorageDrawers-forge-1.20.1-12.14.3.jar"
      "https://cdn.modrinth.com/data/LN9BxssP/versions/ZKor79dR/supermartijn642configlib-1.1.8-forge-mc1.20.jar"
      "https://cdn.modrinth.com/data/rOUBggPv/versions/VWJoqHin/supermartijn642corelib-1.1.18-forge-mc1.20.1.jar"
      "https://cdn.modrinth.com/data/8oi3bsk5/versions/WeYhEb5d/Terralith_1.20.x_v2.5.4.jar"
      "https://cdn.modrinth.com/data/AtB5mHky/versions/GpiXMxvP/watut-forge-1.20.1-1.2.3.jar"
      "https://cdn.modrinth.com/data/uCdwusMi/versions/lC6CwqPp/DistantHorizons-2.4.5-b-1.20.1-fabric-forge.jar"
    ];
  };
in
{
  config = lib.mkIf config.server-config.minecraft.enable {
    # nixpkgs.config.allowUnfreePredicate = pkg:
    #   builtins.elem (lib.getName pkg) [
    #     "minecraft-server"
    #   ];

    services.minecraft-server = {
      enable = true;
      eula = true;
      package = forgemc;
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

    environment.systemPackages = [
      forgemc
    ];
  };
}
