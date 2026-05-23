[← Índice](README.md)

# 5\. Segurança e assinaturas GPG

**nhopkg** inclui suporte nativo para verificação de assinaturas GPG, garantindo autenticidade e integridade dos pacotes antes da instalação.

## Visão geral

Pacotes binários (`.nho`) podem incluir um arquivo opcional `signature.gpg`, que é uma assinatura GPG destacada de `data.tar.zst`.

As chaves confiáveis são armazenadas em:
    
    
    /etc/nhopkg/trusted-keys/

## Configuração de segurança

Variável| Padrão| Descrição  
---|---|---  
`NHOPKG_VERIFY_SIGNATURE`| yes| Ativar verificação GPG  
`NHOPKG_REQUIRE_SIGNATURE`| no| Exigir pacotes assinados  
`NHOPKG_TRUSTED_KEYS_DIR`| /etc/nhopkg/trusted-keys/| Diretório do chaveiro confiável  
`NHOPKG_SIGN_PACKAGES`| yes| Assinar pacotes ao compilar  
`NHOPKG_SIGN_KEY`| repo@neonatox.vegnux.com| Chave de assinatura padrão  

**Inicialização automática do chaveiro:** se `pubring.kbx` não existir, mas `nhopkg-repo.pub` estiver presente, o nhopkg o importa automaticamente.

## Fluxo de verificação

  1. O usuário instala um pacote.
  2. Se a verificação estiver ativada, o nhopkg verifica `signature.gpg`.
  3. Se ausente e obrigatório → abortar.
  4. Se inválido → abortar.
  5. Se válido → continuar.

## Recomendações

  * Mantenha a verificação de assinaturas ativada em produção.
  * Ative assinaturas obrigatórias para sistemas críticos.
  * Proteja sua chave privada de assinatura.

