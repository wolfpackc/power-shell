
Voy por capas.

---

# 🧱 1️⃣ Qué es un proceso (de verdad)

Un **proceso** es:

👉 Un programa en ejecución
👉 Con su propio espacio de memoria
👉 Con recursos asignados por el sistema operativo

No es solo un `.exe`.

Ejemplo:

```
notepad.exe (archivo)
↓
doble click
↓
proceso notepad.exe
```

Ese proceso tiene:

* Memoria
* Identificador único (PID)
* Hilos (threads)
* Handles (manejadores)
* Variables de entorno
* Token de seguridad
* Consola (o no)
* Directorio actual

Piensa en el proceso como un **contenedor vivo**.

---

# 🧠 2️⃣ Identidad básica de un proceso

Cada proceso tiene:

| Propiedad    | Qué es                  |
| ------------ | ----------------------- |
| PID          | Número único            |
| PPID         | PID del proceso padre   |
| Usuario      | Con qué permisos corre  |
| Arquitectura | 32 o 64 bits            |
| Sesión       | Qué usuario interactivo |

Ejemplo:

```
explorer.exe  -> padre
  └─ powershell.exe -> hijo
```

Relación padre-hijo.

---

# 🔁 3️⃣ Qué es un HANDLE

Un **handle** es:

👉 Un número que representa acceso a algo

No es el objeto.

Es una **referencia**.

Como un ticket.

Ejemplo mental:

```
Archivo real en disco
↓
Windows crea objeto interno
↓
Tu proceso recibe número: 0x000004A8
```

Ese número es el handle.

---

# 🧩 Cosas que se representan con handles

* Archivos
* Procesos
* Hilos
* Pipes
* Sockets
* Consolas
* Claves de registro

TODO se maneja así.

---

# 📦 4️⃣ Qué contiene un proceso internamente

Simplificado:

```
Proceso
 ├── Memoria
 ├── Threads
 ├── Tabla de Handles
 ├── Token de seguridad
 ├── Variables entorno
 └── Información consola
```

La **tabla de handles** es clave:

```
Handle 0x10 → Archivo A
Handle 0x20 → Socket
Handle 0x30 → Consola
```

---

#  5️⃣ Herencia de handles

Cuando un proceso crea otro:

```
Padre → CreateProcess → Hijo
```

El hijo puede heredar:

* Consola
* Archivos abiertos
* Pipes

Si están marcados como heredables.

Por defecto:

👉 La consola se hereda

Por eso pasaba lo tuyo.

---

# 🎮 6️⃣ Consola ≠ PowerShell

Muy importante:

La consola es una **ventana**.
PowerShell es un **programa**.

Puedes tener:

* cmd.exe en consola
* powershell.exe en consola
* python.exe en consola

La consola es como una TV.
El programa es el canal.

---

# 🪟 7️⃣ Tipos de procesos según interfaz

| Tipo       | Ejemplo         |
| ---------- | --------------- |
| Consola    | cmd, powershell |
| GUI        | notepad, chrome |
| Servicio   | antivirus       |
| Background | actualizadores  |

Un proceso puede existir **sin ventana**.

---

# 🔥 8️⃣ Qué decide si hay ventana

Tres cosas:

1. Tipo de programa
2. Flags al crearlo
3. Si hereda consola

No es automático.

---

# ⚙️ 9️⃣ Token de seguridad (permisos)

Cada proceso tiene un token:

* Usuario
* Grupos
* Privilegios

Ejemplo:

```
Usuario normal
Administrador
SYSTEM
```

El proceso **no puede hacer más** de lo que permite su token.

---

#  🔟 Threads

Un proceso puede tener muchos hilos:

```
Proceso
 ├─ Thread 1
 ├─ Thread 2
 └─ Thread 3
```

El código se ejecuta dentro de threads, no directamente en procesos.

---

# 🧠 1️⃣1️⃣ Qué puedes hacer con un proceso

Si tienes permisos:

* Leer memoria
* Escribir memoria
* Crear hilos
* Matarlo
* Inyectar DLL
* Duplicar handles

Todo depende del token.

---

# 🧩 1️⃣2️⃣ Cadena típica

```
Usuario abre Word
Word crea powershell
Powershell crea otro proceso
```

Cada salto hereda cosas.

---

#  FRASE CLAVE (quédate con esto)

👉 Un proceso es un contenedor de memoria, hilos y recursos; los recursos se acceden mediante handles; y cuando un proceso crea otro, algunos recursos se heredan automáticamente.

---

#  Por qué esto es vital para hacking

Porque:


* Puedes colarte en procesos
* Puedes heredar permisos
* Puedes reutilizar handles
* Puedes esconder ejecución

Pero eso viene después 😉

---

