# A10 — Aporte individual por integrante

Proyecto SGCV-IA — Entrega 4 (2B). Documento de cumplimiento obligatorio conforme a la Guía de Desarrollo (Sección 6, ítem A10). Debe estar firmado por los cinco integrantes; cada quien completa y valida su propia sección.

---

## Alberto Jeanpool Marcillo Ponce (Analista Líder)

### Responsabilidad asignada en el reparto de trabajo

Analista Líder — codificación temática y saturación (C5/C6), verificación de la matriz de trazabilidad (C2), depósito Zenodo curado, evaluación F-UJI, defensa final.

### Artefactos de los que es responsable

| Artefacto | Ruta | Descripción del aporte |
|---|---|---|
| Codificación temática abierta (P09–P16) | `02_Evidencias/Codificacion_Tematica/codificacion_tematica_SGCV-IA.csv` | Codificación de las 8 entrevistas restantes (89 códigos abiertos nuevos), completando el corpus de 16 entrevistas a 167 códigos abiertos totales. |
| Codificación axial (167 → 50 códigos) | `02_Evidencias/Codificacion_Tematica/codificacion_axial_SGCV-IA.csv` y `.md` | Consolidación de los 167 códigos abiertos en códigos axiales agrupados en 7 categorías. Primera consolidación: 47 códigos. Tras reclasificar los 167 códigos uno por uno contra las categorías finales, se corrigió a 50 códigos axiales (errores de conteo detectados en Inteligencia Artificial, Usabilidad y desempeño, Historia clínica y Seguridad); corrección propagada a los 13 archivos del repositorio que citaban el número anterior. |
| Curva de saturación (nivel abierto y axial) | `02_Evidencias/Codificacion_Tematica/`, `09_Publicacion/figuras/curva_saturacion_axial.pdf` | Distinción metodológica entre saturación a nivel de código abierto (no se cumple) y a nivel de código cerrado/axial (sí se cumple, Hennink et al. 2017); cálculo y figura de ambas curvas por script; recálculo completo tras la corrección de 47 a 50 códigos (saturación final: 2.67% en las últimas 3 entrevistas, bajo el umbral del 5%). |
| Auditoría de la matriz de trazabilidad | `04_Trazabilidad/matriz_trazabilidad.csv` | Identificación de filas con campos de trazabilidad incompletos (EV, HU, CA); verificación posterior de las correcciones y aclaraciones aplicadas por Amagua Sacón hasta el cierre completo de las 63 filas, incluyendo la verificación del criterio real de la columna EV contra las Secciones 8.1 y 9.2 del ERS. |
| Manuscrito final | `09_Publicacion/manuscrito_final.tex` | Corrección de una versión anterior que contenía códigos y frecuencias fabricados (E1–E9, D5, D6, G1–G3) y una afirmación de saturación no sostenida por los datos; reescritura de Resumen, Trabajo Relacionado (protocolo de búsqueda real, ejecutado y documentado, con tabla de 19 estudios verificados), Metodología (Propositions, desviaciones del protocolo OSF), Resultados, Discusión, Conclusiones, autoría (ORCID), disponibilidad de datos y uso de IA. Corrección posterior de la frecuencia de IA-3 (6/16 → 4/16) y del total de estudios en Trabajo Relacionado (18 → 19) tras verificación adicional. Actualización del DOI de Zenodo tras el depósito curado. |
| `title_page.tex` | `09_Publicacion/title_page.tex` | Corrección de ORCID de los 6 autores, typo en el correo de correspondencia, inserción del resumen final, declaración de financiamiento (ninguno) y conflictos de interés (ninguno declarado), aclaración sobre ausencia de número de aprobación ética individual (política uniforme del curso), corrección de la sección de uso de IA, actualización del DOI de Zenodo. |
| Tablas de resultados | `09_Publicacion/tablas/tabla1_trabajo_relacionado.csv`, `tabla2_codigos_ia_frecuencias.csv` | Extracción y verificación independiente de las tablas del manuscrito como archivos CSV reproducibles, para cumplir la regla de que ninguna cifra publicada se escriba a mano. |
| Bibliografía | `09_Publicacion/referencias.bib` | Verificación de las entradas existentes contra las citas del manuscrito; incorporación de 4 entradas nuevas (Köhl et al. 2019, Habiba et al. 2022, Obaidi et al. 2025, Xiao et al. 2026) con verificación de DOI/identificador arXiv antes de citarlas; ampliación de citas efectivas en el texto de 30 a 43 de 45 entradas. |
| Metadatos de citación | `CITATION.cff` | Corrección de versión, fecha, ORCID de los 6 autores; actualización del campo `doi` tras la creación del depósito Zenodo curado. |
| Documentación del paquete de datos | `09_Publicacion/dataset_zenodo/README_dataset.md`, `ANONYMIZATION.md`, `ETHICS.md` | Redacción completa a partir de los procedimientos reales ya aplicados por el equipo (esquema de seudonimización P01–P16, proceso de consentimiento del `Guion_Entrevista_v2_0`). |
| Depósito Zenodo curado | Registro Zenodo `10.5281/zenodo.22558095` | Definición de metadatos del depósito curado en CC BY 4.0 (título, tipo de recurso, los 6 autores con ORCID, licencia, versión 2.0, palabras clave, identificadores relacionados con el registro OSF, enlace al repositorio), reemplazando el depósito automático previo en MIT. |
| Evaluación FAIR | `fair_assessment.pdf` (raíz del repositorio) | Ejecución de la autoevaluación F-UJI contra el DOI del depósito curado; puntaje agregado 96.15% (25/26), muy por encima del mínimo del 60% exigido. |
| Declaración de uso de IA | `10_Autoria/declaracion_uso_ia.md` | Redacción de la declaración A9, sección por sección del manuscrito y de los artefactos de codificación; corrección de una versión de `manuscrito_final.tex`/`title_page.tex` que minimizaba incorrectamente el alcance real del uso de IA (atribuido erróneamente a otra herramienta), restaurando la declaración honesta y consistente con este documento. |
| `desviaciones.md` | `07_Datos/desviaciones.md` | Registro formal de la desviación real del protocolo OSF (componente de validación cuantitativa del Enfoque 3, Rondas 1 y 2, diseñado pero no ejecutado), con fecha, motivo y confirmación escrita de Vera Gómez. |
| Criterios de piso propios | Raíz del repositorio, `.git` | Eliminación de archivo de evidencia vacío (P3); verificación de etiqueta anotada `v2B` (P5); confirmación de `git config` con correo institucional propio en todos los commits (P4). |
| Doble codificación independiente (A7) | `10_Autoria/doble_codificacion/` | Cálculo del coeficiente kappa de Cohen entre la codificación propia y la de Mesías Quijije sobre P02, P07, P13, P16 (25% del corpus), por script reproducible; redacción de la interpretación, incluida la explicación de la paradoja del kappa (acuerdo bruto 89,3% vs. kappa 0,36) y el reconocimiento de la limitación del intervalo de confianza amplio por tamaño de muestra. |

