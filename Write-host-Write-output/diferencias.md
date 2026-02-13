
# 🟢 `Write-Output`

👉 Envía datos al **pipeline (canal de salida)**

```powershell
Write-Output "Hola"
```

Equivale a:

```powershell
"Hola"
```

### Qué significa esto:

* El texto **se convierte en objeto**
* Puede ser:

  * Redirigido
  * Filtrado
  * Guardado
  * Pasado a otros comandos

Ejemplo:

```powershell
Write-Output "Hola" | Out-File texto.txt
```

Resultado:

📄 `texto.txt` contiene `Hola`

---

# 🔴 `Write-Host`

👉 Escribe **directamente en pantalla**

```powershell
Write-Host "Hola"
```

### Qué significa esto:

* **No envía nada al pipeline**
* Solo pinta texto en consola
* No puede ser redirigido

Ejemplo:

```powershell
Write-Host "Hola" | Out-File texto.txt
```

Resultado:

📄 El archivo queda vacío

---

# 🧠 Diferencia conceptual

| Característica    | Write-Output | Write-Host |
| ----------------- | ------------ | ---------- |
| Va al pipeline    | ✅            | ❌          |
| Puede redirigirse | ✅            | ❌          |
| Útil para scripts | ✅            | ❌          |
| Solo visual       | ❌            | ✅          |

---

# 🎯 Regla de oro

✅ Usa **Write-Output** para datos
⚠️ Usa **Write-Host** solo para mensajes visuales (colores, banners, avisos)

---

# 🧪 Ejemplo real

```powershell
function Get-Saludo {
    Write-Output "Hola"
}

$texto = Get-Saludo
$texto.ToUpper()
```

Funciona.

Pero con:

```powershell
function Get-Saludo {
    Write-Host "Hola"
}
```

Rompe, porque no devuelve nada.

---

# 🎨 Único caso válido para Write-Host

Colores y UI:

```powershell
Write-Host "ERROR" -ForegroundColor Red
```

---

# 🧠 Analogía rápida

* `Write-Output` = devuelve un valor
* `Write-Host` = imprime en pantalla

Como en programación:

```python
return "Hola"   # Write-Output
print("Hola")   # Write-Host
```


# En PowerShell, **`Write-Output` se comporta como un `return` implícito**.

Pero con un matiz importante:

---

# ✅ `Write-Output` ≈ `return`

Cuando haces:

```powershell
Write-Output "Hola"
```

PowerShell:

👉 Envía `"Hola"` al **pipeline**
👉 Es como si hicieras:

```powershell
return "Hola"
```

De hecho, esto también es válido:

```powershell
"Hola"
```

PowerShell automáticamente lo trata como salida.

---

# ⚠️ Diferencia entre `return` y `Write-Output`

Aunque parezcan iguales, **no son idénticos**.

---

## 🔹 `return`

```powershell
return "Hola"
```

* Devuelve el valor
* **Termina la función inmediatamente**

Ejemplo:

```powershell
function Test {
    Write-Output "Antes"
    return "Centro"
    Write-Output "Después"
}
```

Salida:

```
Antes
Centro
```

Nunca imprime "Después".

---

## 🔹 `Write-Output`

```powershell
Write-Output "Hola"
```

* Devuelve el valor
* **La función continúa ejecutándose**

Ejemplo:

```powershell
function Test {
    Write-Output "Uno"
    Write-Output "Dos"
}
```

Salida:

```
Uno
Dos
```

---

# 🧠 Regla práctica

✔️ Si quieres **emitir datos** → `Write-Output`
✔️ Si quieres **salir ya de la función** → `return`

---

# 🧠 Analogía rápida

```text
Write-Output  = enviar valor
return        = enviar valor + salir
```

---

# 🎯 Frase para memorizar

> `Write-Output` es como un `return` sin freno.
> `return` es como un `Write-Output` con freno de mano.
