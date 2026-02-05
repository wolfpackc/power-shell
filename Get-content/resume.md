este comando es simple pero la ostia de útil

tu le pasas un archivo y con este comando obtienes el contenido de ese archivo.

$dato= Get-Content "C:"


Muy buena observación 👏
Y la respuesta es:

👉 En PowerShell **puedes unir strings de DOS formas**:

---

# ✅ Forma 1 — Con interpolación (la que usaste)

```powershell
$todo = "USER=$u FILE=$f"
```

Aquí PowerShell **mete automáticamente** las variables dentro del texto.

Esto se llama **string interpolation**.

Es la forma más cómoda.

---

# ✅ Forma 2 — Con el operador +

También podrías escribirlo así:

```powershell
$todo = "USER=" + $u + " FILE=" + $f
```

Funciona exactamente igual.

---

# 🧠 Comparación clara

Estas dos líneas producen lo mismo:

```powershell
$todo = "USER=$u FILE=$f"
```

```powershell
$todo = "USER=" + $u + " FILE=" + $f
```

Resultado:

```
USER=usuario FILE=miclave123
```

---

# 🎯 Entonces… ¿cuál usar?

En PowerShell se prefiere:

👉 **Interpolación con comillas dobles**

Porque:

* Es más corta
* Más legible
* Menos errores

---

# ⚠️ Ojo importante

Solo funciona con **comillas dobles**:

```powershell
"hola $u"   # ✅
'hola $u'   # ❌ (no sustituye)
```
