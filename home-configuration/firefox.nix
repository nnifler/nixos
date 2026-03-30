{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    # profiles = { default };
    profiles.default = {
      search.engines = {
        merriam-webster = {
          name = "Merriam Webster";
          urls = [{ template = "https://www.merriam-webster.com/dictionary/{searchTerms}"; }];
          definedAliases = [ "!mw" ];
        };
      };
    };
  };
}