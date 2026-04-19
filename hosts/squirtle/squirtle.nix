{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-squirtle.nix
    ];

  networking.hostName = "squirtle"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

  services.openiscsi = {
  enable = true;
  name = "${config.networking.hostName}";
  };

  # This tells Nix to append these strings together rather than overwriting them
  services.k3s.extraFlags = lib.mkAfter [
    "--node-label storage=ssd"
    "--node-label capacity=low"
    "--node-label ram=24gb"
  ];
}
