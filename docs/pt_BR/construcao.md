[← Índice](README.md)

# 9\. Construção de pacotes

**nhopkg** pode construir pacotes binários (`.nho`) a partir de receitas fonte (`.srcnho`) ou diretamente de repositórios Git.

## Fluxo de construção

  1. Preparação do fonte
  2. Resolução de dependências
  3. Compilação (`nbuild()`)
  4. Instalação no diretório de staging (`ninstall()`)
  5. Detecção de arquivos
  6. Geração do pacote binário
  7. Assinatura GPG opcional

## Comandos de construção

    # Construir a partir de pacote fonte local
    sudo nhopkg --build foo.srcnho
    
    # Construir diretamente do Git
    sudo nhopkg --super-build foo

## Pacotes divididos (split)

Múltiplos pacotes binários podem ser gerados a partir de uma única receita:
    
    # Splitpackage: dev docs

Cada subpacote usa sua própria função `ninstall_<name>()`.