### Identificadores de commit

Extraídos de `git log --author="amarcillop@uteq.edu.ec" --oneline` sobre el repositorio real.

| Artefacto | Commit(s) |
|---|---|
| Codificación temática abierta (P09–P16) | `47431e7` (subida), `977505c` (corrección de codificación de caracteres) |
| Codificación axial (167 → 50 códigos), `.csv` | `1e9db9b` (codificación temática cerrada en CSV) |
| Codificación axial, `.md` | `6d0caf8` |
| Corrección del recuento axial (47→50) | `0b281f8` (manuscrito y artefactos principales), `b436a40` (corrección espejo en `dataset_zenodo/`) |
| Limpieza de archivo duplicado obsoleto | `af1fe6f` (elimina `codificacion_tematica_SGCV-IA.md` duplicado en `02_Evidencias/Codificacion_Tematica/`, superado por el `.csv`) |
| Curva de saturación axial | `b2c6fde`, `6e64422` (versiones), `4b43b5e` (versión final corregida), `5153210`/`421e15b` (limpieza de versiones obsoletas) |
| Curva de saturación abierta (script, salida, figura) | `e7b93f6` (script R), `b06db6d` (tabla), `00d9197` (figura) |
| Matriz de trazabilidad (auditoría y cierre) | `3f13b96` (versión intermedia), `6f50448` (versión final cerrada) |
| Manuscrito final (versión inicial y correcciones) | `bfa16fd` (creación), `edf641d`/`dbcef9a`/`dceb210` (revisiones), `40d9f19` (DOI de Zenodo) |
| `title_page.tex` | `e446b5a`/`c1468cd` (revisiones), `72e894d` (DOI de Zenodo), `2a04550` (PDF) |
| Tabla 1 (Trabajo Relacionado) | `a4fa2d7` |
| Tabla 2 (frecuencias IA) | `774c64b` (versión inicial), `adfebb1` (corrección IA-3) |
| `referencias.bib` | `d03a5de` |
| `CITATION.cff` | `0e5708e` (actualización general), `157e06a` (DOI de Zenodo) |
| `README_dataset.md` | `38efb8a` (creación), `d229d22`/`60cfc94`/`6ea7a75` (revisiones) |
| `ANONYMIZATION.md` | `b7faf0a` (creación), `d442af6` (revisión) |
| `ETHICS.md` | `66efc60` (creación), `aea2801` (revisión) |
| Evaluación F-UJI (`fair_assessment.pdf`) | `6773258` |
| Declaración de uso de IA (A9) | `3e88348` |
| `desviaciones.md` | `90ad44d` |
| Doble codificación independiente (A7) | `61764b7`/`cb07b6d` (hoja propia), `374a5b2` (hoja de Mesías), `bbe0054` (script), `c918dab` (resultado), `b5ffe1c` (interpretación) |
| Eliminación de archivo de evidencia vacío (criterio de piso P3) | `805af02` (Delete 07_Publicacion/Provisionar) |
| `aporte_individual.md` (este documento) | `20801de`, `9409e12`, `a05a7c7` |

**Nota:** varios artefactos muestran más de un commit porque se subieron, corrigieron y volvieron a subir a lo largo del proceso (por ejemplo, la corrección del recuento axial de 47 a 50 obligó a resubir varios archivos). Se listan todos para trazabilidad completa, no solo el último.

### Firma

Alberto Jeanpool Marcillo Ponce — Fecha: 07-09-2026

---

## Robyn Willian Amagua Sacón (Responsable C7 — Recolección de datos de campo / Integrador del repositorio)

## Responsabilidad asignada en el reparto de trabajo

Responsable de C7 (Recolección de datos de campo), según `06_Experimento/README.md`. En la práctica, el historial de commits muestra que además actuó como integrador/mantenedor del repositorio: estructura de carpetas, unificación de identidades de commit, evidencia restringida, corrección de inconsistencias transversales y cierre de la Entrega 4.

### Artefactos de los que es responsable

