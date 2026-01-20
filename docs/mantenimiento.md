[← Index](index.md)

# 10\. System maintenance

**nhopkg** provides tools to keep the system clean, consistent and healthy.

## Cache updates

The `--update-shooters` command refreshes system caches:

  * GSettings schemas
  * Icon cache
  * Desktop entries
  * MIME database
  * Man pages
  * Font cache
  * Shared libraries


    
    
    sudo nhopkg --update-shooters

## Database update
    
    
    sudo nhopkg --update-db

## Cache cleanup
    
    
    # Clean downloaded packages
    sudo nhopkg --clean
    
    # Clean cache and build directory
    sudo nhopkg --clean -R

## Integrity check
    
    
    nhopkg --check gimp

## Package backup
    
    
    sudo nhopkg --backup gimp
