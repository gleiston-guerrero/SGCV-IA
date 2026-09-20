# MVP — SGCV-IA (Sistema de Gestión Clínica Veterinaria con IA)

## Descripción

Prototipo funcional del MVP de **SGCV-IA**, orientado a demostrar los módulos Must have del ERS/SRS: autenticación por rol, gestión de pacientes, historial clínico, agenda de citas, inventario, facturación, sugerencias diagnósticas por IA (con flujo Aceptar/Modificar/Rechazar), reportes y configuración.

---

## Tecnologías

* **Frontend**: HTML5 + CSS3 + JavaScript (React), empaquetado en un único archivo (`SGCV-IA_Prototipo_Funcional.html`).
* **Backend**: Node.js + Express + SQLite (`backend/`), incluido en el repositorio pero **no integrado con el frontend en esta versión del prototipo**. El frontend opera de forma autónoma: el inicio de sesión se valida en el propio navegador contra credenciales fijas embebidas en el HTML, y el estado de la aplicación se guarda en el almacenamiento del navegador, no en la base de datos SQLite. La persistencia server-side queda declarada como trabajo pendiente para la siguiente iteración.

---

## Estructura

```text
05_MVP/
├── SGCV-IA_Prototipo_Funcional.html   # Frontend (single-file, autónomo)
├── backend/
│   ├── server.js                       # API REST (no consumida por el frontend en esta versión)
│   ├── package.json
│   └── data/                            # Base de datos SQLite (no integrada al frontend)
├── Dockerfile                          # Imagen Node que sirve el backend de forma independiente
├── docker-compose.yml                  # Despliegue del backend con un solo comando
└── README.md
```

---

## Ejecución

### Opción 1 — Frontend directo (uso real del prototipo)

Abrir `SGCV-IA_Prototipo_Funcional.html` directamente en el navegador (doble clic). Usar las credenciales de demostración fijas indicadas más abajo.

### Opción 2 — Backend por separado (en desarrollo, no conectado al frontend)

```bash
cd 05_MVP
docker compose up
```

Expone la API en **http://localhost:8080**, pero el frontend del prototipo no la consume todavía.

---

## Sugerencias diagnósticas por IA

En esta versión del MVP, las sugerencias diagnósticas (RF-17/RF-18/RF-19) muestran **valores fijos de ejemplo (68 % / 19 % / 13 %)** para ilustrar el flujo Aceptar/Modificar/Rechazar. No hay un modelo de IA real conectado ni cálculo dinámico de porcentajes.

---

## Cobertura de RF (Must have) demostrada

| RF | Módulo | Estado |
|---|---|---|
| RF-24 | Login / autenticación por rol | ✅ (validación en frontend, credenciales fijas) |
| RF-22 | Navegación diferenciada por rol (Veterinario / Administrativo) | ✅ |
| RF-02, RF-03 | Búsqueda y ficha centralizada de paciente | ✅ |
| RF-04 | Registro de consulta | ✅ |
| RF-05, RF-06 | Alertas e inventario | ✅ |
| RF-07, RF-08 | Cobro y facturación | ✅ |
| RF-11 | Agenda de citas | ✅ |
| RF-17, RF-18, RF-19 | Sugerencias diagnósticas por IA (Aceptar/Modificar/Rechazar, valores fijos de ejemplo) | ✅ |
| RF-25 | Reportes | ✅ (Could have, ya cubierto) |
| RF-23 | Log de auditoría | ✅ Verificado en el código — pantalla "Log de Auditoría", registro automático de cada acción (usuario, módulo, fecha, detalle), de solo lectura |
| RF-21 | Modo offline | ⚠️ No aplica a este prototipo web (alcance definido para escritorio) |

> Credenciales de demostración: documentar aquí las credenciales de prueba usadas en el video/defensa (nunca credenciales reales de la clínica cliente), conforme a la Sección 8.4 de la Guía de la Entrega 4.

---

## Limitaciones (alcance MVP)

* El frontend no está integrado con el backend: la autenticación se valida en el navegador y el estado no persiste en SQLite. Es una limitación declarada del alcance de esta entrega, no una capacidad demostrada.
* Las sugerencias diagnósticas por IA son valores fijos de ejemplo (68/19/13 %), no un modelo real.
* RNF-18 (explicabilidad de la IA: factores + indicador de confianza): ver estado actual en `04_Trazabilidad/matriz_trazabilidad.csv` — implementado en el MVP solo si consta ahí como tal; de lo contrario, se declara como no implementado.
* Para la defensa (Sección 8.4 de la guía) se debe preparar un video corto que cubra específicamente los 2 escenarios de la matriz de trazabilidad, y depositarlo en `09_Defensa/video_defensa.mp4`.

---

## Equipo de desarrollo

* Barrionuevo Fuentes Carlos Daniel
* Vera Gómez Anthony Alfredo
* Mesias Quijije Jhon Alexander
* Amagua Sacon Robyn William
* Marcillo Ponce Jeanpool Alberto