| Artefacto | Ruta | Descripción del aporte |
|---|---|---|
| Estructura del repositorio (`07_Datos`, `10_Autoria`) | Raíz del repositorio | Creación de las carpetas `07_Datos/` y `10_Autoria/`, renumeración de `Publicacion/`→`09_Publicacion/` y `Defensa/`→`11_Defensa/`, y reorganización de las 16 transcripciones y la encuesta cruda hacia `07_Datos/datos_crudos/`. Población de plantillas iniciales de `07_Datos` y `10_Autoria`. |
| `.mailmap` (unificación de identidades) | `.mailmap` | Creación y ampliación del archivo que unifica los distintos usuarios/correos de GitHub de cada integrante bajo un nombre canónico. |
| Evidencia restringida cifrada (consentimientos y audios P01–P16) | `02_Evidencias/00_Restringido/` | Empaquetado y subida de los consentimientos y audios de las 16 entrevistas, cifrados, con sus checksums SHA-256. |
| Anonimización de evidencia | `02_Evidencias/fichas_tecnicas.csv`, `checksums_originales.txt` | Eliminación de filas duplicadas con nombres reales de participantes; sustitución de nombres reales por códigos de participante (P01–P16). |
| Corrección de priorización MoSCoW/Kano | `04_Trazabilidad/priorizacion_moscow_kano_valor.csv` | Corrigió el intercambio de valores entre RF-09 y RF-18, que estaban invertidos. |
| Actualización real del DOI de Zenodo | `09_Publicacion/manuscrito_final.tex`, `title_page.tex`, `CITATION.cff` | Reemplazó el DOI del depósito automático por el DOI del paquete curado en CC BY 4.0, y eliminó el comentario `PENDIENTE` en `CITATION.cff`. |
| Evaluación FAIR (`fair_assessment.pdf`) | `fair_assessment.pdf` (raíz) | Subida del reporte F-UJI (96.15%, 25/26); corrección posterior de una corrupción de bytes CR por `autocrlf` de Windows y normalización de saltos de línea (LF) vía `.gitattributes`. |
| Presentación final de defensa | `11_Defensa/presentacion.pdf`, `presentacion.pptx`, `guion.md` | Subida de las diapositivas (PDF y PPTX) y el guion de la defensa final. |
| Actualización del ERS | `01_ERS/ERS_SRS_2B_v2.0.tex`/`.pdf` | Actualización del ERS/SRS para la Entrega 4 (2B); regeneración del PDF desde Overleaf; nueva imagen de portada. |
| Aclaración de roles y del identificador OSF | `06_Experimento/README.md` | Dejó explícita la tabla de roles del equipo; unificó dos identificadores de OSF distintos (`r5p8d`/`wkg32`) que convivían en el repositorio. |
| Licenciamiento | `LICENSE`, `07_Datos/LICENSE-DATA.txt` | Revisión y ampliación de los términos de licenciamiento y de la sección del paquete de datos. |
| Checksums reproducibles de la raíz | `checksums.sha256`, `scripts/generar_checksums_raiz.sh` | Regeneración de `checksums.sha256` con cobertura completa y script para reproducir el cálculo. |
| Limpieza de archivos obsoletos/duplicados | Varias rutas | Eliminación de un archivo de evidencia vacío (`Provisionar`), de un `checksums_originales.txt` obsoleto y de la carpeta `09_Defensa/` antigua duplicada. |
| **Fotos de entornos veterinarios (reemplazo)** *(nuevo)* | `02_Evidencias/Fotos_Entorno/` | Reemplazó las fotos de entorno por los originales de cámara (EXIF real conservado, caras cubiertas por privacidad) y actualizó `exif_inventario.csv`. |
| **Correspondencia de coordinación** *(nuevo)* | `10_Autoria/correspondencia/` | Subida de 6 capturas de WhatsApp que documentan la coordinación con el personal veterinario. |
| **Fotos del equipo** *(nuevo)* | `10_Autoria/fotos_equipo/` | Subida de fotos del equipo (presenciales y de reunión virtual); eliminó un placeholder vacío dejado en la carpeta. |
| **Capturas de evidencia de aporte individual** *(nuevo)* | `10_Autoria/capturas/` | Subida de capturas propias de codificación, ERS y flujo de commits como evidencia de su trabajo en `aporte_individual.md`. |
| **READMEs nuevos** *(nuevo)* | `03_Modelado/README.md`, `04_Trazabilidad/README.md`, `10_Autoria/README.md` | Creó los README de `03_Modelado` y `04_Trazabilidad`; en `10_Autoria` agregó referencia cruzada a las fuentes editables de diagramas (A3). |
| **Ampliación del ERS (RNF-19/RNF-20)** *(nuevo)* | `01_ERS/ERS_SRS_2B_v2.0.tex` | Recompiló el ERS agregando HU-28/HU-29 y CA-28/CA-29 (equidad y monitoreo) en Sección 5, 5.4 y Apéndice D. |
| **Actualización de la matriz de trazabilidad** *(nuevo)* | `04_Trazabilidad/matriz_trazabilidad.csv` | Actualización del CSV junto con normalización de saltos de línea. |
| **Mantenimiento documental de cierre** *(nuevo)* | `10_Autoria/aporte_individual.md`, `README.md` (raíz), `declaracion_uso_ia.md`, `CHANGELOG.md` | 7 ediciones de `aporte_individual.md`, 5 de `README.md` (estructura, DOI, enlaces OSF), 4 de `declaracion_uso_ia.md`, 3 de `CHANGELOG.md` (confirmación de las 6 sesiones de walkthrough). |

### Identificadores de commit

| Artefacto | Commit(s) |
|---|---|
| Estructura del repositorio y reorganización de datos | `563b0fa`, `d1b4780` |
| `.mailmap` | `5be985c`, `3bfff36`, `3ffd8d4` |
| Evidencia restringida (consentimientos, audios) | `156f4b4`, `076708c` |
| Anonimización de evidencia | `d878fd7`, `a34e338` |
| Corrección RF-09/RF-18 | `009009c` |
| DOI de Zenodo (manuscrito / title_page / CITATION.cff) | `5c7b5da`, `4927b8d`, `aa64266` |
| `fair_assessment.pdf` | `d11b997`, `88b1a90`, `d44def8` |
| Presentación final | `94a9ea8`, `67c43c0`, `065c139` |
| ERS actualizado | `34c612c`, `f9a6dcf`, `bb65ae5`, `1c1a137` |
| README — roles e identificador OSF | `fabd443`, `fc28229` |
| Licenciamiento | `0410148`, `29d48d5` |
| Checksums de la raíz | `d5118ad`, `d9694c6` |
| Limpieza de evidencia obsoleta/duplicada | `05f45b3`, `20be7a8`, `ab852f8`, `188f0d9`, `4c7420d`, `0bd4800` |
| **Fotos de entornos veterinarios** *(nuevo)* | `3b60a67` |
| **Correspondencia de coordinación** *(nuevo)* | `29630cb` |
| **Fotos del equipo** *(nuevo)* | `f94bd5f`, `4fbee7b`/`58910c5` |
| **Capturas de evidencia** *(nuevo)* | `6a8d285`, `d816b3b`, `6206b90` |
| **READMEs nuevos** *(nuevo)* | `dcd3ceb`, `0a16a4c`, `b4ae02d` |
| **Ampliación del ERS** *(nuevo)* | `62a2973` |
| **Matriz de trazabilidad** *(nuevo)* | `8286772` |
| **`aporte_individual.md`** *(nuevo)* | `6bcfa33`, `1166dc2`, `44ca388`, `e9979dc`, `dee66ab`, `062e221`, `b2527fd` |
| **`README.md` raíz** *(nuevo)* | `b8e8827`, `d35f36b`, `3c3541e`, `4161319`, `c8e6089` |
| **`declaracion_uso_ia.md`** *(nuevo)* | `9978041`, `c76e2a2`, `c081147`, `8d55c14` |
| **`CHANGELOG.md`** *(nuevo)* | `c3e49ba`, `6f0334f`, `6bba567` |


