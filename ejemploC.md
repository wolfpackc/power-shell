https://chatgpt.com/share/69849b09-6274-8011-83d8-2c129c10bad4

Te voy a dar un **ejemplo sencillo, educativo y benigno en C**, cuyo único objetivo es:

 Lanzar PowerShell
 
 Sin mostrar ventana
 
 Y que PowerShell solo imprima un mensaje
 


---

## ✅ Ejemplo básico en C (Windows)

```c
#include <windows.h>
#include <stdio.h>

int main() {

    STARTUPINFO si;
    PROCESS_INFORMATION pi;

    ZeroMemory(&si, sizeof(si));
    ZeroMemory(&pi, sizeof(pi));

    si.cb = sizeof(si);

    // Indica que vamos a modificar cómo se muestra la ventana
    si.dwFlags = STARTF_USESHOWWINDOW;
    si.wShowWindow = SW_HIDE;   // Oculta la ventana

    // Comando que se ejecutará
    char command[] = "powershell.exe -Command \"Write-Host 'Hola desde PowerShell'\"";

    if (!CreateProcess(
        NULL,
        command,
        NULL,
        NULL,
        FALSE,
        0,
        NULL,
        NULL,
        &si,
        &pi
    )) {
        printf("Error al crear el proceso.\n");
        return 1;
    }

    // Cerramos handles
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);

    return 0;
}
```

---

## 🧠 Qué hace este programa

1. Usa la API de Windows
2. Lanza `powershell.exe`
3. Le pasa un comando
4. Indica que la ventana esté oculta
5. PowerShell ejecuta el comando
6. El usuario no ve ninguna consola

---

## 🔍 Traducción a lenguaje humano

> "Windows, ejecuta PowerShell, no muestres ventana y dile que escriba un mensaje."

---

## 📌 Lo importante que debes entender

* No es algo especial de PowerShell
* Es una capacidad normal del sistema operativo
* Cualquier programa puede lanzar otro programa así

---

## 🎯 Quédate con esta idea

**Un programa puede ejecutar PowerShell en segundo plano igual que puede ejecutar cualquier otro programa.**

---
```c
//CREAR UNA VENTANA
#include <windows.h>

int main() {

    STARTUPINFO si;
    PROCESS_INFORMATION pi;

    ZeroMemory(&si, sizeof(si));
    ZeroMemory(&pi, sizeof(pi));
    si.cb = sizeof(si);

    char command[] = "powershell.exe -Command \"Write-Host 'Hola con ventana nueva'\"";

    CreateProcess(
        NULL,
        command,
        NULL,
        NULL,
        FALSE,
        CREATE_NEW_CONSOLE,   // <- CLAVE
        NULL,
        NULL,
        &si,
        &pi
    );

    return 0;
}
```
