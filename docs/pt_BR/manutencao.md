[← Índice](README.md)

# 10\. Manutenção do sistema

**nhopkg** fornece ferramentas para manter o sistema limpo, consistente e saudável.

## Atualização de caches

O comando `--update-shooters` atualiza os caches do sistema:

  * Esquemas GSettings
  * Cache de ícones
  * Entradas de desktop
  * Banco de dados MIME
  * Páginas man
  * Cache de fontes
  * Bibliotecas compartilhadas

    
    sudo nhopkg --update-shooters

## Atualização do banco de dados
    
    sudo nhopkg --update-db

## Limpeza de cache
    
    # Limpar pacotes baixados
    sudo nhopkg --clean
    
    # Limpar cache e diretório de construção
    sudo nhopkg --clean -R

## Verificação de integridade
    
    nhopkg --check gimp

## Backup de pacotes
    
    sudo nhopkg --backup gimp
