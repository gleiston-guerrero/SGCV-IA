# Changelog

Formato basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/).

## [2B-cierre] - 2026-09-15

### Corregido
- 3 capturas de Mesías en `10_Autoria/capturas/` con fecha imposible
  (`2026-10-09`, posterior al corte) renombradas a la fecha real de
  captura (`2026-07-09`); eliminados los espacios en el nombre del
  archivo `..._actualizacionmailmap mailmap.png` que rompían los
  scripts de conteo.
- 9 capturas de Barrionuevo y Marcillo en `10_Autoria/capturas/`
  renombradas para eliminar espacios y guiones medios, ajustándose al
  patrón `AAAA-MM-DD_Integrante_Actividad.ext`.
- `CITATION.cff`: `repository-code` y el `origin=` del identificador
  SWHID actualizados de `ramaguas-ship-it/SGCV-IA` a
  `gleiston-guerrero/SGCV-IA` tras la transferencia de propiedad del
  repositorio.
- `README.md` (raíz): las 3 instrucciones `git clone` actualizadas al
  nuevo propietario del repositorio; corregido el conteo de
  `10_Autoria/capturas/` de 19 a 20 imágenes.

### Añadido
- `10_Autoria/grabaciones/Sesion_1.mp4` y `Sesion_2.mp4`: grabaciones
  de sesión de trabajo depositadas directamente en el repositorio
  (23,7 MB y 24,2 MB respectivamente, bajo el límite de 25 MB de
  GitHub), sustituyendo los enlaces externos previos.
- `10_Autoria/grabaciones/README.md`: tabla de inventario con fecha,
  participantes, duración, tamaño y hash SHA-256 de ambas grabaciones.
- `10_Autoria/fuentes_editables/`: 53 archivos (22 `.drawio`, 4 `.py`,
  26 `.png` exportados y 1 `README.md`) con las fuentes editables de
  los diagramas UML y del modelado organizacional i*, como evidencia
  de autoría del modelado (elemento A3).

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
