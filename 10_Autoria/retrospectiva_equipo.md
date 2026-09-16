# Retrospectiva del equipo — SGCV-IA

Equipo ABMMV — Entrega 4 (2B), examen suspenso. Fecha: 15/09/2026, posterior a la última
corrección de este cierre (commit `4eeab52`, etiqueta de línea base `v2B-cierre`).

## 1. Qué hicimos y en qué orden

Seguimos el orden que fijó la propia guía de cierre: primero las fechas imposibles de las
capturas, luego las fuentes editables, luego el inventario de grabaciones, luego la
identificación del repositorio, y al final la etiqueta de cierre.

1. **Capturas (§15b).** Renombramos las 3 capturas de Mesías fechadas `2026-10-09`
   (posterior al corte) a su fecha real, y de paso corregimos la nomenclatura (espacios y
   guiones) de otras 9 capturas de Barrionuevo y Marcillo.
2. **Fuentes editables (§15a).** Depositamos en `10_Autoria/fuentes_editables/` los 53
   archivos (`.drawio`, `.py`) que antes solo vivían dispersos en `03_Modelado/`.
3. **Grabaciones (§15c).** Reemplazamos el enlace externo por los dos videos comprimidos
   depositados directamente, con un `README.md` nuevo con fecha, duración, tamaño y SHA-256.
4. **Identificación y URL (§1).** Corregimos la URL del repositorio (`ramaguas-ship-it` →
   `gleiston-guerrero`) en `README.md`, `CITATION.cff`, y en los tres materiales de
   `11_Defensa/` (guion, presentación, folleto), que además tenían datos desactualizados
   (n=30 en vez de n=210, rutas a carpetas que ya no existen) y se aprovechó para
   corregirlos también.
5. **Manifiestos y paquete de datos (B1).** Documentamos por qué 57 entradas de los
   manifiestos cifrados no resuelven contra el árbol de git (están empaquetadas en `.7z`,
   no ausentes), y verificamos que `07_Datos/scripts/run_all.R` ya integra el pipeline de
   `06_Experimento/scripts_analisis/` para que una sola orden reproduzca también las tablas
   de hipótesis y tamaño del efecto.
6. **Etiqueta de cierre (§3).** Creamos `v2B-cierre` sobre el commit final.
7. **Consentimientos (§7).** Reemplazamos los consentimientos de entrevista P11 a P16
   (documentos Word/PDF con texto editable y firma pegada) por escaneos/fotografías del
   ejemplar físico firmado, en formato imagen sin texto extraíble, nombrados con fecha,
   rol y código de participante.

## 2. Quién hizo qué

- **Mesías Quijije** ejecutó la mayor parte de las correcciones técnicas de este cierre:
  git/GitHub (capturas, grabaciones, tag `v2B-cierre`) y la corrección de `11_Defensa/`.
- **Marcillo Ponce** depositó las fuentes editables en `10_Autoria/fuentes_editables/`
  (punto 2), reemplazó los consentimientos P11 a P16 (punto 7), actualizó las entradas
  correspondientes del `CHANGELOG.md`, y junto con Barrionuevo Fuentes es autor de las
  capturas y nombres de archivo corregidos en el punto 1.
- **Barrionuevo Fuentes** construyó el pipeline de `06_Experimento/scripts_analisis/` y de
  `07_Datos/` que resuelve el punto 5.
- El detalle línea por línea de quién hizo cada artefacto, con hashes de commit, está en
  `10_Autoria/aporte_individual.md`; este documento no lo repite.

## 3. Qué corregimos y qué aprendimos

- **Aprendimos que crear un tag desde la interfaz web de GitHub no lo deja anotado** —
  queda ligero aunque se vea igual. Hubo que corregirlo por terminal con
  `git tag -a -f` y volver a subirlo.
- **Aprendimos a no confiar en un commit "vacío" como evidencia propia.** La revisión
  cruzada de `aporte_individual.md` encontró 6 commits sin cambios de archivo, citados
  como trabajo de Marcillo Ponce cuando en realidad correspondían a subidas reales de
  Amagua Sacón hechas minutos antes. Quedó documentado y corregido en ese archivo.
- **Aprendimos que compartir terminal sin revisar `git config` mezcla identidades.**
  Varios commits de Barrionuevo Fuentes quedaron firmados como Mesías Quijije por usar la
  misma máquina sin cambiar la identidad local; se corrigió el `git config` y se dejó la
  aclaración por escrito en vez de reescribir el historial.
- **Corregimos la costumbre de dar por completado algo sin verificarlo contra el
  repositorio real** — varios documentos (guion de defensa, presentación, folleto)
  describían un estado del proyecto muy anterior (n=30, scripts como esqueleto, sin
  grabaciones) que ya no era cierto, y nadie los había actualizado al ritmo del resto del
  proyecto. La lección para el resto del curso: cada vez que se cierra un punto de la
  guía, revisar también los materiales de defensa y difusión que citan ese mismo dato.
