https://chatgpt.com/share/69849b09-6274-8011-83d8-2c129c10bad4


# Lanzar PowerShell
 
 # Sin mostrar ventana
 
# Y que PowerShell solo imprima un mensaje
 
---

## ✅ Ejemplo básico en C 

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

##  Qué hace este programa

1. Usa la API de Windows
2. Lanza `powershell.exe`
3. Le pasa un comando
4. Indica que la ventana esté oculta
5. PowerShell ejecuta el comando
6. El usuario no ve ninguna consola

---

##  Traducción a lenguaje humano

> "Windows, ejecuta PowerShell, no muestres ventana y dile que escriba un mensaje."

---

##  Lo importante que debes entender

* No es algo especial de PowerShell
* Es una capacidad normal del sistema operativo
* Cualquier programa puede lanzar otro programa así

---

##  Quédate con esta idea

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

---

## 🔴 Qué pasaba antes

Tu programa se ejecutaba dentro de:

👉 Developer Command Prompt (una consola ya existente)

Cuando llamabas a:

```c
CreateProcess(...)
```

sin ningún flag especial, Windows hacía esto por defecto:

👉 El proceso hijo **hereda la consola del padre**

Es decir:

Tu programa → ya está en una consola
PowerShell → usa ESA MISMA consola

Por eso veías:

```
Hola con ventana
```

en tu terminal actual.

No había ninguna razón para que Windows creara otra ventana.

---

## 🟡 Por qué cambiar SW_SHOW no solucionó nada

Esto confunde mucho.

```c
si.wShowWindow = SW_SHOW;
```

Solo significa:

👉 Si el proceso tiene ventana, muéstrala

Pero:

❗ No crea una consola nueva
❗ No rompe la herencia

Así que PowerShell seguía usando la consola heredada.

Resultado: nada visible nuevo.

---

## 🟢 Qué cambia con CREATE_NEW_CONSOLE

Cuando añades:

```c
CREATE_NEW_CONSOLE
```

Le estás diciendo explícitamente a Windows:

👉 No heredes la consola del padre
👉 Crea una consola nueva para el hijo

Entonces Windows:

1. Crea nueva ventana de consola
2. Lanza PowerShell dentro

Ahora sí ves una ventana nueva.

---

## 🧠 Diferencia clave

| Concepto           | Qué hace                      |
| ------------------ | ----------------------------- |
| SW_SHOW            | Muestra una ventana si existe |
| CREATE_NEW_CONSOLE | Crea una ventana nueva        |

Son niveles distintos.

---

## 🎯 Frase final

Antes PowerShell ya tenía consola (la tuya).
Ahora PowerShell tiene **su propia consola**.

---

## 🧠 Regla de oro

Si ejecutas un programa desde una terminal, sus hijos usarán esa terminal salvo que tú lo impidas.

---

