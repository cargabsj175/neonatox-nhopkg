# nhoget — Unified Download Tool

`nhoget` is the unified download system for the nhopkg package manager. It provides transparent HTTP/HTTPS and VCS download capabilities to all nhopkg components — builds, installs, repository updates, and source-package creation — while also serving as a standalone CLI tool usable from post-install scripts, build recipes, or a terminal.

## Rationale

Before `nhoget`, nhopkg used ad-hoc `wget` and `git clone` calls scattered across the codebase. This made it difficult to:

- Switch download backends (GNU wget, curl, BusyBox wget)
- Add VCS types beyond git (svn, hg)
- Apply consistent retry, timeout, and resume policies
- Audit or extend download behaviour

`nhoget` centralises all download logic into a single library (`libnhopkg_download`) exposed via a CLI tool and sourced transparently by `nhopkg`.

## Transparency guarantee

`nhoget` is a **transparent replacement**: no existing nhopkg workflow, nhoid format, or user interface has changed. The same flags (`nhopkg -b`, `-C`, `-S`, `-U`) behave identically. Internally, every `wget` and raw `git clone` has been replaced by `nhoget_url` / `nhoget_vcs`.

## Commands

### `download`

Download a file via HTTP/HTTPS.

```
nhoget download [options] <url> [<dest>]
```

If `<dest>` is omitted, the filename is derived from the URL. Use `-o` to specify an exact output path, or `-O` to specify an output directory. Supports hash verification with `--hash`.

### `clone`

Clone a VCS repository.

```
nhoget clone [options] <url> [<dest>]
```

Defaults to git. Use `--type svn` or `--type hg` for other VCS types. The destination defaults to the basename of the URL (with `.git` stripped for git URLs).

### `fetch`

Auto-detect the source type from the URL and download or clone.

```
nhoget fetch [options] <url> [<dest>]
```

Detection rules:

| URL pattern | Behaviour |
|-------------|-----------|
| `git+<url>` or `*.git` | Git clone |
| `svn+<url>` | Subversion checkout |
| `hg+<url>` | Mercurial clone |
| Plain URL | Tarball download + auto-extract |

Tarballs are extracted with `--strip-components=1` into the destination directory. Supported formats: `.tar.zst`, `.tar.xz`, `.tar.bz2`, `.tar.gz`, `.zip`, `.AppImage`.

For VCS types, `nhoget fetch` tries an incremental update (fetch + checkout) if the destination already exists, falling back to a fresh clone.

## Options

| Short | Long | Description |
|-------|------|-------------|
| `-o` | `--output FILE` | Save to a specific file (download only) |
| `-O` | `--output-dir DIR` | Save to a directory |
| `-r` | `--resume` | Resume a partial download |
| `-t` | `--timeout SECS` | Connection timeout (default: 20) |
| | `--retries N` | Number of retries (default: 3) |
| `-q` | `--quiet` | Suppress non-essential output |
| `-v` | `--verbose` | Verbose output |
| | `--hash TYPE:VALUE` | Verify hash after download (e.g. `sha256:abc...`) |
| | `--type TYPE` | Force source type: `tarball`, `git`, `svn`, `hg` |
| | `--ref REF` | VCS reference (tag, branch, commit for git; revision for svn) |
| | `--depth N` | Shallow clone depth (git only) |
| | `--backend BACKEND` | Force backend: `wget`, `curl`, `wget-bb`, `auto` |
| `-h` | `--help` | Show help |
| | `--version` | Show version |

## Backends

The `auto` backend probes in this order:

1. **GNU wget** — preferred for backward compatibility (not curl, despite curl being more portable)
2. **curl** — used if GNU wget is unavailable
3. **BusyBox wget** — handles HTTPS; retries implemented via a manual loop (BusyBox lacks the `-t` flag)

## Configuration

Behaviour is controlled by environment variables or `/etc/nhopkg/nhopkg.conf`:

| Variable | Default | Description |
|----------|---------|-------------|
| `NHOGET_BACKEND` | `auto` | Backend selection (`wget`, `curl`, `wget-bb`, `auto`) |
| `NHOGET_TIMEOUT` | `20` | Connection timeout in seconds |
| `NHOGET_RETRIES` | `3` | Number of download retries |
| `NHOGET_RESUME` | `no` | Enable resume of partial downloads |

## URL prefixes

VCS repositories can be specified with URL prefixes:

- `git+https://example.com/repo` — Git repository
- `svn+https://example.com/svn/repo` — Subversion repository
- `hg+https://example.com/repo` — Mercurial repository
- `https://example.com/pkg.tar.zst` — Plain tarball (auto-extracted)

For backward compatibility, URLs ending in `.git` are also treated as Git repositories (no `git+` prefix needed).

## See also

- [PROPOSAL-nhoget.md](/PROPOSAL-nhoget.md) — Full specification with design decisions
- [Commands reference](comandos.md) — nhopkg main commands
- [Arquitecture overview](arquitectura.md)
