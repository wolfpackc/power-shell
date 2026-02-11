**Invoke-WebRequest NO utiliza internamente ni `DownloadString` ni `DownloadFile`.**

---

### ✅ Respuesta corta

Invoke-WebRequest usa las librerías modernas HTTP de .NET (principalmente **HttpClient**),
**no** la clase antigua `WebClient`, y por tanto **no llama** a esos métodos.

---

###  Lo importante

Aunque **no use esos comandos**, puede **comportarse como si lo hiciera**:

* Sin `-OutFile` → se comporta *como* `DownloadString`
* Con `-OutFile` → se comporta *como* `DownloadFile`

Pero solo a nivel de **resultado**, no de implementación interna.

---

###  Resumen en una frase

> Invoke-WebRequest no usa DownloadString ni DownloadFile,
> pero puede hacer exactamente lo mismo dependiendo de cómo lo uses.
