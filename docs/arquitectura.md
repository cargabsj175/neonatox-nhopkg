[← Index](index.md)

# 1\. General architecture

**nhopkg** is a universal package manager designed to work on any GNU/Linux distribution. Its architecture focuses on simplicity, portability, and transparency.

## Language and compatibility

  * Written mainly in **Bash** , with explicit effort to remain compatible with `sh`.
  * Designed to run even in minimal environments such as **BusyBox**.
  * No dependency on external runtimes like Python, Perl, or Rust.



## Package formats

  * `.nho`: binary packages ready to install.
  * `.srcnho`: source packages containing build recipes (`nhoid`).



## Structure of a `.nho` package

  * `nhoid`: package metadata.
  * `data.tar.zst`: compressed files.
  * `signature.gpg` (optional): GPG signature.



## Portability and minimalism

nhopkg is intended for:

  * Custom distributions (LFS / BLFS).
  * Embedded or low-resource systems.
  * Production environments requiring full control and reproducibility.


