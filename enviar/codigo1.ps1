$contenido = Get-Content "C:\Users\usuario\Desktop\prueba.txt"
Invoke-WebRequest -Uri "http://localhost:8000/?data=$contenido"

Lo que hace es coger el contenido de un archivo
y luego se envia a ese servidor
