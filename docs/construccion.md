[← Index](index.md)

# 9\. Package building

**nhopkg** can build binary packages (`.nho`) from source recipes (`.srcnho`) or directly from Git repositories.

## Build workflow

  1. Source preparation
  2. Dependency resolution
  3. Compilation (`nbuild()`)
  4. Installation to staging directory (`ninstall()`)
  5. File detection
  6. Binary package generation
  7. Optional GPG signing



## Build commands
    
    
    # Build from local source package
    sudo nhopkg --build foo.srcnho
    
    # Build directly from Git
    sudo nhopkg --super-build foo

## Split packages

Multiple binary packages can be generated from a single recipe:
    
    
    # Splitpackage: dev docs

Each subpackage uses its own `ninstall_<name>()` function.
