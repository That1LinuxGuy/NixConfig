# NixOS Homelab with K3S

Welcome to my homelab! This is a massive upgrade for me personally - I have been working with Linux for years and containerization for a while, so I wanted to step up my game and work with Orchestration.

## Setup:

I like Pokemon, so naturally I named my three systems after the starters from my original Leaf Green run.

I have a repurposed Chromebox, an HP prodesk, and an old dell latitude. They are nicknamed "bulbasaur", "charmander", and "squirtle" respectively.

For the OS, I wanted something I could set, forget, and easily copy to new machines when I *obviously* expand my hardware selection. Thus, NixOS was a natural choice.

## Tasks:

- [x] Setup FluxCD to automate deployments, monitoring, and scaling
- [x] Re-install Longhorn so Flux can manage configuration
- [x] Replace servicelb with metallb
- [ ] Install tailscale kube operator
- [ ] Install and configure Prometheus/Grafana
- [ ] Setup CloudNativePG for DB storage
- [ ] Setup Bitnami Chart for Redis
- [ ] Setup Garage for S3 compatible storage
- [ ] Install [Mijn Bureau](https://minbzk.github.io/mijn-bureau-infra/) production implementation of La Suite Numerique
- [ ] Cry tears of joy

## Layout:

I tried to make it simple. It makes sense to me at least. Each machine is funneled into flake.nix

in /hosts, I have all my machines and hardware \
in /common, I have common services, networking, and configs \
in /modules, I have the specific roles for various machines defined \
in /kubes, I have my fluxCD monorepo configs for all my container
- clusters is my fluxCD config folder
- infrastructure holds pods required to run services
- apps is where actual services will run

## Issues:

My biggest concern currently is hardware. In the [etcd guide](https://etcd.io/docs/v3.3/op-guide/hardware/) it specifically states "Fast disks are the most critical factor for etcd deployment performance and stability" \
Currently, my prodesk only has an HDD that I will not be upgrading anytime soon due to PC part pricing :,(

Nix is weird... After learning Nix code, then adding the flake, then moving EVERYTHING into directories, I ran into a lot of syntax errors and hidden issues. the challenge is that the system does not tell you why things don't work since it takes a declarative approach. This means less work for the user, but also less visibility by default.

Another issue is mentally shifting from "Deploying" to "Automating". 
``` bash
docker compose up -d
```
this deploys an app 
``` bash
kubectl apply -f
# OR
helm install
```
This also deploys an app

Now, FluxCD does that job and my role is to create the "platform" to get apps running

