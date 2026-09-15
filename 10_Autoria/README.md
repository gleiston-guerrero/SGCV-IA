# 10_Autoria — Evidencia de autoría del equipo SGCV-IA

Esta carpeta reúne los elementos A1 a A12 exigidos por la Guía de Desarrollo (Sección 6) como
evidencia de autoría. El detalle de cada elemento:

| Elemento | Contenido | Ubicación |
|---|---|---|
| A1 | Bitácora de sesiones de trabajo | `bitacora_sesiones.csv` |
| A2 | Capturas de pantalla por integrante | `capturas/` |
| A3 | **Fuentes editables de los diagramas** | *Ver nota más abajo — viven en `03_Modelado/`* |
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

Las fuentes editables de los diagramas UML y del modelado organizacional i* **no se duplican
en esta carpeta**: viven junto a los diagramas que generan, dentro de `03_Modelado/`, para
evitar tener dos copias del mismo artefacto que puedan desincronizarse.

| Conjunto de diagramas | Fuente editable | Formato |
|---|---|---|
| Casos de uso (CU00–CU10), diagramas de actividad, componentes, despliegue, clases, secuencia y estados | `03_Modelado/Diagramas_UML/*/*.drawio` | draw.io (XML editable) |
| Modelado organizacional i* (Diagrama de Contexto, Matriz Poder-Interés, iStar SD, iStar SR) | `03_Modelado/Organizacional_iStar/*.py` | Python (genera el `.svg`/`.png` por script) |

Cada carpeta de `03_Modelado/Diagramas_UML/` contiene el `.drawio` (fuente editable) junto al
`.svg`/`.png` (exportación) del mismo diagrama, de modo que el archivo editable siempre puede
localizarse a partir del diagrama publicado. El detalle de esta estructura está documentado en
`03_Modelado/README.md`.
