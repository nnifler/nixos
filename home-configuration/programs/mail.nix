{
  config,
  lib,
  ...
}:

{
  config = lib.mkIf config.home-config.programs.mail.enable {
    programs.thunderbird = {
      enable = true;
      profiles.default = {
        withExternalGnupg = true;
        isDefault = true;
      };
    };

    accounts.email.accounts = {
      "Uni" = {
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
        gpg.key = "C442559039D0CDBF058390AFE2577B95A89FEE34";
      };
      "Gmail" = rec {
        primary = true;
        address = "finn.s.schubert@gmail.com";
        realName = "Finn Schubert";
        smtp = {
          tls.enable = true;
          host = "smtp.gmail.com";
          port = 465;
        };
        imap = {
          tls.enable = true;
          host = "imap.gmail.com";
          port = 993;
        };
        userName = address;
        thunderbird.enable = true;
        gpg.key = "C442559039D0CDBF058390AFE2577B95A89FEE34";
      };
    };
  };
}
