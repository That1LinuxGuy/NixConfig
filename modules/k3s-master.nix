{ pkgs, ... }:

{
  services.k3s = {
    enable = true;
    role = "server";
    tokenFile = "/var/lib/rancher/k3s/server/node-token";
    clusterInit = true;
    extraFlags = [
      "--write-kubeconfig-group k3s"
      "--write-kubeconfig-mode 640"
      "--disable servicelb"
      ];
  };
}
