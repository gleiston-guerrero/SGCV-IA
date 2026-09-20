# Changelog

Formato basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/).

## [Examen Suspenso] - 2026-09-14

### Añadido
- Depositadas en `10_Autoria/fuentes_editables/` las fuentes editables
  (`.drawio`, `.py`) de los diagramas UML y del modelado organizacional
  i*, cada una junto a la imagen exportada que genera, como evidencia
  de autoría del modelado (§15a). *Realizado por: Marcillo Ponce.*
- Actualizado `10_Autoria/README.md` para reflejar el depósito físico
  de las fuentes editables en `fuentes_editables/`.
- `10_Autoria/grabaciones/Sesion_1.mp4` y `Sesion_2.mp4`: grabaciones
  de sesión de trabajo depositadas directamente en el repositorio
  (23,7 MB y 24,2 MB respectivamente, bajo el límite de 25 MB de
  GitHub), sustituyendo los enlaces externos previos (§15c).
- `10_Autoria/grabaciones/README.md`: tabla de inventario con fecha,
  participantes, duración, tamaño y hash SHA-256 de ambas grabaciones.
- `07_Datos/scripts/run_all.R` ampliado para ejecutar también
  `06_Experimento/scripts_analisis/run_all.R` (9 de 9 scripts ya
  implementados) y copiar sus tablas resultantes a
  `07_Datos/resultados/`, de modo que una sola orden reproduzca
  también las tablas de descriptivos, supuestos, pruebas de hipótesis
  y tamaño del efecto que antes se generaban fuera del paquete de
  datos (B1).

### Corregido
- Renombradas 3 capturas de Mesías con fecha de captura errónea
  (2026-10-09, posterior al corte) a su fecha real; eliminado el
  espacio en el nombre del archivo de actualización de `.mailmap`
  que rompía los scripts de conteo (§15b).
- Renombradas 9 capturas de Barrionuevo y Marcillo en
  `10_Autoria/capturas/` para eliminar espacios y guiones medios,
  ajustándose al patrón `AAAA-MM-DD_Integrante_Actividad.ext` (§15b).
- Unificados nombres de fuente/imagen en `10_Autoria/fuentes_editables`
  para CU03 y CU04
  (`CU03_Clinical_History.drawio` → `CU03_Medical_History.drawio`;
  `CU04_Inventory_Control.drawio` → `CU04_Control_Inventory.drawio`),
  evitando ambigüedad entre fuente e imagen exportada.
- `CITATION.cff`: `repository-code` y el `origin=` del identificador
  SWHID actualizados de `ramaguas-ship-it/SGCV-IA` a
  `gleiston-guerrero/SGCV-IA` tras la transferencia de propiedad del
  repositorio (§1).
- `README.md` (raíz): las 3 instrucciones `git clone` actualizadas al
  nuevo propietario del repositorio; corregido el conteo de
  `10_Autoria/capturas/` de 19 a 20 imágenes; reincorporada la mención
  a `verificacion_previa.pdf` en el listado de evidencia de autoría.
- `02_Evidencias/00_Restringido/Readme.md`: agregada nota aclarando
  que las 57 entradas de los manifiestos `checksums_*.sha256` listan
  archivos originales empaquetados dentro de los volúmenes `.7z`
  cifrados, no archivos sueltos en el árbol; se completó además la
  tabla de contenido con los archivos de walkthrough que faltaban
  documentar (B1).
- Reemplazados los consentimientos de entrevista P11 a P16 (antes
  documentos Word/PDF con texto editable y firma pegada) por
  escaneos/fotografías del ejemplar físico firmado, en formato imagen
  sin texto extraíble, nombrados con fecha, rol y código de
  participante (§7). *Realizado por: Marcillo Ponce.*

### Eliminado
- `10_Autoria/grabaciones/Sesiones.md`, `Sesion_1.md` y `Sesion_2.md`:
  reemplazados por los archivos de video depositados directamente y
  su nuevo `README.md` de inventario.

## [2B] - 2026-09-01

### Añadido
- Cifrado AES-256 de evidencia audiovisual identificable en
  `02_Evidencias/00_Restringido/evidencias_restringidas.7z` (audio,
  consentimientos, video de 3 entrevistados con material completo).
