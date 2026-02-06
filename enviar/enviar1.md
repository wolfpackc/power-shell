# 🎯 IDEA ÚNICA

Desde PowerShell se pueden **mandar datos a un servidor** usando una petición web.

Nada más.

---

## ✅ Ejemplo mínimo

Copia y pega esto:

```powershell
Invoke-WebRequest -Uri "http://localhost:8000" -Method POST -Body "hola"
```

Eso es todo.

---

## 🧠 Qué significa línea por línea

```powershell
Invoke-WebRequest
```

→ Herramienta para hablar por web

```powershell
-Uri "http://localhost:8000"
```

→ Dirección del servidor

```powershell
-Method POST
```

→ Tipo de envío

```powershell
-Body "hola"
```

→ El mensaje que mandas

---

## 🧩 Traducción a lenguaje humano

> "Oye servidor, aquí tienes el texto: hola"

---

## 🔁 Si quieres mandar algo del sistema

```powershell
Invoke-WebRequest -Uri "http://localhost:8000" -Method POST -Body $env:USERNAME
```

Envía tu nombre de usuario.

---

## 🔥 Qué debes quedarte

Si ves esto en un script:

```powershell
-Method POST
```

Significa:

👉 Está **enviando información**

---
