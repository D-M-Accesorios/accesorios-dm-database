# verify-main.ps1
# Script de verificación para ambiente MAIN (puerto 5434)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "VERIFICANDO BASE DE DATOS - MAIN (PRODUCCIÓN)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Variables
$CONTAINER = "accesorios-dm-postgres-prod"
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
Write-Host "2. VERIFICANDO TABLAS PRINCIPALES" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "📋 security.rol" -ForegroundColor Yellow
docker exec -it $CONTAINER psql -U $USER -d $DB -c "SELECT COUNT(*) FROM security.rol;"

Write-Host "📋 security.empleado" -ForegroundColor Yellow
docker exec -it $CONTAINER psql -U $USER -d $DB -c "SELECT COUNT(*) FROM security.empleado;"

Write-Host "📋 clientes.cliente" -ForegroundColor Yellow
docker exec -it $CONTAINER psql -U $USER -d $DB -c "SELECT COUNT(*) FROM clientes.cliente;"

Write-Host "📋 catalogo.producto" -ForegroundColor Yellow
docker exec -it $CONTAINER psql -U $USER -d $DB -c "SELECT COUNT(*) FROM catalogo.producto;"

Write-Host "📋 ventas.pedido" -ForegroundColor Yellow
docker exec -it $CONTAINER psql -U $USER -d $DB -c "SELECT COUNT(*) FROM ventas.pedido;"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "3. VERIFICANDO TOTAL DE TABLAS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$TOTAL_TABLAS = docker exec -it $CONTAINER psql -U $USER -d $DB -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema NOT IN ('information_schema', 'pg_catalog');"
Write-Host "📊 Total de tablas en producción: $TOTAL_TABLAS" -ForegroundColor Green

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "✅ VERIFICACIÓN COMPLETADA - MAIN" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green