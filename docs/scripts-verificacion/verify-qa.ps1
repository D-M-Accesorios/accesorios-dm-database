@'
# verify-qa.ps1
# Script de verificacion para ambiente QA (puerto 5433)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "VERIFICANDO BASE DE DATOS - QA" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Variables
$CONTAINER = "accesorios-dm-postgres-qa"
$DB = "accesorios_dm_db"
$USER = "admin"

Write-Host "Verificando que el contenedor esta corriendo..." -ForegroundColor Yellow
docker ps --filter "name=$CONTAINER" --format "table {{.Names}}   {{.Status}}"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "1. SCHEMAS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
docker exec -it $CONTAINER psql -U $USER -d $DB -c "\dn"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "2. TABLAS - PRINCIPALES" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "security.rol:" -ForegroundColor Yellow
docker exec -it $CONTAINER psql -U $USER -d $DB -c "SELECT COUNT(*) FROM security.rol;"

Write-Host "clientes.cliente:" -ForegroundColor Yellow
docker exec -it $CONTAINER psql -U $USER -d $DB -c "SELECT COUNT(*) FROM clientes.cliente;"

Write-Host "catalogo.producto:" -ForegroundColor Yellow
docker exec -it $CONTAINER psql -U $USER -d $DB -c "SELECT COUNT(*) FROM catalogo.producto;"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "3. DATOS INICIALES" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "Roles:" -ForegroundColor Yellow
docker exec -it $CONTAINER psql -U $USER -d $DB -c "SELECT id_rol, nombre FROM security.rol;"

Write-Host "Productos (primeros 5):" -ForegroundColor Yellow
docker exec -it $CONTAINER psql -U $USER -d $DB -c "SELECT id_producto, nombre, precio, stock FROM catalogo.producto LIMIT 5;"

Write-Host "Total de productos:" -ForegroundColor Yellow
docker exec -it $CONTAINER psql -U $USER -d $DB -c "SELECT COUNT(*) as total_productos FROM catalogo.producto;"

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "VERIFICACION COMPLETADA - QA" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
'@ | Out-File -FilePath "docs\scripts-verificacion\verify-qa.ps1" -Encoding ASCII