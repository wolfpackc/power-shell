# No son lo mismo y no se crean igual.
## .lnk (acceso directo)

No es un archivo de comandos.

Es un acceso directo de Windows que apunta a un archivo o programa.

Contiene la ruta del programa que quieres ejecutar, icono, etc.

No puedes “crear un .lnk escribiendo comandos en VS Code” como un .bat.

### Se crea normalmente desde Windows:

Botón derecho → Nuevo → Acceso directo

Escribes la ruta del archivo o programa

Guardas → .lnk

### También se puede crear con PowerShell usando código, pero eso ya es scripting.

 Diferencia clave
Tipo	Qué es	Cómo se crea	Qué hace
.bat / .cmd	Texto con comandos CMD	VS Code, Notepad, cualquier editor	Se ejecuta en CMD
.lnk	Acceso directo de Windows	Windows GUI o PowerShell	Apunta a un archivo o programa, se ejecuta cuando haces clic
⚡ Resumen simple

.bat → escribes comandos → VS Code → CMD los ejecuta

.lnk → acceso directo → apunta a cualquier archivo → doble clic lo ejecuta

---
---

### **1. Por qué no puedes crear un `.lnk` como un `.bat`/`.cmd`**
- **`.bat`/`.cmd`** son archivos de **texto plano**, por lo que puedes crearlos abriendo un editor como Bloc de Notas, escribiendo comandos y guardándolos con extensión `.bat` o `.cmd`.
- **`.lnk`** son **archivos binarios** con una estructura específica que no puedes crear simplemente escribiendo texto. **Necesitas herramientas o scripts** que generen este formato.

---

### **2. Métodos para crear un `.lnk` (enlaces de acceso directo)**
#### **Método 1: Crear manualmente usando el menú contextual de Windows (sin código)**
Es el método más sencillo y no requiere PowerShell:

1. **Hacer clic derecho en el escritorio o en una carpeta**.
2. **Elige "Nuevo" → "Acceso directo"**.
3. **En el asistente**:
   - **Ruta del objeto**: Escribe el programa o comando que quieres ejecutar (ej: `powershell.exe`).
   - **Nombre del acceso directo**: Da un nombre engañoso (ej: `documento_urgente.pdf.lnk`).
4. **Personalizar el ícono** (opcional):
   - Hacer clic derecho en el enlace → **Propiedades** → Pestaña **"Personalizar este acceso directo"** → Botón **"Cambiar ícono"** → Elige un ícono falso (ej: `shell32.dll`, ícono de PDF).

**Resultado**: Tendrás un `.lnk` que aparenta ser otro tipo de archivo.

---

#### **Método 2: Usar PowerShell**
Si quieres automatizarlo, PowerShell es la herramienta ideal. Aquí te explico el código paso a paso:

**Ejemplo de código PowerShell**:
```powershell
# Crea un acceso directo que apunte a PowerShell pero parezca un PDF
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("C:\Ruta\Donde\Guardar\documento_confidencial.pdf.lnk")
$Shortcut.TargetPath = "powershell.exe"  # Ejecuta PowerShell
$Shortcut.Arguments = "-Command 'Write-Output ''¡Has sido engañado!'''"
$Shortcut.IconLocation = "C:\Windows\System32\shell32.dll,4"  # Ícono de PDF
$Shortcut.Save()
```

**Explicación**:
- **`New-Object -ComObject WScript.Shell`**: Crea un objeto para interactuar con el sistema.
- **`CreateShortcut()`**: Genera el archivo `.lnk`.
- **`TargetPath`**: Programa o comando a ejecutar.
- **`IconLocation`**: Ícono falso (el número `4` corresponde al ícono de PDF en `shell32.dll`).

---

#### **Método 3: Usar un script `.vbs` (Visual Basic Script)**
Si prefieres no usar PowerShell, puedes crear un `.vbs` que genere el `.lnk`:

**Ejemplo de código `.vbs`**:
```vbscript
Set WshShell = CreateObject("WScript.Shell")
Set oLink = WshShell.CreateShortcut("C:\Ruta\Donde\Guardar\actualizacion_windows.lnk")
oLink.TargetPath = "powershell.exe"
oLink.Arguments = "-Command 'Write-Output ''¡Error!'''"
oLink.IconLocation = "C:\Windows\System32\shell32.dll,15"  # Ícono de Windows Update
oLink.Save
```

**Pasos**:
1. Abre Bloc de Notas.
2. Copia el código anterior.
3. Guarda el archivo como `crear_enlace.vbs`.
4. Ejecútalo (doble clic).

---

#### **Método 4: Usar el comando `mklink` en CMD**
Este método crea enlaces simbólicos (no `.lnk`, pero sirve para enlazar archivos):

**Ejemplo en CMD**:
```cmd
mklink "C:\Ruta\Donde\Guardar\documento_secreto.txt.lnk" "C:\Windows\System32\cmd.exe"
```

**Nota**: Esto crea un enlace simbólico (`.lnk` no es exactamente lo mismo, pero cumple un propósito similar).

---

### **3. Por qué no puedes crear un `.lnk` en Bloc de Notas o VS Code**
- **Formato binario**: Los `.lnk` no son texto plano, sino archivos binarios con una estructura específica. Si intentas abrir uno en Bloc de Notas, verás caracteres extraños o código binario incomprensible.
- **Requiere herramientas**: Necesitas utilidades como PowerShell, VBScript, o el menú contextual de Windows para generar el formato correcto.

---

### **4. Ejemplo práctico: Crear un `.lnk` que parezca un archivo de texto**
**Objetivo**: Un enlace que aparente ser un `.txt` pero ejecute PowerShell.

#### **Pasos usando el menú contextual (sin código)**:
1. Haz clic derecho en el escritorio → **Nuevo** → **Acceso directo**.
2. En **Ruta del objeto**, escribe:
   ```
   powershell.exe -Command "Write-Output '¡Hola!'" 
   ```
3. Da clic en **Siguiente** → Nombre del acceso directo: `nota_urgente.txt.lnk`.
4. Personaliza el ícono a uno de un archivo de texto (ej: `C:\Windows\System32\imageres.dll,113`).

**Resultado**: El enlace parecerá un `.txt`, pero ejecutará PowerShell.

---

### **5. Resumen de diferencias clave**
| **Característica**          | **`.lnk`**                                                                 | **`.bat`/`.cmd`**                                                                 |
|----------------------------|---------------------------------------------------------------------------|---------------------------------------------------------------------------------|
| **Creación**                | Requiere herramientas (PowerShell, menú contextual, etc.).                | Puedes crearlo directamente en Bloc de Notas o VS Code.                          |
| **Formato**                 | Binario (no editable con editores de texto).                             | Texto plano (código visible).                                                   |
| **Ocultación de acciones**  | Alta (íconos falsos y nombres engañosos).                               | Baja (código legible).                                                           |
| **Ejecución automática**    | Puede ejecutarse al abrir (si el sistema lo permite).                   | Siempre requiere doble clic o ejecución manual.                                 |

---

### **6. Recomendación para ti**
Si prefieres no usar PowerShell, usa el **menú contextual de Windows** para crear enlaces simples. Para cosas más avanzadas (como íconos falsos o parámetros complejos), usa PowerShell o VBScript. 

**Ejemplo final sencillo (sin código):**
- Crea un acceso directo manual para `powershell.exe`.
- Cambia su nombre a `actualizar_software.exe.lnk`.
- Cambia su ícono a uno de instalador (ej: `C:\Windows\System32\setup.exe,0`).

¡Así tendrás un `.lnk` que parezca un instalador pero ejecuta PowerShell! 😊