### Firma

Robyn Willian Amagua Sacón — Fecha: 12/09/2026

---

---

## Jhon Alexander Mesías Quijije (Verificador)

### Responsabilidad asignada en el reparto de trabajo

Según `06_Experimento/README.md`: **Verificador**. El historial de commits muestra el paquete de ética del proyecto (`08_Etica`), la bibliografía del ERS, su rol como segundo codificador (A7), y — en el periodo más reciente — la gestión de evidencia de walkthrough, member checking y modelado organizacional i*.

### Artefactos de los que es responsable

| Artefacto | Ruta | Descripción del aporte |
|---|---|---|
| Doble codificación independiente (A7) | `10_Autoria/doble_codificacion/hoja_codificador2_Mesias.csv` | Codificación independiente de 4 entrevistas (P02, P07, P13, P16 — 25% del corpus), para el cálculo del coeficiente de acuerdo entre codificadores (kappa de Cohen = 0,36). |
| Paquete de ética del proyecto | `08_Etica/A01_Anexo.pdf` … `A13_Anexo.pdf`, `Aval_Institucional.pdf`, `Categoria_B/*` | Subida y actualización (dos rondas, 28 y 31 de agosto) de los 13 anexos éticos, el aval institucional y los formularios de protección de datos/menores de la Categoría B. |
| Bibliografía del ERS | `01_ERS/referencias.bib` | Creación completa del archivo (444 líneas, 40 referencias verificadas manualmente contra Crossref/PubMed/arXiv o editorial). |
| Metadatos de citación — primer DOI real | `CITATION.cff` | Reemplazó el marcador `PENDIENTE` del campo `doi` por el primer DOI real de Zenodo y agregó el identificador Software Heritage (SWHID). |
| Evidencia cifrada de las grabaciones de walkthrough (inicial) | `02_Evidencias/00_Restringido/evidencias_walkthrough.7z.001`–`.004` | Empaquetado y subida (8 de septiembre) de las grabaciones cifradas de walkthrough (~280 MB en 4 partes) con sus checksums SHA-256. |
| Diagramas UML — versión inicial (superada) | `03_Modelado/Diagramas_UML/` | Primera versión de varios diagramas UML, posteriormente rehecha por Vera Gómez; ya no está en el repositorio (reemplazada, no eliminada sin registro). |
| **Actas de validación Walkthrough (W01–W06)** *(nuevo)* | `02_Evidencias/Validacion_Walkthrough/` | Subida de las 6 actas de walkthrough, con corrección posterior del acta W06. |
| **Evidencia cifrada de walkthrough (videos)** *(nuevo)* | `02_Evidencias/00_Restringido/` | Empaquetado y subida de las grabaciones cifradas en video de las 6 sesiones (W01–W06) y corrección de nombre de un checksum duplicado. |
| **Member Checking (acta y consentimientos)** *(nuevo)* | `02_Evidencias/Member_Checking/` | Subida del acta de member checking (P03, P09, P15) y sus 3 consentimientos informados; corrigió nombres de archivo duplicados. |
| **Diagramas organizacionales i\*** *(nuevo)* | `03_Modelado/Organizacional_iStar/` | Subida de 4 scripts: `Diagrama_Contexto.py`, `Matriz_Poder_Interes.py`, `iStar_SD.py`, `iStar_SR.py`. |
| **Revisión de la doble codificación (A7)** *(nuevo)* | `10_Autoria/doble_codificacion/` | Recreó la carpeta y revisó `calcular_kappa.py`, `resultado_kappa.csv` y `resultado_doble_codificacion.md` (eliminó entradas duplicadas) sobre la versión inicial de Marcillo Ponce. |
| **Notas de campo (reorganización)** *(nuevo)* | `10_Autoria/notas_campo/` | Reorganizó y renombró las 16 notas de campo (P01–P16) en varias rondas hasta una estructura consistente; actualizó el README de la carpeta. |
| **Verificación previa** *(nuevo)* | `10_Autoria/verificacion_previa.pdf` | Subida del documento de verificación previa. |
| **Resincronización del pipeline de `07_Datos`** *(nuevo)* | `07_Datos/registro_deposito.md`, `checksums_datos.sha256`, `README_datos.md` | Regeneró checksums y registro de depósito con los datos actuales; resincronizó el pipeline con los datos definitivos (n=210) y eliminó un resultado duplicado. |
| **Mantenimiento documental** *(nuevo)* | `10_Autoria/aporte_individual.md`, `.mailmap` | 4 revisiones de `aporte_individual.md`; actualizaciones al `.mailmap` en paralelo al trabajo de Amagua Sacón. |

### Identificadores de commit

