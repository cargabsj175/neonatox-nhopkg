[← Index](index.md)

# 5\. Security and GPG signatures

**nhopkg** includes built-in support for GPG signature verification, ensuring package authenticity and integrity before installation.

## Overview

Binary packages (`.nho`) may include an optional `signature.gpg` file, which is a detached GPG signature of `data.tar.zst`.

Trusted keys are stored in:
    
    
    /etc/nhopkg/trusted-keys/

## Security configuration

Variable| Default| Description  
---|---|---  
`NHOPKG_VERIFY_SIGNATURE`| yes| Enable GPG verification  
`NHOPKG_REQUIRE_SIGNATURE`| no| Require signed packages  
`NHOPKG_TRUSTED_KEYS_DIR`| /etc/nhopkg/trusted-keys/| Trusted keyring directory  
`NHOPKG_SIGN_PACKAGES`| yes| Sign packages when building  
`NHOPKG_SIGN_KEY`| repo@neonatox.vegnux.com| Default signing key  
  
**Automatic keyring initialization:** if `pubring.kbx` does not exist but `nhopkg-repo.pub` is present, nhopkg imports it automatically. 

## Verification flow

  1. User installs a package.
  2. If verification is enabled, nhopkg checks `signature.gpg`.
  3. If missing and required → abort.
  4. If invalid → abort.
  5. If valid → continue.



## Recommendations

  * Keep signature verification enabled in production.
  * Enable mandatory signatures for critical systems.
  * Protect your private signing key.