- Cláusula de exclusión de `00_Restringido/` en LICENSE.
- `checksums.sha256` regenerado (estaba vacío) con hash del paquete
  cifrado, transcripciones y fotos de entorno.
- `fichas_tecnicas.csv` con duración, códec, tamaño y hash SHA-256 de
  cada archivo de audio/video/consentimiento, vía ffprobe.
- ERS renombrado a la convención oficial `ERS_SRS_2B_v2.0`.
- Esqueleto documentado de `09_Defensa/`, `07_Publicacion/` y
  `06_Experimento/scripts_analisis/` (placeholders vacíos con checklist
  de contenido pendiente).
- Placeholders del paquete ético completo (`A01_Anexo.pdf` a
  `A13_Anexo.pdf`, `Aval_Institucional.pdf`, `Adenda_Segunda_Ronda.pdf`)
  con `README_Etica.md` documentando el estado.
- Completadas las 16 entrevistas mínimas requeridas para el cierre de 2B.
- Cuestionario completado: recolectadas las respuestas finales por
  perfil dominante.
- Generada la curva de saturación temática (CSV + figura).
- Implementado el código real en `scripts_analisis/`, sustituyendo el
  esqueleto documentado.
- Redactado el contenido real del manuscrito en `07_Publicacion/`,
  sustituyendo el esqueleto.
- Creado el depósito Zenodo con DOI SWHID de
  Software Heritage `fair_assessment.pdf`.
- Completado el contenido real de `08_Etica/`: Anexo B, Aval
  Institucional.
- Sesión de member checking realizada con participantes de las
  entrevistas.
- Completadas las 6 sesiones mínimas de walkthrough
  (`02_Evidencias/Validacion_Walkthrough/`).
- 1 Requisito Funcional adicional (RF-28, gestión de empleados y
  permisos), completando el catálogo a **28 RF**; 4 Requisitos No
  Funcionales adicionales (RNF-18 explicabilidad de la IA, RNF-19
  equidad, RNF-20 monitoreo posterior al despliegue, RNF-21 supervisión
  humana/revocabilidad), completando el catálogo a **21 RNF**. *Nota
  añadida 20/09/2026 (tarea D4 del plan de mejora de datos): esta
  entrada faltaba en el changelog; el ERS ya reflejaba 28 RF/21 RNF sin
  que quedara registrado aquí el salto desde los 27 RF/17 RNF de la
  entrega [2A].*

### Corregido
- 2 videos de entrevista de Edison Moncada y 8 de Jaime Ortega, más 2
  archivos sueltos, resultaron ser placeholders de 2 bytes (evidencia
  corrupta). Documentados en
  `02_Evidencias/00_Restringido/_PENDIENTE_VideoOriginal/README.md`.
- Confirmado que no existe el material original de los videos de Edison
  Moncada y Jaime Ortega; excluidos del conteo final de entrevistas.

## [2A] - 2026-07-29

### Añadido
- Sección 2 completa del ERS: diagrama de contexto, mapa de stakeholders (matriz poder/interés),
  modelado organizacional i* (SD y SR).
- Sección 3: requisitos legales (RL-01 a RL-14) mapeados a la LOPDP del Ecuador, con matriz de
  trazabilidad Ley-Artículo → RF/RNF.
- 2 nuevos Requisitos Funcionales (RF-24, RF-25), completando el catálogo a 25 RF.
- 5 nuevos Requisitos No Funcionales (RNF-11 a RNF-15), completando el catálogo a 15 RNF.
- 2 Requisitos Funcionales adicionales (RF-26, RF-27) y 2 Requisitos No Funcionales adicionales
  (RNF-16, RNF-17), derivados del análisis de cumplimiento legal (criterio C4).
- Carpeta `03_Modelado/Organizacional_iStar/` con diagramas fuente (SVG) y exportaciones (PNG 300dpi).

### Pendiente
- Modelado UML completo (Sección 4), priorización MoSCoW+Kano+WSJF (Sección 5), MVP (Sección 6).

## [1B] - 2026-06-30

### Añadido
- Primera versión del ERS/SRS parcial: introducción, descripción general preliminar, RF/RNF iniciales.
