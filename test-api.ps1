# Тестовый скрипт для API
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$baseUrl = "http://localhost:3000"

Write-Host "`n=== 1. РЕГИСТРАЦИЯ ===" -ForegroundColor Green
$register = Invoke-WebRequest -Uri "$baseUrl/auth/register" -Method POST `
    -Headers @{"Content-Type"="application/json"} `
    -Body '{"email":"testuser2@example.com","password":"password123"}' `
    -WebSession $session -UseBasicParsing
Write-Host "Status: $($register.StatusCode)"
$register.Content | ConvertFrom-Json | ConvertTo-Json

Write-Host "`n=== 2. ЛОГИН ===" -ForegroundColor Green
$login = Invoke-WebRequest -Uri "$baseUrl/auth/login" -Method POST `
    -Headers @{"Content-Type"="application/json"} `
    -Body '{"email":"testuser2@example.com","password":"password123"}' `
    -WebSession $session -UseBasicParsing
Write-Host "Status: $($login.StatusCode)"
Write-Host "Cookies сохранены: $($session.Cookies.Count)"
$login.Content | ConvertFrom-Json | ConvertTo-Json

Write-Host "`n=== 3. СОЗДАНИЕ ЗАМЕТКИ ===" -ForegroundColor Cyan
$createNote = Invoke-WebRequest -Uri "$baseUrl/notes" -Method POST `
    -Headers @{"Content-Type"="application/json"} `
    -Body '{"title":"Тестовая заметка","content":"Содержимое заметки","tag":"Work"}' `
    -WebSession $session -UseBasicParsing
Write-Host "Status: $($createNote.StatusCode)"
$note = $createNote.Content | ConvertFrom-Json
$noteId = $note._id
Write-Host "Note ID: $noteId"
$note | ConvertTo-Json

Write-Host "`n=== 4. ПОЛУЧЕНИЕ ВСЕХ ЗАМЕТОК ===" -ForegroundColor Cyan
$allNotes = Invoke-WebRequest -Uri "$baseUrl/notes" -Method GET `
    -WebSession $session -UseBasicParsing
Write-Host "Status: $($allNotes.StatusCode)"
$allNotes.Content | ConvertFrom-Json | ConvertTo-Json

Write-Host "`n=== 5. ПОЛУЧЕНИЕ ЗАМЕТКИ ПО ID ===" -ForegroundColor Cyan
$getNote = Invoke-WebRequest -Uri "$baseUrl/notes/$noteId" -Method GET `
    -WebSession $session -UseBasicParsing
Write-Host "Status: $($getNote.StatusCode)"
$getNote.Content | ConvertFrom-Json | ConvertTo-Json

Write-Host "`n=== 6. ОБНОВЛЕНИЕ ЗАМЕТКИ ===" -ForegroundColor Yellow
$updateNote = Invoke-WebRequest -Uri "$baseUrl/notes/$noteId" -Method PATCH `
    -Headers @{"Content-Type"="application/json"} `
    -Body '{"title":"Обновленная заметка","tag":"Personal"}' `
    -WebSession $session -UseBasicParsing
Write-Host "Status: $($updateNote.StatusCode)"
$updateNote.Content | ConvertFrom-Json | ConvertTo-Json

Write-Host "`n=== 7. ОБНОВЛЕНИЕ СЕССИИ ===" -ForegroundColor Yellow
$refresh = Invoke-WebRequest -Uri "$baseUrl/auth/refresh" -Method POST `
    -WebSession $session -UseBasicParsing
Write-Host "Status: $($refresh.StatusCode)"
$refresh.Content | ConvertFrom-Json | ConvertTo-Json

Write-Host "`n=== 8. ЛОГАУТ ===" -ForegroundColor Red
$logout = Invoke-WebRequest -Uri "$baseUrl/auth/logout" -Method POST `
    -WebSession $session -UseBasicParsing
Write-Host "Status: $($logout.StatusCode)"

Write-Host "`n=== ТЕСТИРОВАНИЕ ЗАВЕРШЕНО ===" -ForegroundColor Green



