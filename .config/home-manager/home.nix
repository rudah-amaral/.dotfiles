{ config, lib, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "rud___boy";
  home.homeDirectory = "/home/rud___boy";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # Unfree software whitelist by pname
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "discord"
    "wpsoffice"
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.arduino-ide
    pkgs.arduino-language-server
    pkgs.bitwarden-desktop
    pkgs.bottles
    pkgs.clang-tools
    pkgs.discord
    pkgs.eza
    pkgs.fd
    pkgs.fluent-reader
    pkgs.fzf
    pkgs.git
    pkgs.gnuplot
    pkgs.kdePackages.okular
    pkgs.lua-language-server
    pkgs.nerd-fonts.meslo-lg
    pkgs.nixd
    pkgs.ripgrep
    pkgs.starship
    pkgs.stow
    pkgs.tombi
    pkgs.typescript-language-server
    pkgs.vscode-langservers-extracted
    pkgs.wpsoffice
    pkgs.xclip
    pkgs.zathura
    pkgs.zsh
    # Home-manager doesn't have access to the system, therefore it's necessary
    # to set zsh as default login shell:
    # echo ~/.nix-profile/bin/zsh | sudo tee -a /etc/shells
    # usermod -s ~/.nix-profile/bin/zsh $USER
    
    # GUI apps
    pkgs.alacritty
    pkgs.calibre
    pkgs.firefox
    pkgs.kitty
    pkgs.neovide

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # OBS: Esse pacote não funciona mais assim. vvvvvvvvvvvvvvvv
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Whether to enable fontconfig configuration. This will, for example, allow
  # fontconfig to discover fonts and configurations installed through
  # home.packages and nix-env.
  fonts.fontconfig = {
    enable = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.file.".config/zsh/antidote" = {
    source = "${pkgs.antidote}/share/antidote";
  };

  home.file.".config/alacritty/themes" = {
    source = "${pkgs.alacritty-theme}/share/alacritty-theme/";
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/rud___boy/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs = {
    neovim = {
      enable = true;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
  };
}
