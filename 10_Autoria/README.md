# 10_Autoria — Evidencia de autoría del equipo SGCV-IA

Esta carpeta reúne los elementos A1 a A12 exigidos por la Guía de Desarrollo (Sección 6) como
evidencia de autoría. El detalle de cada elemento:

| Elemento | Contenido | Ubicación |
|---|---|---|
| A1 | Bitácora de sesiones de trabajo | `bitacora_sesiones.csv` |
| A2 | Capturas de pantalla por integrante | `capturas/` |
| A3 | **Fuentes editables de los diagramas** | `fuentes_editables/` |
| A4 | Grabaciones de sesión de trabajo | `grabaciones/` (`Sesion_1.mp4`, `Sesion_2.mp4` — depositadas directamente, ambas bajo el límite de 25 MB de GitHub) |
| A5 | Notas de campo | `notas_campo/` |
| A6 | Fotos del equipo en la organización | `fotos_equipo/` |
| A7 | Doble codificación | `doble_codificacion/` |
| A8 | Correspondencia con la organización | `correspondencia/` |
| A9 | Declaración de uso de IA por sección | `declaracion_uso_ia.md` |
| A10 | Aporte individual firmado | `aporte_individual.md` |
| A11 | Inventario EXIF | `exif_inventario.csv` |
| A12 | `.mailmap` | raíz del repositorio (`/.mailmap`) |

## Nota sobre A3 — Fuentes editables de los diagramas

Las fuentes editables de los diagramas UML y del modelado organizacional i* están depositadas
en `fuentes_editables/`, cada una junto a la imagen exportada (png) que genera, como evidencia
directa de autoría del modelado.

| Conjunto de diagramas | Fuente editable | Formato |
|---|---|---|
| Casos de uso (CU00–CU10), diagramas de actividad, componentes, despliegue, clases, secuencia y estados | `fuentes_editables/*.drawio` | draw.io (XML editable) |
| Modelado organizacional i* (Diagrama de Contexto, Matriz Poder-Interés, iStar SD, iStar SR) | `fuentes_editables/*.py` | Python (genera el `.svg`/`.png` por script) |

Cada archivo fuente en `fuentes_editables/` está acompañado de la imagen exportada
correspondiente (`.svg`/`.png`) del mismo diagrama. El detalle completo se encuentra en
`fuentes_editables/README.md`.

## Nota sobre A11 — Inventario EXIF

Las 13 filas de `exif_inventario.csv` correspondientes a
`02_Evidencias/Cuestionario/Fotos_Aplicacion/` están marcadas como `SIN_EXIF` en las columnas
de fecha de captura y dispositivo. Esto declara, sin ambigüedad, que **no existe evidencia
fotográfica de la aplicación del cuestionario**: las 13 imágenes de esa carpeta son capturas de
pantalla de los resúmenes del formulario (Google Forms), no fotografías tomadas con la cámara
de un dispositivo, y por diseño ningún sistema operativo escribe metadatos EXIF de cámara
(`DateTimeOriginal`, `Model`) en una captura de pantalla — no es un dato que se haya perdido,
sino uno que nunca existió para este tipo de archivo. El detalle completo de por qué una captura
de pantalla no lleva EXIF de cámara está en
`02_Evidencias/Cuestionario/Fotos_Aplicacion/README.md`.
