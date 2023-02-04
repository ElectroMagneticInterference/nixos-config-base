{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./boot.nix
      ./locale.nix
      ./firefox.nix
      ./neovim.nix
      ./plasma.nix
      #./maestral.nix
      <home-manager/nixos>
    ];

  security = {
    doas = { 
      enable = true;
      extraRules = [{
        users = [ "eimmer" ];
        keepEnv = true;
      }];
    };
    sudo.enable = false;
  };

  system.autoUpgrade.enable = true;

  networking = {
    hostName = "eimmer-laptop";
    networkmanager.enable = true;
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 8d";
  };

  nix.extraOptions = ''experimental-features = nix-command flakes'';

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    #jack.enable = false;
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.eimmer = {
    isNormalUser = true;
    description = "Elijah Immer";
    extraGroups = [ "networkmanager" ];
    packages = with pkgs; [
      signal-desktop
      qbittorrent
      libreoffice
      rose-pine-gtk-theme
      kpam
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # terminal and commandline
    alacritty
    neofetch
    htop
    python
    pinentry
    p7zip
    git

    # Core Utilites Aliases
    exa
    bat
    fd
    ripgrep
    procs
  ];

  programs = {
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      enableBashCompletion = true;
      autosuggestions = {
        enable = true;
	async = true;
      };

      shellAliases = {
        ls = "exa --long --header --git --all";
	find = "fd";
	grep = "rg -uuu";
        ps = "procs";
        clear = "clear && neofetch && ls";
      };
      interactiveShellInit = "neofetch && exa --long --header --git --all";
    };

    starship = {
      enable = true;
      settings = {
        format = "$username[@](bold brown)$hostname [$directory](red)[>](bold green)";
        hostname = {
	  ssh_only = false;
	  format = "[$hostname$ssh_symbol]($style)";
	  style = "bold dimmed blue";
	  disabled = false;
	};
	username = {
	  style_user = "gold";
	  style_root = "purple";
	  format = "[$user]($style)";
	  disabled = false;
	  show_always = true;
	};
	directory.format = "[$path]($style)[$read_only]($read_only_style)";
      }; 
    };
  };

  system.stateVersion = "22.11";
}
