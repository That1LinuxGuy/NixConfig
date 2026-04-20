{
  services.k3s = {
    enable = true;
    role = "server";
    serverAddr = "https://192.168.1.247:6443";
    tokenFile = "/var/lib/rancher/k3s/server/node-token";
    extraFlags = [
      "--write-kubeconfig-group k3s"
      "--write-kubeconfig-mode 640"
      "--disable servicelb"
      ];
  };
}
