### **1. El problema: "No se ejecuta mi script porque la política lo bloquea"**
Cuando intentas ejecutar un archivo `.ps1`, si la política está en **Restricted** o **RemoteSigned**, aparecerá un mensaje como este:
> "El script no puede ejecutarse porque la política de ejecución está configurada en Restricted."

Esto sucede porque PowerShell está protegiéndote de posibles scripts dañinos. 

---

### **2. ¿Por qué usar un archivo `.bat` o `.cmd` evita este problema?**
Un archivo `.bat` o `.cmd` es un **script de comandos de Windows** (no PowerShell), que se ejecuta en la consola `cmd.exe`. Al crear uno de estos archivos, puedes **forzar a PowerShell a ignorar las políticas de ejecución temporalmente** al incluir el parámetro `-ExecutionPolicy Bypass`.

**Ejemplo de un archivo `.bat`:**
```bat
@echo off
powershell.exe -ExecutionPolicy Bypass -File "C:\ruta\a\mi_script.ps1"
```

- **`-ExecutionPolicy Bypass`**: Ignora temporalmente todas las políticas de ejecución para este script.
- **`-File "ruta\archivo.ps1"`**: Ejecuta el script PowerShell que quieres correr.

Al usar este método, PowerShell no pregunta por la política, ya que la ignoramos explícitamente.

---

### **3. Cómo implementarlo paso a paso**
1. **Crea un archivo `.bat` o `.cmd`**:
   - Abre Bloc de Notas.
   - Escribe el código del ejemplo anterior, ajustando la ruta a tu script `.ps1`.
   - Guarda el archivo con extensión `.bat` (ejemplo: `ejecutar_script.bat`).

2. **Ejecuta el archivo `.bat`**:
   - Al doblar clic en `ejecutar_script.bat`, PowerShell iniciará y ejecutará tu script ignorando la política.
