[← Index](README.md)

# 8\. Safe updates

The `--upgrade` (or `-y`) command allows updating all installed packages to their latest versions available in the configured repositories.

Unlike other package managers, **nhopkg** follows a robust and predictable update workflow, minimizing the risk of partial system corruption.

## Update workflow

  1. Synchronizes repositories.
  2. Lists installed packages.
  3. Compares installed and available versions.
  4. Builds an upgrade plan and asks for confirmation.
  5. Downloads all required dependencies.
  6. Installs dependencies first.
  7. Removes old package versions.
  8. Installs new versions.
  9. Runs post-install system updates.
  10. Updates the local database.



**Key behavior:** old versions are removed _before_ installing new ones to avoid file conflicts. 

## Security checks

  * SHA256 checksum verification
  * Architecture compatibility
  * GPG signature verification (if enabled)


    
    
    # Upgrade the system
    sudo nhopkg --upgrade
    sudo nhopkg -y
