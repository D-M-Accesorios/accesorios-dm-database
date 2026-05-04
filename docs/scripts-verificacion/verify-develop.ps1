@'
# verify-develop.ps1
# Script de verificacion para ambiente DEVELOP (puerto 5432)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "VERIFICANDO BASE DE DATOS - DEVELOP" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Variables
$CONTAINER = "accesorios-dm-postgres-dev"
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
Write-Host "2. TABLAS - SECURITY" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
docker exec -it $CONTAINER psql -U $USER -d $DB -c "\dt security.*"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "3. TABLAS - CLIENTES" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
docker exec -it $CONTAINER psql -U $USER -d $DB -c "\dt clientes.*"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "4. TABLAS - CATALOGO" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
docker exec -it $CONTAINER psql -U $USER -d $DB -c "\dt catalogo.*"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "5. TABLAS - PROMOCIONES" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
docker exec -it $CONTAINER psql -U $USER -d $DB -c "\dt promociones.*"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "6. TABLAS - VENTAS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
docker exec -it $CONTAINER psql -U $USER -d $DB -c "\dt ventas.*"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "7. TABLAS - LOGISTICA" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
docker exec -it $CONTAINER psql -U $USER -d $DB -c "\dt logistica.*"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "8. TABLAS - INVENTARIO" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
docker exec -it $CONTAINER psql -U $USER -d $DB -c "\dt inventario.*"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "9. DATOS INICIALES" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "Roles:" -ForegroundColor Yellow
docker exec -it $CONTAINER psql -U $USER -d $DB -c "SELECT id_rol, nombre FROM security.rol;"

Write-Host "Estados de Pedido:" -ForegroundColor Yellow
docker exec -it $CONTAINER psql -U $USER -d $DB -c "SELECT id_estado, nombre FROM logistica.estado_pedido;"

Write-Host "Tipos de Movimiento:" -ForegroundColor Yellow
docker exec -it $CONTAINER psql -U $USER -d $DB -c "SELECT id_tipo_movimiento, nombre FROM inventario.tipo_movimiento;"

Write-Host "Materiales:" -ForegroundColor Yellow
docker exec -it $CONTAINER psql -U $USER -d $DB -c "SELECT id_material, nombre FROM catalogo.material;"

Write-Host "Categorias:" -ForegroundColor Yellow
docker exec -it $CONTAINER psql -U $USER -d $DB -c "SELECT id_categoria, nombre, estado FROM catalogo.categoria;"

Write-Host "Productos Demo:" -ForegroundColor Yellow
docker exec -it $CONTAINER psql -U $USER -d $DB -c "SELECT id_producto, nombre, precio, stock FROM catalogo.producto;"

Write-Host "Total de productos:" -ForegroundColor Yellow
docker exec -it $CONTAINER psql -U $USER -d $DB -c "SELECT COUNT(*) as total_productos FROM catalogo.producto;"

Write-Host "Clientes:" -ForegroundColor Yellow
docker exec -it $CONTAINER psql -U $USER -d $DB -c "SELECT id_cliente, nombre, correo FROM clientes.cliente;"

Write-Host "Empleados:" -ForegroundColor Yellow
docker exec -it $CONTAINER psql -U $USER -d $DB -c "SELECT id_empleado, nombre, correo FROM security.empleado;"

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "VERIFICACION COMPLETADA - DEVELOP" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
'@ | Out-File -FilePath "docs\scripts-verificacion\verify-develop.ps1" -Encoding ASCII