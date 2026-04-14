{
  config,
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf config.home-config.programs.mail.enable {
    programs.thunderbird = {
      enable = true;
      profiles.default = {
        isDefault = true;
      };
    };

    accounts.email.accounts = {
      "Uni" = {
        primary = true;
        address = "finn.schubert@stud.tu-darmstadt.de";
        realName = "Finn Schubert";
        smtp = {
          tls.enable = true;
          host = "smtp.tu-darmstadt.de";
          port = 465;
        };
        imap = {
          tls.enable = true;
          host = "imap.stud.tu-darmstadt.de";
          port = 993;
        };
        userName = "fs45bupo";
        thunderbird.enable = true;
      };
    };
  };
}
