{
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./home-configuration/firefox.nix
    ./home-configuration/mail.nix
    ./home-configuration/gnome.nix
  ];

  home.username = "finns";
  home.homeDirectory = "/home/finns";

  # Shell
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
    };

    shellAliases = {
      nix-shell = "nix-shell --run zsh";
      nix-develop = "nix develop -c zsh";
      rebuild-switch = "sudo nixos-rebuild switch --flake /home/finns/.nixos";
    };
  };

  programs.starship = {
    enable = true;
  };

  # VSCode
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        pkief.material-icon-theme
      ];
      userSettings = {
        "editor.formatOnSave" = true;
        "workbench.iconTheme" = "material-icon-theme";
      };
    };
  };

  # Git
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

  home.packages = with pkgs; [
    prismlauncher
    spotify
    signal-desktop
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
