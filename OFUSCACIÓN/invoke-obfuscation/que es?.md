
# 1️⃣ ¿Quién lo creó?

Lo creó **Daniel Bohannon**, investigador en seguridad ofensiva.

Fue presentado alrededor de 2016 en conferencias como:

* DerbyCon
* Black Hat Arsenal

---

# 2️⃣ ¿Con qué objetivo se creó?

Objetivo principal:

> Demostrar que la detección basada en firmas de PowerShell era muy débil.

En aquel momento, muchos antivirus detectaban cosas como:

```powershell
IEX
DownloadString
Net.WebClient
```

Bohannon demostró que:

* Si cambias la forma sintáctica
* Si fragmentas cadenas
* Si aplicas encoding
* Si usas construcción dinámica

La detección fallaba.

Era una prueba de concepto contra detección estática.

---

# 3️⃣ ¿Es buena herramienta?

Sí, pero con contexto.

### ✔ Es buena para:

* Aprender cómo funciona la ofuscación
* Entender evasión básica
* Laboratorios de Red Team
* Estudiar detección defensiva

### ❌ No es:

* Una herramienta moderna de evasión contra EDR actuales
* Algo indetectable hoy en día

Los EDR modernos:

* Decodifican Base64 automáticamente
* Analizan Script Block Logging
* Analizan comportamiento, no solo texto

---

# 4️⃣ ¿Hace lo que promete?

Sí.

Hace muy bien:

* Ofuscación sintáctica
* Reescritura dinámica
* Encoding
* Generación de launchers (`-EncodedCommand`, `cmd`, etc.)

Lo que no hace:

* No evade análisis de comportamiento
* No evade AMSI moderno sin técnicas adicionales

---

# 5️⃣ ¿Qué tipos de ofuscación utiliza?

Se puede dividir en 5 grandes categorías:

---

## 🔹 1. String Obfuscation

Ejemplo:

```powershell
"Invoke-Expression"
```

→

```powershell
('Invo'+'ke-Ex'+'pression')
```

O usando:

* Formato `-f`
* Reemplazos
* Substrings
* Casting raro

---

## 🔹 2. Token Obfuscation

Reescribe comandos usando sintaxis alternativa.

Ejemplo:

```powershell
Get-Process
```

Puede convertirse en:

```powershell
&(Get-Command g*p*)
```

---

## 🔹 3. Encoding

Convierte a:

* Base64 (UTF-16LE)
* Hex
* ASCII
* Reversed strings

Especialmente útil para `-EncodedCommand`.

---

## 🔹 4. Launcher Generation

Genera payload listo para ejecutar como:

```powershell
powershell.exe -EncodedCommand XXXXX
```

También puede generar:

* cmd launcher
* mshta
* etc.

---

## 🔹 5. AST manipulation básica

Reestructura el código sin cambiar funcionalidad.

---

# 6️⃣ Modo interactivo vs no interactivo

## 🔹 Modo no interactivo (archivo)

Tú le pasas:

```
prueba.ps1
```

Y te deja aplicar transformaciones al archivo completo.

Más usado para:

* Preparar payload final
* Automatización

---

## 🔹 Modo interactivo (scriptblock)

Tú escribes directamente:

```
SET SCRIPTBLOCK Get-Process
```

Y aplicas técnicas sobre ese bloque.

Más usado para:

* Experimentar
* Laboratorio
* Entender técnicas

---

# 7️⃣ ¿Se usa mucho en hacking?

Históricamente: muchísimo.

Entre 2016–2019 fue muy popular en:

* Red Team
* Malware básico
* Frameworks ofensivos

Hoy en día:

* Se sigue usando en laboratorios
* Se estudia en Blue Team para entender evasión
* Pero actores avanzados usan técnicas más sofisticadas

---

# 8️⃣ ¿Se usa en Red Team profesional?

Sí, pero como herramienta educativa.

En equipos serios se usa más:

* Obfuscación custom
* Técnicas AMSI bypass dinámicas
* Reflective loading
* In-memory execution avanzada

Invoke‑Obfuscation es más:

> Herramienta didáctica + baseline de evasión.