| Artefacto | Commit(s) |
|---|---|
| Doble codificación — hoja propia (A7) | `374a5b2` |
| Paquete de ética (1ª ronda, 28 ago) | `f21b690`…`14c4f10`, `0bdf258`/`93e056e`, `69fcf04`, `b436ac8`/`f25a10e`/`fce6a6d`, `c63d055` |
| Paquete de ética (2ª ronda, 31 ago) | `c9d30a4`…`c818841`, `48769b0`/`464a0ef`, `684491a`, `2af95a0`/`53f150c`/`37e0601`, `e0be44e`/`f34556b` |
| `referencias.bib` (ERS) | `e0336cd` |
| `CITATION.cff` — primer DOI real | `ab8b84b`, `ee56436` |
| Evidencia cifrada de walkthrough (inicial) | `ffa3832` |
| Diagramas UML — versión inicial (superada) | `310c79d`, `0153406`, `64627a7`, `4ca25ba`, `c64924a`, `84d65ee`, `3e3b0e5`, `f5adbdc`, `3472f41`, `aff63a9`, `136c809`, `e17e84b`, `c681dd4` |
| **Actas de validación Walkthrough** *(nuevo)* | `589c0c2`, `e844850`, `e1bc900`, `ce43f2e`, `17fa9b5`, `85557dc`, `03955f4`, `3a55573`, `c1bbd40` |
| **Evidencia cifrada de walkthrough (videos)** *(nuevo)* | `8c6401f`/`c291851`, `ce17627` |
| **Member Checking** *(nuevo)* | `76c070e`, `9eb811c`, `ca71bcf`, `aa0e33a` |
| **Diagramas organizacionales i\*** *(nuevo)* | `3c0dc4c` |
| **Revisión de la doble codificación** *(nuevo)* | `07669dd`, `b08d935`/`89b4f14`/`d9c0023`, `95bed21`/`bd32c87`, `4540b6d`/`79c0ee2`/`cdc2b38`/`5f02e3c` |
| **Notas de campo (reorganización)** *(nuevo)* | `b2d5945`, `aee7cae`, `dc700ea`, `5b6a494`, `db39292`, `96a49a5`, `63e16e8`, `6d52633`, `808a192`, `70336af`, `616ad20`/`28c9d9e` |
| **Verificación previa** *(nuevo)* | `7387f01` |
| **Resincronización del pipeline de `07_Datos`** *(nuevo)* | `aee9c22`, `d488e93` |
| **Mantenimiento documental** *(nuevo)* | `9d7019e`, `f348fe1`, `c8486a9`, `78e4722`, `c2e7cea`/`3dcca76`/`3f586bf` |

### Firma

Jhon Alexander Mesías Quijije — Fecha: 12-09-2026

## Anthony Alfredo Vera Gómez (Responsable C8/C9 — Prototipo funcional MVP y Protocolo experimental)

### Responsabilidad asignada en el reparto de trabajo

Según `06_Experimento/README.md`: responsable de C8 (Prototipo funcional MVP) y C9 (Protocolo experimental). Esto coincide con lo ya escrito para él (componente empírico del Enfoque 3) y con el volumen real de commits, que está dominado por el modelado UML y el prototipo, no por el protocolo en sí.

### Artefactos de los que es responsable (constatado en esta revisión)

| Artefacto | Ruta | Descripción del aporte |
|---|---|---|
| Protocolo experimental | `06_Experimento/Protocolo_SGCV-IA_2A.pdf` | Diseño del componente empírico del Enfoque 3: preguntas de investigación (PICOC), proposiciones, variables, plan de análisis. |
| Registro OSF | `06_Experimento/OSF_Registration.pdf` | Registro previo del protocolo en OSF (1 de agosto de 2026), antes de la recolección de datos de la ronda terminal. |
| Confirmación de desviación del protocolo | Comunicación escrita, incorporada en `09_Publicacion/manuscrito_final.tex` (Sección 3.6b) | Confirmó por escrito que las Rondas 1 y 2 de validación no se ejecutaron dentro del plazo del proyecto, permitiendo documentar la desviación real en el manuscrito en lugar de dejarla sin resolver. |
| Diagramas de casos de uso (CU01–CU10) | `03_Modelado/Diagramas_UML/CU01_Login/` … `CU10_Billing_Collection/` (`.drawio`, `.svg`, `.png`) | Elaboración completa de los 10 diagramas de casos de uso del sistema (login, atención clínica, historial, inventario, empleados, IA, seguimiento nutricional, comunicación con cliente, centro de notificaciones, facturación/cobro), incluida una segunda pasada de renombrado a nomenclatura bilingüe consistente (`CU0X_Nombre_En_Ingles`). |
| Diagramas de secuencia | `03_Modelado/Diagramas_UML/DIAGRAM_SEQUENCE_BILLING`, `..._CLINICAL_CARE`, `..._REMINDER` | Diagramas de secuencia de facturación, atención clínica y recordatorios (versiones `.drawio`, `.svg`, `.png`). |
| Diagrama de clases refinado, componente y despliegue | `03_Modelado/Diagramas_UML/DIAGRAM_CLASS_REFINED_v3.1.*`, `Component_Diagram.*`, `Deployment_Diagram.*` | Versión 3.1 del diagrama de clases refinado; diagramas de componente y de despliegue. |
| Diagramas de estado | `03_Modelado/Diagramas_UML/Medical_Appointment_Status_Diagram.*`, `Product_State_Diagram.*` | Diagramas de estado de cita médica y de producto/inventario. |
| Mockups de interfaz (MU-001 a MU-033) | `03_Modelado/Mockups/` | Serie completa de mockups de pantallas del sistema (login, dashboard, pacientes, consultas, sugerencia de IA, seguimiento de peso, citas, inventario, comunicaciones, facturación, reportes, configuración/auditoría). |
| Backend del prototipo MVP | `05_MVP/backend/server.js`, `package.json`, `Dockerfile`, `docker-compose.yml` | Configuración del backend del prototipo funcional (Node.js) y su contenedorización. |
| Documentación del MVP | `05_MVP/README.md`, `SGCV-IA_Prototipo_Funcional.html` | Documentación de instalación/uso del prototipo. |

**Corrección a lo ya escrito en revisiones anteriores de este documento:**

- **"Guion de validación v2.0"** (`06_Experimento/instrumentos/Guion_Validacion_v2_0.pdf`): en una revisión previa se señaló que este archivo no existía en el repositorio (la única coincidencia era `06_Experimento/ instrumentos/Guion_Entrevista_v2.0.pdf`, un guion de **entrevista**, no de validación, creado por Amagua Sacón — `46297ae`, `1b0cb48`). **Actualización — instrumento localizado y subido.** El `Guion de validación v2.0` sí existe: fue diseñado por Vera Gómez y su archivo original (PDF, `CreationDate` del 6 de septiembre de 2026, verificable en la metadata) se sube ahora, sin modificar, a `06_Experimento/instrumentos/Guion_Validacion_v2_0.pdf`. El archivo incluye el instrumento aplicable (Secciones I–VIII), una nota de desviación para el manuscrito (Anexo A) y un borrador de comunicación interna del equipo (Anexo B). **El Anexo B es un borrador de mensaje, no una confirmación independiente de Vera Gómez** — se conserva en el archivo tal cual, pero no reemplaza su declaración propia (ver más abajo). Con esto, la desviación documentada en `07_Datos/desviaciones.md` (Rondas 1 y 2 diseñadas pero no ejecutadas) queda respaldada por evidencia real y verificable, en vez de una afirmación sin respaldo en el repositorio.

