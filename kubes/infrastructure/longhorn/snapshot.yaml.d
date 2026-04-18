apiVersion: longhorn.io/v1beta2
kind: RecurringJob
metadata:
  name: daily-snapshot
  namespace: longhorn-system
spec:
  # Run daily at midnight
  cron: "0 0 * * *"
  task: snapshot
  groups: []
  retain: 5 
  concurrency: 2
  labels:
    type: daily
  dependsOn: longhorn
---
apiVersion: longhorn.io/v1beta2
kind: RecurringJob
metadata:
  name: weekly-backup
  namespace: longhorn-system
spec:
  # Run weekly on Sunday at 2 AM
  cron: "0 2 * * 0"
  task: backup
  groups: []
  retain: 2 
  concurrency: 1
  labels:
    type: weekly
  dependsOn: longhorn
