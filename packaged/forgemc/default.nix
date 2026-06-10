{
  pkgs,
  lib,
  fetchurl,
  stdenvNoCC,
  makeWrapper,
  links,
}:
let
  jre = pkgs.javaPackages.compiler.openjdk21.headless;
  py = pkgs.python3.withPackages (
    python-pkgs: with python-pkgs; [
      requests
    ]
  );

  forgeversion = "1.20.1-47.4.10";
  minecraft-dir = "/var/lib/minecraft";
  mod_links_file = builtins.toFile "mod_links" (builtins.concatStringsSep "\n" links);

  pre_server_script = ''
    EOF
    if [ ! -f ${minecraft-dir}/libraries/net/minecraftforge/forge/${forgeversion}/unix_args.txt ]; then
      rm -rf ${minecraft-dir}/libraries
      ${lib.getExe jre} -jar $out/share/forgemc/forge-installer.jar --installServer
      mkdir ${minecraft-dir}/mods
    fi
    ${lib.getExe py} $out/share/forgemc/mod_fetcher.py
    EOF
  '';
in
stdenvNoCC.mkDerivation {
  pname = "forgemc";
  version = forgeversion;
  dontUnpack = true;

  src = fetchurl {
    url = "https://maven.minecraftforge.net/net/minecraftforge/forge/${forgeversion}/forge-${forgeversion}-installer.jar";
    hash = "sha256-GRJ2C0y2uAPYqCbeYDyQdrHacewnZemh+MHKePZSeOM=";
  };

  nativeBuildInputs = [
    makeWrapper
  ];

  # makeWrapper ${lib.getExe jre} "$out/bin/setup-forge" \
  #   --run "cd ${minecraft-dir}" \
  #   --append-flags "-jar $out/share/forgemc/forge-installer.jar --installServer"
  # might need to add to setup-forge to delete existing libraries folder
  installPhase = ''
    mkdir -p $out/share/forgemc
    cp $src $out/share/forgemc/forge-installer.jar

    cp ${mod_links_file} $out/share/forgemc/mod_links
    cp ${./mod_fetcher.py} $out/share/forgemc/mod_fetcher.py

    cat > $out/share/forgemc/pre_server.sh << ${pre_server_script}

    chmod +x $out/share/forgemc/pre_server.sh

    makeWrapper ${lib.getExe jre} "$out/bin/minecraft-server" \
      --run "$out/share/forgemc/pre_server.sh" \
      --append-flags "@${minecraft-dir}/libraries/net/minecraftforge/forge/${forgeversion}/unix_args.txt nogui"
  '';
}
