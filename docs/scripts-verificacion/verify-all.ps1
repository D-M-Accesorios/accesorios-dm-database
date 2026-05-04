# verify-all.ps1
# Verificar los 3 ambientes

Write-Host "🚀 INICIANDO VERIFICACIÓN DE LOS 3 AMBIENTES" -ForegroundColor Magenta
Write-Host ""

Write-Host "🔵 DESARROLLO (puerto 5432)" -ForegroundColor Blue
.\verify-develop.ps1

Write-Host ""
Write-Host "🟢 QA (puerto 5433)" -ForegroundColor Green
.\verify-qa.ps1

Write-Host ""
Write-Host "🔴 PRODUCCIÓN (puerto 5434)" -ForegroundColor Red
.\verify-main.ps1