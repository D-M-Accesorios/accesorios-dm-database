## [HU-ENV-INICIALES_XX] Título de la Historia de Usuario

---

### Descripción

<!-- Describe brevemente qué migración o cambio de schema introduce este PR. -->

---

### HU relacionada

- **ID:** HU-ENV-INICIALES_XX
- **Repositorio del backlog:** [accesorios-dm/docs/HUs/](../accesorios-dm/docs/HUs/)

---

### Tipo de cambio

- [ ] `feat` — Nueva tabla, vista o función
- [ ] `fix` — Corrección de migración o datos
- [ ] `refactor` — Reorganización de schema sin cambio funcional
- [ ] `chore` — Configuración Liquibase / Docker
- [ ] `docs` — Documentación de BD
- [ ] `data` — Inserts / updates de datos iniciales

---

### Criterios de aceptación completados

- [ ] ...
- [ ] ...

---

### Checklist técnico — Database

- [ ] El changeset tiene `id` único y `author` correcto.
- [ ] El changeset está bajo el schema correcto (`security`, `clientes`, `catalogo`, `promociones`, `ventas`, `logistica`, `inventario`).
- [ ] No hay DDL cross-schema en el mismo changeset.
- [ ] El script de rollback existe en `05_rollbacks/` y fue probado.
- [ ] Los nuevos índices tienen nombre descriptivo (`idx_{tabla}_{columna}`).
- [ ] Los triggers actualizan únicamente las tablas de su propio schema.
- [ ] La migración fue ejecutada exitosamente con `docker-compose up` desde cero.
- [ ] El `changelog-master.yaml` referencia el nuevo archivo en el orden correcto.
- [ ] No hay datos sensibles (contraseñas, tokens) hardcodeados en inserts.

---

### Checklist de Definición de Done

- [ ] Los criterios de aceptación de la HU están cumplidos.
- [ ] El CI pasa (validate-branch-flow).
- [ ] El reviewer aprobó el PR.
- [ ] La rama `HU-*` será eliminada tras el merge.

---

### Notas al reviewer

<!-- Indicar si el changeset es destructivo, si requiere downtime, o si hay dependencias con otros servicios. -->
