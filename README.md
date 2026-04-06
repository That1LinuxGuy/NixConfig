# NixOS Homelab with K3S

Welcome to my homelab! This is a massive upgrade for me personally - I have been working with Linux for years and containerization for a while, so I wanted to step up my game and work with Orchestration.

## Setup:

I like Pokemon, so naturally I named my three systems after the starters from my original Leaf Green run.

I have a repurposed Chromebox, an HP prodesk, and an old dell latitude. They are nicknamed "bulbasaur", "charmander", and "squirtle" respectively.

For the OS, I wanted something I could set, forget, and easily copy to new machines when I *obviously* expand my hardware selection. Thus, NixOS was a natural choice.

## Layout:

I tried to make it simple. It makes sense to me at least. Each machine is funneled into flake.nix

in /hosts, I have all my machines and hardware
in /common, I have common services, networking, and configs
in /kubes, I have configs for all the containers I plan to run.
in /k3s, I have the specific roles for various machines defind
