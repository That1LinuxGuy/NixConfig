apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: tailscale-namespace
  namespace: flux-system
spec:
  interval: 1h
  path: ./kubes/infrastructure/tailscale/namespace
  prune: true
  sourceRef:
    kind: GitRepository
    name: flux-system
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: tailscale-config
  namespace: flux-system
spec:
  interval: 1h
  dependsOn:
    - name: tailscale-namespace
  path: ./kubes/infrastructure/tailscale/config
  prune: true
  sourceRef:
    kind: GitRepository
    name: flux-system
