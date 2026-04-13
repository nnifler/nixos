{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    policies = {
      DisplayBookmarksToolbar = "always";
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
    };
    profiles.default = {
      search = {
        engines = {
          merriam-webster = {
            name = "Merriam Webster";
            urls = [ { template = "https://www.merriam-webster.com/dictionary/{searchTerms}"; } ];
            icon = "https://www.merriam-webster.com/favicon.svg";
            definedAliases = [ "!mw" ];
          };
        };
        force = true;
      };
      settings = {
        "browser.translations.automaticallyPopup" = false;
        "browser.translations.neverTranslateLanguages" = "de";
      };
    };
  };
}
