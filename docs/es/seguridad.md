[← Índice](index.md)

# 5\. Seguridad y firmas GPG

**nhopkg** incluye soporte integrado para verificación de firmas GPG, lo que permite garantizar la autenticidad e integridad de los paquetes binarios antes de su instalación.

## Funcionamiento general

Cada paquete binario (`.nho`) puede contener opcionalmente un archivo `signature.gpg`, que es una firma GPG detachada del archivo `data.tar.zst`.

Durante la instalación, **nhopkg** verifica esta firma contra un keyring de confianza ubicado en:
    
    
    /etc/nhopkg/trusted-keys/

## Configuración de seguridad

El comportamiento de seguridad se controla mediante variables en `/etc/nhopkg/nhopkg.conf`:

Variable | Valor por defecto | Descripción  
---|---|---  
`NHOPKG_VERIFY_SIGNATURE` | `yes` | Habilita la verificación de firmas GPG al instalar paquetes.  
`NHOPKG_REQUIRE_SIGNATURE` | `no` | Exige que todos los paquetes estén firmados. Solo tiene efecto si `NHOPKG_VERIFY_SIGNATURE=yes`.  
`NHOPKG_TRUSTED_KEYS_DIR` | `/etc/nhopkg/trusted-keys/` | Directorio del keyring de confianza (debe contener `pubring.kbx`).  
`NHOPKG_SIGN_PACKAGES` | `yes` | Firma automáticamente los paquetes binarios al construirlos (solo para mantenedores).  
`NHOPKG_SIGN_KEY` | `repo@neonatox.vegnux.com` | Clave GPG predeterminada usada para firmar paquetes.  
  
## Inicialización automática del keyring

**Característica clave:** Si no existe el keyring (`pubring.kbx`) pero sí hay una clave pública en: 
    
    
    /etc/nhopkg/trusted-keys/nhopkg-repo.pub

**nhopkg** la importará automáticamente la primera vez que se requiera verificación. 

Esto facilita la distribución de repositorios seguros sin requerir pasos manuales adicionales por parte del usuario final.

## Flujo de verificación

  1. El usuario ejecuta `sudo nhopkg -i paquete.nho`.
  2. Si `NHOPKG_VERIFY_SIGNATURE=yes`, nhopkg busca `signature.gpg` dentro del paquete.
  3. Si no hay firma: 
     * Y `NHOPKG_REQUIRE_SIGNATURE=yes` → **aborta con error**.
     * De lo contrario → muestra advertencia y continúa.
  4. Si hay firma, la verifica contra el keyring en `/etc/nhopkg/trusted-keys/`.
  5. Si la firma es válida → continúa con la instalación.
  6. Si la firma es inválida o no confiable → **aborta con error**.



## Firmado de paquetes (para mantenedores)

Al construir un paquete con `--build` o `--super-build`, si `NHOPKG_SIGN_PACKAGES=yes`, nhopkg:

  1. Genera `data.tar.zst`.
  2. Ejecuta: `gpg --detach-sign --armor data.tar.zst`.
  3. Renombra `data.tar.zst.asc` a `signature.gpg`.
  4. Incluye `signature.gpg` en el paquete final `.nho`.



## Ejemplo de uso seguro
    
    
    # Instalar con verificación forzada
    sudo nhopkg --verify-package-signature -i gimp-3.0.4-n2025.linux-x86_64.nho
    
    # Desactivar verificación temporalmente (solo para desarrollo)
    sudo nhopkg --no-verify-package-signature -i paquete-local.nho

## Recomendaciones

  * Mantén `NHOPKG_VERIFY_SIGNATURE=yes` en entornos de producción.
  * Usa `NHOPKG_REQUIRE_SIGNATURE=yes` si deseas una política estricta de solo paquetes firmados.
  * Distribuye siempre `nhopkg-repo.pub` junto con tu repositorio para facilitar la inicialización segura.
  * Protege tu clave privada de firma (`NHOPKG_SIGN_KEY`) en un entorno aislado.


