# verify-qa.ps1
# Script de verificación para ambiente QA (puerto 5433)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "VERIFICANDO BASE DE DATOS - QA" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Variables
$CONTAINER = "accesorios-dm-postgres-qa"
$DB = "accesorios_dm_db"
$USER = "admin"

Write-Host "📌 Verificando que el contenedor está corriendo..." -ForegroundColor Yellow
docker ps --filter "name=$CONTAINER" --format "table {{.Names}}\t{{.Status}}"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "1. VERIFICANDO SCHEMAS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
docker exec -it $CONTAINER psql -U $USER -d $DB -c "\dn"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "2. VERIFICANDO TABLAS - SECURITY" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
docker exec -it $CONTAINER psql -U $USER -d $DB -c "\dt security.*"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "3. VERIFICANDO TABLAS - CLIENTES" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
docker exec -it $CONTAINER psql -U $USER -d $DB -c "\dt clientes.*"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "4. VERIFICANDO TABLAS - CATALOGO" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
docker exec -it $CONTAINER psql -U $USER -d $DB -c "\dt catalogo.*"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "5. VERIFICANDO TABLAS - PROMOCIONES" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
docker exec -it $CONTAINER psql -U $USER -d $DB -c "\dt promociones.*"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "6. VERIFICANDO TABLAS - VENTAS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
docker exec -it $CONTAINER psql -U $USER -d $DB -c "\dt ventas.*"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "7. VERIFICANDO TABLAS - LOGISTICA" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
docker exec -it $CONTAINER psql -U $USER -d $DB -c "\dt logistica.*"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "8. VERIFICANDO TABLAS - INVENTARIO" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
docker exec -it $CONTAINER psql -U $USER -d $DB -c "\dt inventario.*"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "9. VERIFICANDO TOTAL DE TABLAS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$TOTAL_TABLAS = docker exec -it $CONTAINER psql -U $USER -d $DB -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema NOT IN ('information_schema', 'pg_catalog');"
Write-Host "📊 Total de tablas en la base de datos: $TOTAL_TABLAS" -ForegroundColor Green

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "✅ VERIFICACIÓN COMPLETADA - QA" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green