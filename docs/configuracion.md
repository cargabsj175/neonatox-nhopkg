[← Index](index.html)

# 2\. Configuration

The main configuration file for **nhopkg** is:
    
    
    /etc/nhopkg/nhopkg.conf

If it does not exist, a default configuration is loaded from:
    
    
    /usr/share/nhopkg/nhopkg.conf

All variables can be temporarily overridden using command-line options.

## Configuration priority

  1. Configuration file
  2. Command-line options (highest priority)



## Minimal example
    
    
    NHOPKG_ACTIVE_REPOS="extra"
    NHOPKG_REPO_EXTRA="https://example.com/repo/extra"
    NHOPKG_VERIFY_SIGNATURE=no
