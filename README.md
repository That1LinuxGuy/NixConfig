# NixOS Homelab with K3S

Welcome to my homelab! This is a massive upgrade for me personally - I have been working with Linux for years and containerization for a while, so I wanted to step up my game and work with Orchestration.

## Setup:

I like Pokemon, so naturally I named my three systems after the starters from my original Leaf Green run.

I have a repurposed Chromebox, an HP prodesk, and an old dell latitude. They are nicknamed "bulbasaur", "charmander", and "squirtle" respectively.

For the OS, I wanted something I could set, forget, and easily copy to new machines when I *obviously* expand my hardware selection. Thus, NixOS was a natural choice.

## Tasks

- [ ] Setup CloudNativePG for DB storage
- [ ] Setup Bitnami Chart for Redis
- [ ] Setup Ceph via Rook for S3 compatible storage
- [ ] Install [Mijn Bureau](https://minbzk.github.io/mijn-bureau-infra/) production implementation of La Suite Numerique

## Layout:

I tried to make it simple. It makes sense to me at least. Each machine is funneled into flake.nix

in /hosts, I have all my machines and hardware \
in /common, I have common services, networking, and configs \
in /kubes, I have configs for all the containers I plan to run \
in /modules, I have the specific roles for various machines defined

## Issues:

My biggest concern currently is hardware. In the [etcd guide](https://etcd.io/docs/v3.3/op-guide/hardware/) it specifically states "Fast disks are the most critical factor for etcd deployment performance and stability" \
Currently, my prodesk only has an HDD that I will not be upgrading anytime soon due to PC part pricing :,(

Second, Nix is weird... After learning Nix code, then adding the flake, then moving EVERYTHING into directories, I ran into a lot of syntax errors and hidden issues. One major "problem" is that the system does not tell you why things don't work. If the K3S service hangs during nixos-rebuild switch - you know the K3S service isn't working, but with no idea why. I said "problem" because this is a specific design of the system - a declarative approach means less work for the user, but also less visibility by default.
