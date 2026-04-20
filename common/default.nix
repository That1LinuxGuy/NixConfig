{ config, pkgs, ... }:

{  
  # Bootloader.
  boot.kernelModules = [ "iscsi_tcp" "libiscsi" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mcallen = {
    isNormalUser = true;
    description = "mcallen";
    extraGroups = [ "networkmanager" "wheel" "k3s" ];
    linger = true;
    packages = with pkgs; [];
  };

  users.groups.k3s = {}; # This creates the group

  systemd.services.iscsid.serviceConfig = {
    PrivateMounts = "no";
    BindPaths = "/run/current-system/sw/bin:/bin";
    TimeoutStartSec = "30";
  };

  systemd.tmpfiles.rules = [
    # Create a symbolic link /usr/bin/mount -> /run/current-system/sw/bin/mount
    "L /usr/bin/mount - - - - /run/current-system/sw/bin/mount"
  ];

  # Enable git with global config
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "That1LinuxGuy";
        email = "mcallen71398@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Automate storage optimization 
  nix.optimise.automatic = true;

  # Automate garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 10d";
  };



  # Enable Flakes feature and accompanying CLI tools
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix!
    wget
    openiscsi
    git
    fluxcd
    fastfetch
    (wrapHelm kubernetes-helm {
        plugins = with pkgs.kubernetes-helmPlugins; [
          helm-secrets
          helm-diff
          helm-s3
          helm-git
        ];
      })
  ];

  environment.variables = {
  KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
  };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