**Confirmación de Vera Gómez (relayada por Amagua Sacón el 12/09/2026, pendiente de que él la ratifique directamente por escrito o commit):** Vera Gómez confirma que él diseñó el instrumento y que lo terminó el 5 de septiembre de 2026. Indica que no lo subió antes al repositorio porque no sabía que era necesario hacerlo.

> **Nota de verificación:** la fecha que él reporta (5 de septiembre) no coincide exactamente con el `CreationDate` de la metadata del PDF (6 de septiembre). La diferencia es de un solo día y no cambia la conclusión de que el archivo es anterior a esta revisión — pero se deja anotada la discrepancia en vez de ajustarla, siguiendo el mismo criterio de no forzar los datos para que cuadren perfecto. Puede deberse a que el archivo se guardó/exportó al día siguiente de terminarlo, a diferencia de huso horario, o a un simple desfase de memoria; no se investigó más a fondo.

### Identificadores de commit

Extraídos y **verificados el 12/09/2026 mediante clonado directo del repositorio real** (`git log --author="Vera Gómez Anthony Alfredo"`, nombre canónico según `.mailmap`, que unifica las identidades `averag10@uteq.edu.ec` y `anthonyveragomez@gmail.com`). Se confirma que todos los commits bajo su identidad tienen cambios de archivo reales (`git diff-tree` no vacío) — no se encontró el patrón de commits vacíos detectado en la sección de Marcillo Ponce.

| Artefacto | Commit(s) |
|---|---|
| Protocolo experimental | `c38ab89` |
| Registro OSF | `6afbb4f` |
| Casos de uso — subida inicial (nomenclatura en español) | `915834e`, `4e8ca0c`, `2359674`, `6fcf088`, `400056c`, `daa6974`, `193420d`, `39ff860`, `d5ada5b`, `3c7dfaf`, `c7d9ecd`, `a5b149d` |
| Casos de uso — versión final bilingüe (`.drawio`/`.svg`) | `48ebc9c`, `70df1cf`, `1aea8a9`, `c4c5669`, `f399bea`, `19a7c0c`, `6e1ffe8`, `140067a`, `d0cf7d9`, `774cef8`, `fc67381`, `edc0d33`, `2f7e545`, `0c8152c`, `9b19aa9`, `01774fa`, `83ef355`, `141832d`, `c5eb4ca` |
| **Verificación:** total real de commits bajo casos de uso (incl. renombres, correcciones y limpieza de duplicados) | **67 commits** confirmados entre el 18/08 y el 01/09/2026 — más de los listados individualmente arriba; disponible el detalle completo fila-por-fila si se requiere para el anexo |
| Diagramas de secuencia | `49553b5`/`2695b53`/`62a226e` (facturación, incl. corrección de carpeta duplicada), `7aae45b`/`8f2a95b` (atención clínica), `fdae2cf`/`f92d9d2` (recordatorio) |
| Diagrama de clases refinado v3.1 | `7d35e6c` (drawio), `b4cc9b7` (svg), `07a213e` (rename a png) |
| Diagrama de componente | `b223d5c` (drawio), `7645070` (svg), `8254049` (rename a png) |
| Diagrama de despliegue | `bb79f90` (drawio), `43d555a` (svg), `13f038c` (rename a png) |
| Diagramas de estado | `d89e3c3`/`e8bf29c`/`7d64ffb` (cita médica: drawio/svg/rename png), `cca3769`/`f1f2885`/`aa4f912` (producto: drawio/svg/rename png) |
| Mockups MU-001 a MU-033 | **66 commits verificados** (más de los 31 listados en la revisión anterior de este documento — hay revisiones y renombres adicionales por archivo no capturados antes); entre ellos: `7c618f0`, `a52a134`, `5ba265f`, `09c032e`, `12fab99`, `27589a7`, `2eee8ec`, `3f2362c`, `e244e73`, `8263667`, `519b86d`, `946bf79`, `00c7119`, `277ad48`, `3a74aa3`, `eeca350`, `d9d5b72`, `f90174f`, `557cd3d`, `778d61f`, `bcf28af`, `67f8826`, `21245bc`, `e4bbab5`, `68fffe8`, `660fd16`, `fc431bc`, `2e596d3`, `f91c7bc`, `56b8740`, `ad7f30d`, `037d149` |
| Backend del MVP (`server.js`, `package.json`) | `dd19137`, `25c936e` (versión final en `05_MVP/backend/`, minúscula). **Nota:** existió una subida previa duplicada en `05_MVP/Backend/` (mayúscula) — `d475c52`, `95d2dee` — luego eliminada en `688b26d` al reestructurar la carpeta. |
| Dockerfile / docker-compose | `70f1e73`/`7517362` (Dockerfile, dos subidas), `6ae605e`/`5a130bb` (docker-compose, dos subidas) |
| Documentación del MVP | `75d2e59` (README inicial), `6ec3d4b`, `31f17b7`, `63801a8`, `32b4798`, `84c6fff`, `e24c503` (revisiones sucesivas), `3c722c5`/`bf01284` (HTML del prototipo, dos subidas) |
| Guion de validación v2.0 (`06_Experimento/instrumentos/Guion_Validacion_v2_0.pdf`) | **[PENDIENTE — completar con el hash del commit una vez subido]**. Archivo con `CreationDate` original del 06/09/2026 (metadata verificada), subido sin modificar. |

**Nota de verificación adicional:** en una revisión previa de este documento, el instrumento "Guion de validación v2.0" no aparecía bajo ninguna identidad de Vera Gómez en el historial del repositorio, porque aún no se había subido. Ver la corrección más arriba, en "Artefactos de los que es responsable".

### Firma

Anthony Alfredo Vera Gómez — Fecha: 12/09/2026




---

## Carlos Daniel Barrionuevo Fuentes (Responsable de criterios y actividades de la Entrega 4 — 2B)
 
### Responsabilidad asignada en el reparto de trabajo
 
