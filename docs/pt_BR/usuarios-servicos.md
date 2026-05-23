[← Índice](README.md)

# 6\. Gerenciamento de usuários e serviços

**nhopkg** fornece duas funções essenciais para sistemas em produção:

  * `nhouser()`: cria ou verifica usuários e grupos do sistema de forma idempotente.
  * `install_init_unit()`: instala unidades de serviço para `systemd` ou `sysvinit` a partir de fontes externas como BLFS.

Ambas as funções são projetadas para serem usadas em scripts pós-instalação de pacotes (`npostinstall()`), seguindo as convenções do **Beyond Linux From Scratch (BLFS)**.

## 6.1. Gerenciamento de usuários e grupos: `nhouser()`

A função `nhouser` permite a criação segura e repetível de contas de sistema. Ela é idempotente: se o usuário já existir, nada é alterado.

### Sintaxe
    
    
    nhouser --check|--create [opções]

### Opções disponíveis

Opção | Descrição  
---|---  
`--check`| Verificar se o usuário/grupo existe (sem alterações).  
`--create`| Criar o usuário/grupo se não existir.  
`--user <nome>`| Nome do usuário.  
`--group <nome>`| Grupo primário.  
`--uid <id>`| ID numérico do usuário (recomendado pelo BLFS).  
`--gid <id>`| ID numérico do grupo.  
`--shell <caminho>`| Shell atribuído (ex.: `/sbin/nologin`).  
`--groups <lista>`| Grupos secundários (separados por vírgula).  

### Exemplos reais (BLFS)

#### Exemplo 1: usuário `cups`
    
    
    nhouser --create \
      --user lp \
      --group lp \
      --uid 9 \
      --gid 9 \
      --shell /sbin/nologin

#### Exemplo 2: usuário `greetd`
    
    
    nhouser --create \
      --user greetd \
      --group greetd \
      --uid 51 \
      --gid 51 \
      --shell /sbin/nologin

#### Exemplo 3: usuário `dhcpcd`
    
    
    nhouser --create \
      --user dhcp \
      --group dhcp \
      --uid 82 \
      --gid 82 \
      --shell /sbin/nologin

**Nota:** Os valores de UID/GID mostrados aqui seguem os padrões BLFS/LFS, garantindo compatibilidade com políticas e scripts existentes.

## 6.2. Gerenciamento de serviços: `install_init_unit()`

Esta função instala unidades de serviço dos repositórios BLFS, detectando automaticamente se o sistema usa `systemd` ou `sysvinit`.

### Sintaxe
    
    
    install_init_unit install|remove <serviço>

### Variáveis necessárias

  * `INITSYSTEM`: `systemd` ou `sysvinit`
  * `SYSTEMD_BLFS_URL` / `SYSTEMD_BLFS_DIR`
  * `SYSV_BLFS_URL` / `SYSV_BLFS_DIR`

### Exemplos

#### Instalar serviço `slapd` (OpenLDAP)
    
    
    install_init_unit install slapd

#### Remover serviço `cups`
    
    
    install_init_unit remove cups

#### Integração em `npostinstall()`
    
    
    npostinstall() {
      nhouser --create --user lp --group lp --uid 9 --gid 9 --shell /sbin/nologin
      install_init_unit install cups
      [ -x /usr/bin/systemctl ] && systemctl daemon-reload
    }

## 6.3. Configuração do sistema
    
    
    export INITSYSTEM="systemd"
    export SYSTEMD_BLFS_URL="https://anduin.linuxfromscratch.org/BLFS/blfs-bootscripts/blfs-bootscripts-systemd-20250101.tar.xz"
    export SYSTEMD_BLFS_DIR="/usr/src/blfs-bootscripts-systemd"
    export SYSV_BLFS_URL="https://anduin.linuxfromscratch.org/BLFS/blfs-bootscripts/blfs-bootscripts-20250101.tar.xz"
    export SYSV_BLFS_DIR="/usr/src/blfs-bootscripts"

## Conclusão

Com `nhouser()` e `install_init_unit()`, o **nhopkg** fornece uma solução madura e alinhada ao BLFS para gerenciar usuários e serviços em ambientes de produção.

