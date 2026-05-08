apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: cnpg-namespace
  namespace: flux-system
spec:
  interval: 1h
  path: ./kubes/infrastructure/cnpg/namespace
  prune: true
  sourceRef:
    kind: GitRepository
    name: flux-system
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: cnpg-config
  namespace: flux-system
spec:
  interval: 1h
  dependsOn:
    - name: cnpg-namespace
  path: ./kubes/infrastructure/cnpg/config
  prune: true
  sourceRef:
    kind: GitRepository
    name: flux-system
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: cnpg-secrets
  namespace: flux-system
spec:
  interval: 1h
  dependsOn:
    - name: cnpg-namespace
  path: ./kubes/infrastructure/secrets
  prune: true
  sourceRef:
    kind: GitRepository
    name: flux-system
  decryption:
    provider: sops
    secretRef:
      name: sops-gpg
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: cnpg-database
  namespace: flux-system
spec:
  interval: 1h
  dependsOn:
    - name: cnpg-secrets
  path: ./kubes/infrastructure/cnpg/database
  prune: true
  sourceRef:
    kind: GitRepository
    name: flux-system
