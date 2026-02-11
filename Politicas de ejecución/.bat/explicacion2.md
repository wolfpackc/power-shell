### **1. ¿Qué es un archivo `.bat` o `.cmd`?**
Son **archivos de script de comandos de Windows** que ejecutan secuencias de comandos en la consola `cmd.exe`. Son simples y versátiles, permitiendo:
- Automatizar tareas del sistema.
- Ejecutar aplicaciones.
- Invocar otros scripts (como PowerShell).

**Diferencias clave entre `.bat` y `.cmd`:**
- **`.bat`**: Formato antiguo (heredado de DOS).
- **`.cmd`**: Formato moderno (introducido en Windows NT), con mejoras en el manejo de variables y errores.
- Ambos son compatibles en Windows, pero `.cmd` es preferible.

---

### **2. ¿Cómo interactúan con PowerShell?**
Un archivo `.bat`/`.cmd` puede **llamar a PowerShell** usando el comando:
```bat
powershell.exe [parámetros] [comandos o script]
```
Por ejemplo:
```bat
@echo off
powershell.exe -Command "Write-Output 'Hola desde PowerShell!'"
```

---

### **3. Parámetros clave para ejecutar PowerShell desde un `.bat`**
#### **a. `-ExecutionPolicy`**
Controla la política de ejecución **solo para esta sesión** de PowerShell:
- **`-ExecutionPolicy Bypass`**: Ignora **totalmente** la política del sistema.
- **`-ExecutionPolicy RemoteSigned`**: Permite ejecutar scripts locales no firmados.
- **`-ExecutionPolicy Unrestricted`**: Ejecuta cualquier script sin verificar firmas.

**Ejemplo:**
```bat
powershell.exe -ExecutionPolicy Bypass -File "C:\ruta\script.ps1"
```

#### **b. `-File`**
Ejecuta un **archivo de script de PowerShell** (`.ps1`).

#### **c. `-Command`**
Ejecuta **comandos directos** en PowerShell:
```bat
powershell.exe -Command "Get-Process | Where-Object CPU -gt 50"
```

#### **d. `-NoExit`**
Mantiene la ventana de PowerShell abierta después de ejecutar el script.

---

### **4. Flujo técnico de ejecución**
Supongamos que tienes un archivo `ejemplo.bat` con:
```bat
@echo off
echo Iniciando el script...
powershell.exe -ExecutionPolicy Bypass -Command "& {Start-Process powershell -ArgumentList '-File C:\ruta\script.ps1' -Verb RunAs}"
```

**Pasos que ocurren:**
1. **Ejecución del `.bat`**:
   - `cmd.exe` lee el archivo línea por línea.
   - `@echo off` desactiva la visualización de comandos.
   - `echo Iniciando el script...` muestra un mensaje.

2. **Invocación de PowerShell**:
   - `powershell.exe` se inicia con los parámetros dados.
   - **`-ExecutionPolicy Bypass`**: Ignora temporalmente la política de ejecución.
   - **`-Command "& { ... }"`**: Ejecuta un bloque de comandos anónimos.
   - **`Start-Process`**: Inicia una nueva instancia de PowerShell con privilegios elevados (si `-Verb RunAs`).
   - **`-ArgumentList '-File ...'`**: Pasa el parámetro `-File` con la ruta al script.

3. **Ejecución del script `.ps1`**:
   - El segundo proceso de PowerShell carga y ejecuta `script.ps1` sin restricciones (por el `Bypass`).

---

### **5. ¿Por qué evita las políticas de ejecución?**
- **Al invocar PowerShell desde el exterior** (como un `.bat`), puedes **sobreescribir temporalmente** la política de ejecución.
- La política del sistema aplica solo cuando se inicia PowerShell **directamente** (ej: desde el menú Inicio o la línea de comandos).
- Al usar `-ExecutionPolicy Bypass`, se ignora la política **solo para esta sesión**, sin alterar la configuración global.

---

### **6. Uso ético y recomendaciones**
#### **a. Automatización segura**
- Si necesitas distribuir scripts, firma digitalmente tus archivos `.ps1`:
  ```powershell
  # Crear un certificado autoemitido (ejemplo)
  $cert = New-SelfSignedCertificate -Subject "CN=MiCertificado" -CertStoreLocation "Cert:\CurrentUser\My"
  Set-AuthenticodeSignature -Certificate $cert -FilePath "C:\ruta\script.ps1"
  ```
- Configura la política del sistema a `RemoteSigned` o `AllSigned`.

#### **b. Evita riesgos**
- **Nunca uses `-ExecutionPolicy Bypass` en entornos críticos** sin supervisión.
- Si compartes scripts, incluye un `.bat` que use `Bypass` **solo si es estrictamente necesario**.


### **7. Ejemplos avanzados**
#### **a. Ejecutar PowerShell como administrador**
```bat
@echo off
powershell.exe -ExecutionPolicy Bypass -Command "Start-Process powershell -Verb RunAs -ArgumentList '-File C:\ruta\script.ps1'"
```

#### **b. Mostrar mensajes en la consola**
```bat
@echo off
echo Iniciando script...
powershell.exe -Command "Write-Host '¡Bienvenido!' -ForegroundColor Green"
echo Script finalizado.
```

#### **c. Capturar salida del script**
```bat
@echo off
powershell.exe -ExecutionPolicy Bypass -File "C:\ruta\script.ps1" > salida.txt
echo Resultado guardado en salida.txt
```

- **Nunca compartas scripts sin firmar** en entornos profesionales.
