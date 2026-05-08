apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: metal-namespace
  namespace: flux-system
spec:
  interval: 1h
  path: ./kubes/infrastructure/metal/namespace
  prune: true
  sourceRef:
    kind: GitRepository
    name: flux-system
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: metal-config
  namespace: flux-system
spec:
  interval: 1h
  dependsOn:
    - name: metal-namespace
  path: ./kubes/infrastructure/metal/config
  prune: true
  sourceRef:
    kind: GitRepository
    name: flux-system
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: metal-address
  namespace: flux-system
spec:
  interval: 1h
  dependsOn:
    - name: metal-config
  path: ./kubes/infrastructure/metal/address
  prune: true
  sourceRef:
    kind: GitRepository
    name: flux-system
