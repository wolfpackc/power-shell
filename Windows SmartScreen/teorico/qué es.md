#  ¿Qué es Windows SmartScreen?


Su función es avisar al usuario cuando intenta ejecutar algo que **proviene de Internet** o que **no tiene buena reputación**.

No analiza código como un antivirus clásico:
se basa principalmente en:

* Origen del archivo
* Firma digital
* Reputación en la nube de Microsoft

✔ SmartScreen se basa en reputación
✔ Se activa sobre todo si existe ZoneId=3
✔ ZoneId es un ADS llamado Zone.Identifier
✔ El aviso aparece al ejecutar, no al descargar
✔ El usuario puede saltárselo

---

# 📌 ¿Cuándo entra en juego SmartScreen?

Principalmente cuando:

* Ejecutas un `.exe`
* Abres un `.msi`
* Ejecutas un `.bat`, `.cmd`
* Abres un `.ps1`
* Abres un `.lnk`

**Y** el archivo tiene marcado que viene de Internet.

---

# 🧷 Zone Identifier (ADS)

### Significado de ZoneId

| Valor | Origen              |
| ----- | ------------------- |
| 0     | Mi PC               |
| 1     | Intranet            |
| 2     | Sitios confiables   |
| 3     | Internet            |
| 4     | Sitios restringidos |

---

# 🔁 Relación entre ZoneId y SmartScreen

Simplificado:

✅ Si el archivo **tiene ZoneId=3**
➡ Windows sabe que viene de Internet
➡ SmartScreen se activa al ejecutarlo

Si NO tiene ZoneId:

➡ Windows lo trata como archivo local
➡ SmartScreen normalmente NO salta

---

# 🖥️ Qué ve el usuario

Cuando intenta ejecutar:

Pantalla azul:

```
Windows protegió su PC
Microsoft Defender SmartScreen evitó que se iniciara una aplicación no reconocida
```

Botón:

```
Más información
```

Luego aparece:

```
Ejecutar de todas formas
```

---

# 🧪 Ver tú mismo el ADS

En PowerShell:

```
Get-Item archivo.exe -Stream *
```

Verás algo como:

```
:$DATA
:Zone.Identifier:$DATA
```

Para ver contenido:

```
Get-Content archivo.exe -Stream Zone.Identifier
```

---

# 🧹 Quitar el Zone Identifier

Opciones:

### Desde propiedades

Clic derecho → Propiedades → Desbloquear

### Desde PowerShell

```
Unblock-File archivo.exe
```

Esto borra el ADS.

Después:

➡ SmartScreen ya no suele aparecer.

---

# ⚠️ Matiz importante

Aunque quites ZoneId:

* Defender antivirus puede seguir detectando malware
* PowerShell puede seguir bloqueando scripts por política

Son capas distintas.

---