Según `06_Experimento/README.md`: responsable de criterios y actividades generales de la Entrega 4 (2B) (misma descripción genérica que la de Marcillo Ponce en ese README). El historial de commits real, verificado con `git log --author` sobre las dos identidades usadas por Barrionuevo (`cbarrionuevof@uteq.edu.ec` y, por el incidente descrito más abajo, `jmesiasq@uteq.edu.ec`), muestra un aporte mucho más extenso que el de un par de scripts: la subida original de los datos crudos de campo, la construcción y mantenimiento casi completo del pipeline de análisis estadístico de `06_Experimento/`, y la construcción y mantenimiento del pipeline de datos reproducibles de `07_Datos/` hasta su resincronización final (n=210).
 
> Esta responsabilidad es la que consta en el README del proyecto; es genérica y no refleja el detalle real de su trabajo, que sí queda documentado en la tabla siguiente.
 
### Artefactos de los que es responsable
 
| Artefacto | Ruta | Descripción del aporte |
|---|---|---|
| Datos crudos de campo — subida original | `06_Experimento/datos_crudos/` (hoy `07_Datos/datos_crudos/` tras la reorganización de Amagua Sacón) | Subida inicial (1 de septiembre) de las 16 transcripciones de entrevistas (P01–P16), la encuesta cruda (`encuesta_respuestas_crudas.csv`) y el paquete `datos_crudos_paquete.zip`, antes de que el repositorio se reestructurara. |
| Pipeline de análisis estadístico de `06_Experimento/` | `06_Experimento/scripts_analisis/01_importar_datos.R` … `09_tablas.R`, `run_all.R`, `README.md` | Construcción del pipeline completo de 10 archivos (9-11 sep): importación, limpieza, descriptivos, verificación de supuestos, pruebas de hipótesis, tamaño de efecto, figuras y tablas, orquestado por `run_all.R`. La única excepción es `03_curva_saturacion_codigos_abiertos.R`, cuya subida inicial (5 sep) es de Marcillo Ponce; Barrionuevo la actualizó después (9 sep) junto con el resto del pipeline. |
| Resultados generados por ese pipeline | `06_Experimento/resultados/figuras/`, `resultados/tablas/`, `resultados/salidas_estadisticas/` | Subida de las figuras (boxplots por pregunta, distribución de perfiles, tamaño de efecto delta de Cliff, curva de saturación), tablas (descriptivos Likert, saturación) y salidas estadísticas (supuestos de Levene/Shapiro, pruebas de hipótesis por perfil, tamaño de efecto, justificación de potencia), como salida directa y no editada a mano del pipeline anterior (9 sep). |
| Datos procesados de `06_Experimento/` (migrados, ya no vigentes en esa ruta) | `06_Experimento/datos_procesados/` | Subida de los datos procesados (encuesta limpia/procesada, transcripciones limpias/completas) generados por el pipeline; carpeta eliminada de `06_Experimento/` el 10 de septiembre al consolidarse en `07_Datos/datos_procesados/`. Se lista por trazabilidad histórica. |
| Pipeline reproducible de `07_Datos/` | `07_Datos/scripts/run_all.R`, `importar_datos.R`, `curva_saturacion.R`, `conteo_codigos.R`, `generar_checksums.R`, `justificacion_muestra.R` | Construcción de un pipeline de 6 scripts en R que corre con un solo comando (`run_all.R` como orquestador) y genera, sin intervención manual, todos los resultados de `07_Datos/resultados/`: curva de saturación temática (recalculada desde la columna `Evidencia_participantes` del CSV de codificación axial, no copiada de ningún reporte), conteo de códigos por categoría, checksums de datos y la justificación estadística del tamaño de muestra de la encuesta, además de una tabla agregada (nunca por persona) del perfil de los participantes. Actualizado varias veces (7-11 sep) hasta su forma final. |
| Mantenimiento y resincronización final de `07_Datos/` | `07_Datos/datos_procesados/`, `resultados/`, `README_datos.md`, `diccionario_datos.csv`, `checksums_datos.sha256`, `registro_deposito.md`, `LICENSE-DATA.txt` | Mantenimiento extenso del paquete de datos entre el 7 y el 12 de septiembre: subida y reorganización iterativa de datos procesados y resultados, actualizaciones repetidas de checksums y del registro de depósito, y la resincronización final del pipeline completo con los datos definitivos (n=210), incluida la limpieza de un resultado duplicado (`justificacion_n210.md`). |
| `desviaciones.md` (contribución parcial) | `07_Datos/desviaciones.md` | El registro original de la Desviación 2 es de Marcillo Ponce (`90ad44d`); Barrionuevo completó después el motivo, la fecha y el campo "confirmado/verificado por" de esa desviación, y eliminó un placeholder vacío en `notas_campo` (11-12 sep). |
| Mapa de stakeholders (versión actual) | `04_Trazabilidad/Mapa_de_stakeholders.csv` | Última versión subida del mapa de stakeholders (la primera versión, de Marcillo Ponce, fue reemplazada por esta el 30 de agosto). |
| Trabajo temprano de ERS/Trazabilidad (2A, superado) | `01_ERS/ERS_SGCVIA_v3_0_4toA.pdf`, `04_Trazabilidad/Requisitos_Funcionales.*`, `Requisitos_No_Funcionales.*`, `Trazabilidad.*`, `C6_Priorizacion_Trazabilidad_Extendida.docx` | Documentos de una entrega anterior (2A/4toA); el propio Barrionuevo los eliminó el 2 de agosto al consolidarse la matriz única `matriz_trazabilidad.csv` de la Entrega 4. Se listan por trazabilidad histórica, no como artefactos vigentes. |
| Video de demostración del MVP (superado) | `05_MVP/Video_demo.mp4` | Video de demostración temprano del prototipo; ya no está en el repositorio (Vera Gómez quitó la referencia al reestructurar `05_MVP/` el 5 de septiembre). Se lista por trazabilidad histórica. |
 
### Identificadores de commit
 
Extraídos de `git log --author="cbarrionuevof@uteq.edu.ec"` y, para los commits del incidente de identidad (ver nota más abajo), `git log --author="jmesiasq@uteq.edu.ec"`, filtrando por ruta sobre el repositorio real. Las secuencias "Add files via upload" / "Update" / "Rename" / "Delete" repetidas sobre un mismo archivo corresponden a reorganización iterativa, no a artefactos distintos; se listan los commits más representativos de cada uno.
 
