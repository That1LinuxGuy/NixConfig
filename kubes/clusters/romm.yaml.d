apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: romm-namespace
  namespace: flux-system
spec:
  interval: 1h
  path: ./kubes/apps/romm/namespace
  prune: true
  sourceRef:
    kind: GitRepository
    name: flux-system
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: romm-config
  namespace: flux-system
spec:
  interval: 1h
  dependsOn:
    - name: romm-namespace
  path: ./kubes/apps/romm/config
  prune: true
  sourceRef:
    kind: GitRepository
    name: flux-system
