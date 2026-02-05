# Políticas de Ejecución en PowerShell

Las **políticas de ejecución** de PowerShell no deben considerarse al mismo nivel que un antivirus.  
No detectan malware ni analizan comportamiento: simplemente **controlan si un script puede ejecutarse**.

Aun así, pueden considerarse una **barrera de seguridad adicional**, ya que impiden la ejecución directa de scripts en determinados contextos.

Desde el punto de vista ofensivo, existen varias formas de evadir estas restricciones.  
La más sencilla consiste en **no ejecutar archivos**, sino **ejecutar directamente texto en memoria**.

Las políticas de ejecución **solo se aplican a archivos**, no al código introducido como texto en la consola.

---

## Ejecución normal de un script

```powershell
PS C:\Users\Eduardo\Desktop> .\prueba.ps1
Hola, soy un script
Consultar políticas de ejecución
PS C:\Users\Eduardo\Desktop> Get-ExecutionPolicy -List

        Scope ExecutionPolicy
        ----- ---------------
MachinePolicy       Undefined
   UserPolicy       Undefined
      Process       Undefined
  CurrentUser    RemoteSigned
 LocalMachine       Undefined
Esto indica que, para el usuario actual, la política es RemoteSigned.

Bloquear la ejecución de scripts
PS C:\Users\Eduardo\Desktop> Set-ExecutionPolicy Restricted -Scope CurrentUser
Intentando ejecutar el script:

PS C:\Users\Eduardo\Desktop> .\prueba.ps1
.\prueba.ps1 : No se puede cargar el archivo C:\Users\Eduardo\Desktop\prueba.ps1 porque la ejecución de scripts está deshabilitada en este sistema.
La política Restricted impide cualquier ejecución de scripts.

Restaurar ejecución con RemoteSigned
PS C:\Users\Eduardo\Desktop> Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Verificación:

PS C:\Users\Eduardo\Desktop> .\prueba.ps1
Hola, soy un script
Conclusiones
Las políticas de ejecución no son un mecanismo de seguridad fuerte.

Están diseñadas para prevenir ejecuciones accidentales, no ataques.

Código ejecutado como texto no está sujeto a estas políticas.

Un atacante puede ejecutar payloads sin necesidad de guardar archivos en disco.