| Artefacto | Commit(s) |
|---|---|
| Datos crudos de campo — subida original | `c426180` (encuesta cruda), `eb5c729` (16 transcripciones), `712707d`/`663f0f2` (paquete zip, subida y limpieza) |
| Pipeline `06_Experimento/scripts_analisis/` | `f369096`/`2b35968`/`59d514c` (01_importar_datos), `ee05040`/`7e7206b`/`82e9cd0` (02_limpieza), `87eb965` (03_curva_saturacion, actualización sobre el archivo inicial de Marcillo `d03038c`), `72a0fd1`/`aa122a3`/`e6f5d6b` (04_descriptivos), `02fba14`/`989653d`/`cc99c7f` (05_supuestos), `91128c4`/`73546c3`/`595d941` (06_pruebas_hipotesis), `968d7ce`/`66e5232`/`8f61246` (07_tamano_efecto), `4227efc`/`5114d89`/`a0fb4a7`/`8bd7492` (08_figuras), `8286c09` (09_tablas), `0cc645b`/`75909f9`/`5145ece`/`ece11a4` (run_all.R), `f7cb20a`/`f278bfe` (README.md) |
| Resultados de `06_Experimento/resultados/` | `1658e11`…`1ae4bf9` (figuras), `7e828b2`/`35f2786` (tabla y figura de saturación abierta), `6d767eb` (descriptivos Likert), `2e26e32`/`c241c87`/`7c182f8`/`70a500f` (salidas estadísticas) |
| Datos procesados de `06_Experimento/` (migrados) | `e54ba2b`, `d12bf6b`, `93af51b`/`eddc414`/`2628693` (limpieza de duplicados), `2352775` (eliminación final de la carpeta) |
| `run_all.R` (07_Datos) | `5ec0f60` (subida), `cde7997` (actualización) |
| `importar_datos.R` (07_Datos) | `a916f5a`, `bd27ee3`, `1ca56f8` |
| `curva_saturacion.R` (07_Datos) | `1ce8891` |
| `conteo_codigos.R` (07_Datos) | `f640a02` |
| `generar_checksums.R` (07_Datos) | `520d50e` |
| `justificacion_muestra.R` (07_Datos) | `a3ff9ed`, `8f8c249`, `a025392`, `9a7a927`, `4ef2732` |
| Mantenimiento de `07_Datos/` (datos procesados, resultados, README, diccionario, checksums, registro de depósito) | `20e44bf`, `8735c71`, `6ba192d`, `e6c0897`, `5c99de3`, `42f300f`, `4d9bd84`, `4c06239`/`594787b`/`3a7d691`/`fe74bbc`/`6d51499`/`c47c3a1`/`39927da`/`96e975b` (limpieza de duplicados), `229ad57`/`540f784`/`02e77b4` (registro_deposito.md), `bf5f885`/`a2e076d`/`5fa15ef`/`cdcfd59` (checksums_datos.sha256), `676ebaf`/`35dc730` (README_datos.md), `ba4ff00`/`978dad6` (diccionario_datos.csv), `b0db7b3`/`a795119`/`eff4bac`/`4431c10`/`aa7073c`/`b3a092c` (resultados) |
| `desviaciones.md` (contribución parcial) | `22af379`, `fc9af05`, `3d07d7c` |
| `Mapa_de_stakeholders.csv` (versión actual) | `4e30bc0` |
| Documentos ERS/Trazabilidad 2A (eliminados) | `41b20d7`, `757a91e`, `016cf52`, `f05ac19`, `153bef6`, `048f693` |
 
### Nota de aclaración — commits del 11 y 12 de septiembre bajo identidad incorrecta
 
Los siguientes commits, todos correspondientes a trabajo real de Carlos Daniel Barrionuevo Fuentes
(resincronización del pipeline de `07_Datos/`, regeneración de checksums y correcciones de
documentación de cierre), aparecen firmados como `jmesiasq-art <jmesiasq@uteq.edu.ec>` porque se
realizaron desde una terminal Git Bash configurada localmente con la identidad de Jhon Alexander
Mesías Quijije, en lugar de la propia:
 
| Commit | Fecha/hora | Descripción |
|---|---|---|
| `878777c` | 2026-09-11 23:18 | Regenera checksums.sha256 y checksums_datos.sha256 (primer intento) |
| `dd2c7bd` | 2026-09-11 23:19 | Merge |
| `3beda6b` | 2026-09-11 23:32 | Corrige checksums.sha256 de la raíz |
| `aee9c22` | 2026-09-11 23:34 | Regenera checksums_datos.sha256 y registro_deposito.md |
| `2fc1823` | 2026-09-11 23:40 | Quita línea de adjunto de GitHub en README_datos.md |
| `2ed3499` | 2026-09-11 23:43 | Corrige typo scritps -> scripts en 10_Autoria |
| `d488e93` | 2026-09-12 00:06 | Resincroniza el pipeline de 07_Datos con los datos actuales (n=210) |
| `432ea81` | 2026-09-12 00:07 | Merge |
 
El commit `22af379` ("Update desviaciones.md", mismo período) sí aparece correctamente firmado
como Carlos Daniel Barrionuevo Fuentes porque se realizó editando directamente en la interfaz web
de GitHub, que usa la cuenta autenticada del navegador en vez del `git config` local de la
terminal.
 
**Motivo del error:** ambos integrantes compartieron temporalmente el mismo equipo/terminal
durante el cierre de la Entrega 4, y no se verificó la identidad de Git configurada antes de
empezar a commitear.
 
**Corrección aplicada:** el 12 de septiembre de 2026 se corrigió el `git config` local de esa
máquina (`user.name` y `user.email`) a la identidad de Carlos Daniel Barrionuevo Fuentes, para que
los commits posteriores queden correctamente atribuidos. Los commits ya listados arriba no se
reescribieron (`rebase`/`amend`) para evitar romper las referencias por hash que ya existen en
este documento y en `10_Autoria/bitacora_sesiones.csv`; en su lugar, quedan aclarados aquí por
escrito.
 
**Confirmado por:** Carlos Daniel Barrionuevo Fuentes.
 
### Firma
 
Carlos Daniel Barrionuevo Fuentes — Fecha: 12/09/2026

---
