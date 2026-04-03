# New2005 Release And Rollback

## Layout

```bash
/srv/new2005-finance/
  current -> releases/<timestamp>
  releases/<timestamp>/
  backups/
```

## Release flow

1. Sync code into a fresh timestamped release directory.
2. Install dependencies and build inside the new release.
3. Run smoke checks against the staged release.
4. Move `current` symlink to the new release.
5. Restart the managed service.
6. Verify `/api/health` and public domain.

## Rollback flow

1. Inspect available release directories.
2. Point `current` back to the previous known-good release.
3. Restart the managed service.
4. Re-run smoke and public checks.

## Why this exists

This prevents in-place mutation of the active runtime directory and reduces the chance of ownership/permission drift taking production down.
