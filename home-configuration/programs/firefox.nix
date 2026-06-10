{
  config,
  lib,
  ...
}:

{
  # Download pdfs not in firefox??
  config = lib.mkIf config.home-config.programs.firefox.enable {
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
            wikipedia = {
              name = "Wikipedia";
              urls = [ { template = "https://en.wikipedia.org/w/index.php?search={searchTerms}"; } ];
              icon = "https://en.wikipedia.org/static/favicon/wikipedia.ico";
              definedAliases = [ "!wp" ];
            };
            rocq = {
              name = "Rocq";
              urls = [ { template = "https://rocq-prover.org/doc/V9.2.0/refman/search.html?q={searchTerms}"; } ];
              icon = "https://rocq-prover.org/_/YTlhZTE1YTM5OGJkOGQ0MGQ0NDA2YjcwNmU4ODE3Yzc/logos/favicon.ico";
              definedAliases = [ "!rocq" ];
            };

            ddg.metaData.alias = "!ddg"; # Duck Duck Go
            bing.metaData.hidden = true;
            ecosia.metaData.hidden = true;
            perplexity.metaData.hidden = true;
          };
          force = true;
        };
        settings = {
          "browser.translations.automaticallyPopup" = false;
          "browser.translations.neverTranslateLanguages" = "de";
        };
      };
    };
  };
}
