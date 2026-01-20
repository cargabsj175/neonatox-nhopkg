[← Index](README.md)

# 7\. Package groups

**nhopkg** allows organizing packages into logical groups using the `# Group:` field in the `nhoid` file.

## Defining a group
    
    
    # Group: graphics

## Installing by group
    
    
    sudo nhopkg --install-group graphics

## How it works

  1. Scans synced repositories
  2. Finds matching group entries
  3. Resolves dependencies
  4. Installs all packages in the group



Groups are ideal for defining system profiles such as `base`, `desktop`, or `server`.
