{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-charmander.nix
    ];

  networking.hostName = "charmander"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  services.openiscsi = {
  enable = true;
  name = "${config.networking.hostName}";
  };

  # This tells Nix to append these strings together rather than overwriting them
  services.k3s.extraFlags = lib.mkAfter [
    "--node-label storage=hdd"
    "--node-label capacity=mid"
    "--node-label ram=12gb"
  ];
}
