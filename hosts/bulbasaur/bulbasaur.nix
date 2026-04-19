{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-bulbasaur.nix
    ];

  networking.hostName = "bulbasaur"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  services.openiscsi = {
  enable = true;
  name = "${config.networking.hostName}";
  };

  # This tells Nix to append these strings together rather than overwriting them
  services.k3s.extraFlags = lib.mkAfter [
    "--node-label storage=ssd"
    "--node-label capacity=high"
    "--node-label ram=40gb"
  ];
}
