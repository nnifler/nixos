{
  config,
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf config.home-config.programs.git.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Finn";
          email = "finn.schubert@stud.tu-darmstadt.de";
          signingKey = "${config.home.homeDirectory}/.ssh/github_sign_ed25519.pub";
          # What about allowedSignersFile? How is that necessary
        };
        init.defaultBranch = "main";
        gpg.format = "ssh";
        commit.gpgSign = true;
      };
    };
  };
}
