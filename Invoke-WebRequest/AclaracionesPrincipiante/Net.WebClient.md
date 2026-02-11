**Invoke-WebRequest NO utiliza internamente ni `DownloadString` ni `DownloadFile`.**

---

### ✅ Respuesta corta

Invoke-WebRequest usa las librerías modernas HTTP de .NET (principalmente **HttpClient**),
**no** la clase antigua `WebClient`, y por tanto **no llama** a esos métodos.

---

> Invoke-WebRequest no usa DownloadString ni DownloadFile,
> pero puede hacer exactamente lo mismo dependiendo de cómo lo uses.
