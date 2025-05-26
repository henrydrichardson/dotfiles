{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.enableNixpkgsReleaseCheck = false;
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    nixfmt-rfc-style
    dyff
    vivid
    delta
    viu
    duf
    dust
    glow
    nerd-fonts.fira-code
    devenv
    unzip
  ];

  xdg.configFile = {
    "delta".source = ./config/delta;
    "zellij".source = ./config/zellij;
    "nvim".source =
      config.lib.file.mkOutOfStoreSymlink (builtins.toString ./config/nvim);
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.inherit
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
  #  /etc/profiles/per-user/hrichardson/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    EZA_COLORS =
      "uu=36:gu=37:sn=32:sb=32:da=34:ur=34:uw=35:ux=36:ue=36:gr=34:gw=35:gx=36:tr=34:tw=35:tx=36:";
  };

  home.shell.enableZshIntegration = true;

  # Let Home Manager install and manage itself.
  programs = let
    tokyonight = pkgs.fetchFromGitHub {
      owner = "folke";
      repo = "tokyonight.nvim";
      rev = "057ef5d260c1931f1dffd0f052c685dcd14100a3";
      hash = "sha256-1xZhQR1BhH2eqax0swlNtnPWIEUTxSOab6sQ3Fv9WQA=";
    };
  in {
    home-manager.enable = true;
    bat = {
      enable = true;
      config = { theme = "tokyonight_night"; };
      extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
      themes = {
        tokyonight_night = {
          src = tokyonight;
          file = "extras/sublime/tokyonight_night.tmTheme";
        };
      };
    };
    fzf = { enable = true; };
    ripgrep.enable = true;
    ripgrep-all.enable = true;
    eza = {
      enable = true;
      icons = "auto";
      colors = "auto";
      git = true;
    };
    direnv = { enable = true; };
    zoxide = { enable = true; };
    jq.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
    lazygit = {
      enable = true;
      settings = {
        gui = {
          skipDiscardChangeWarning = true;
          commitHashLength = 4;
          showDivergenceFromBaseBranch = "arrowAndNumber";
          commitAuthorShortLength = 2;
          spinner = {
            frames =
              [ "\\uee06" "\\uee07" "\\uee08" "\\uee09" "\\uee0A" "\\uee0B" ];
          };
          nerdFontsVersion = 3;
          theme = {
            activeBorderColor = [ "#ff966c" "bold" ];
            inactiveBorderColor = [ "#589ed7" ];
            searchingActiveBorderColor = [ "#ff966c" "bold" ];
            optionsTextColor = [ "#82aaff" ];
            selectedLineBgColor = [ "#2d3f76" ];
            cherryPickedCommitFgColor = [ "#82aaff" ];
            cherryPickedCommitBgColor = [ "#c099ff" ];
            markedBaseCommitFgColor = [ "#82aaff" ];
            markedBaseCommitBgColor = [ "#ffc777" ];
            unstagedChangesColor = [ "#c53b53" ];
            defaultFgColor = [ "#c8d3f5" ];
          };
        };
        git = {
          parseEmoji = true;
          paging = {
            colorArg = "always";
            pager = "delta --paging=never";
          };
        };
        update = {
          method = "background";
          days = 1;
        };
        refresher = {
          refreshInterval = 600;
          fetchInterval = 3600;
        };
        customCommands = [{
          key = "G";
          context = "localBranches";
          command = "git gone";
          description =
            "Remove local branches that have been removed on remote";
        }];
      };
    };
    bottom = {
      enable = true;
      settings = {
        flags = { enable_gpu = true; };
        cpu = { default = "average"; };
      };
    };

    zsh = {
      enable = true;
      enableVteIntegration = true;
      enableCompletion = true;
      autosuggestion = { enable = true; };
      history = { ignoreAllDups = true; };
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = pkgs.zsh-you-should-use.pname;
          src = pkgs.zsh-you-should-use.src;
        }
      ];
      syntaxHighlighting = { enable = true; };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "aws"
          "docker"
          "docker-compose"
          "fzf"
          "git"
          "git-prompt"
          "gitfast"
          "helm"
          "kubectl"
          "minikube"
          "pyenv"
          "rbenv"
        ];

      };
      initContent = lib.mkMerge [
        (lib.mkOrder 1500 ''
          # Hack for Windows Terminal, set COLORTERM value even though Windows Terminal is True Color Capable. 
          export COLORTERM="truecolor"

          # Define the type of environment: personal, work, etc.
          export SYSTEM_USAGE_TYPE="personal"

          export LS_COLORS=$(vivid generate tokyonight-moon)

          [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
        '')
      ];
    };
  };
}
