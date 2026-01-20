[← Index](index.html)

# 6\. User and service management

**nhopkg** provides two essential functions for production systems:

  * `nhouser()`: creates or verifies system users and groups in an idempotent way.
  * `install_init_unit()`: installs service units for `systemd` or `sysvinit` from external sources such as BLFS.



Both functions are intended to be used inside package post-install scripts (`npostinstall()`), following **Beyond Linux From Scratch (BLFS)** conventions.

## 6.1. User and group management: `nhouser()`

The `nhouser` function allows safe, repeatable creation of system accounts. It is idempotent: if the user already exists, nothing is changed.

### Syntax
    
    
    nhouser --check|--create [options]

### Available options

Option | Description  
---|---  
`--check`| Check if the user/group exists (no changes).  
`--create`| Create the user/group if it does not exist.  
`--user <name>`| User name.  
`--group <name>`| Primary group.  
`--uid <id>`| Numeric user ID (recommended by BLFS).  
`--gid <id>`| Numeric group ID.  
`--shell <path>`| Assigned shell (e.g. `/sbin/nologin`).  
`--groups <list>`| Secondary groups (comma-separated).  
  
### Real-world examples (BLFS)

#### Example 1: `cups` user
    
    
    nhouser --create \
      --user lp \
      --group lp \
      --uid 9 \
      --gid 9 \
      --shell /sbin/nologin

#### Example 2: `greetd` user
    
    
    nhouser --create \
      --user greetd \
      --group greetd \
      --uid 51 \
      --gid 51 \
      --shell /sbin/nologin

#### Example 3: `dhcpcd` user
    
    
    nhouser --create \
      --user dhcp \
      --group dhcp \
      --uid 82 \
      --gid 82 \
      --shell /sbin/nologin

**Note:** The UID/GID values shown here match BLFS/LFS standards, ensuring compatibility with existing policies and scripts. 

## 6.2. Service management: `install_init_unit()`

This function installs service units from BLFS repositories, automatically detecting whether the system uses `systemd` or `sysvinit`.

### Syntax
    
    
    install_init_unit install|remove <service>

### Required variables

  * `INITSYSTEM`: `systemd` or `sysvinit`
  * `SYSTEMD_BLFS_URL` / `SYSTEMD_BLFS_DIR`
  * `SYSV_BLFS_URL` / `SYSV_BLFS_DIR`



### Examples

#### Install `slapd` service (OpenLDAP)
    
    
    install_init_unit install slapd

#### Remove `cups` service
    
    
    install_init_unit remove cups

#### Integration in `npostinstall()`
    
    
    npostinstall() {
      nhouser --create --user lp --group lp --uid 9 --gid 9 --shell /sbin/nologin
      install_init_unit install cups
      [ -x /usr/bin/systemctl ] && systemctl daemon-reload
    }

## 6.3. System configuration
    
    
    export INITSYSTEM="systemd"
    export SYSTEMD_BLFS_URL="https://anduin.linuxfromscratch.org/BLFS/blfs-bootscripts/blfs-bootscripts-systemd-20250101.tar.xz"
    export SYSTEMD_BLFS_DIR="/usr/src/blfs-bootscripts-systemd"
    export SYSV_BLFS_URL="https://anduin.linuxfromscratch.org/BLFS/blfs-bootscripts/blfs-bootscripts-20250101.tar.xz"
    export SYSV_BLFS_DIR="/usr/src/blfs-bootscripts"

## Conclusion

With `nhouser()` and `install_init_unit()`, **nhopkg** provides a mature, BLFS-aligned solution for managing users and services in production environments.
