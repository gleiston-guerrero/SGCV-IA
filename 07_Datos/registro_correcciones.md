# Registro de correcciones — Plan de mejora de datos v3.1

Proyecto SGCV-IA. Cada entrada documenta: qué cambió, por qué, con qué evidencia, y en qué commit (a completar tras el commit correspondiente).

---

## Bloque B — Transcripciones, audio/vídeo y perfiles

### B1 — Cotejo completo P01–P16 contra su audio — CORREGIDO (19/09/2026)

**Hallazgo:** además del intercambio de archivos de audio ya documentado en B3, el **contenido de las transcripciones "revisada"** estaba mal atribuido entre participantes — un problema distinto e independiente del de B3 (una cosa es qué archivo de audio tiene cada nombre; otra, si el texto transcrito corresponde a ese audio). De las 16, solo 3 (P08, P09 y la que se creía P11) coincidían originalmente con su propio audio.

**Método de verificación (dos técnicas independientes, ambas documentadas):**
1. **Contenido:** similitud de conjuntos de palabras (Jaccard sobre tokens ≥7 caracteres) entre la transcripción automática de TurboScribe de cada audio (nombrada por participante, confirmada por el propio usuario al descargarla de su cuenta) y cada archivo "revisada" existente. Coincidencias reales: 0.76–1.00. No-coincidencias: 0.19–0.47. Separación limpia, sin casos ambiguos.
2. **Duración:** ritmo de habla (palabras del texto final ÷ duración de audio en `fichas_tecnicas.csv`, verificada por hash SHA-256). Usado como confirmación cruzada, no como método principal (no distingue de forma fina entre participantes de duración similar).

**Mapeo final (contenido real de cada audio, indicando bajo qué etiqueta estaba archivado antes de esta corrección):**

| Audio | Contenido real estaba archivado como | Evidencia |
|---|---|---|
| P01 | "P04" | Jaccard 0.92 |
| P02 | "P05" | Jaccard 1.00 |
| P03 | "P01" | Jaccard 0.76 |
| P04 | "P03" | Jaccard 0.86 |
| P05 | "P02" | Jaccard 0.63 |
| P06 | "P07" | Jaccard 0.89 |
| P07 | "P06" | Jaccard 0.90 |
| P08 | "P08" (correcto) | Jaccard 0.99 |
| P09 | "P09" (correcto) | Jaccard 1.00 |
| P10 | "P15" | Jaccard 0.80 (automático nombrado directamente + duración: 129 wpm a 835 s) |
| P11 | "P15" (archivo original, distinto del de arriba) | Jaccard 0.80 con automático nombrado Audio_P11; duración 118 wpm a 1156 s |
| P12 | "P10" | Jaccard 0.82 |
| P13 | "P16" | Jaccard 0.95 |
| P14 | "P12" | Jaccard ≥0.76 (cadena original) |
| P15 | "P13" | Jaccard ≥0.76 (cadena original) |
| P16 | "P14" | Jaccard ≥0.76 (cadena original) |

**Nota metodológica importante:** los nombres de archivo `.txt` exportados de TurboScribe (incluso cuando el propio usuario los nombra "Audio_P11_Entrevista.txt") **no son evidencia por sí solos** — durante esta verificación se detectó un caso (P10/P11) en el que un archivo nombrado explícitamente como un participante resultó pertenecer a otro, según el cruce de contenido y duración. Por eso todo el mapeo final se apoya en Jaccard + duración con hash, nunca solo en el nombre del archivo.

**Validación final por duración (hash-verificada) sobre el contenido ya corregido — sin anomalías:**

| ID | Palabras | Audio (s) | Ritmo (wpm) |
|---|---|---|---|
| P01 | 923 | 549.8 | 101 |
| P02 | 1313 | 737.0 | 107 |
| P03 | 2421 | 862.8 | 168 |
| P04 | 1751 | 879.7 | 119 |
| P05 | 2054 | 670.7 | 184 |
| P06 | 1734 | 668.7 | 156 |
| P07 | 1669 | 674.7 | 148 |
| P08 | 1669 | 750.8 | 133 |
| P09 | 2444 | 985.5 | 149 |
| P10 | 1789 | 835.1 | 129 |
| P11 | 2267 | 1155.8 | 118 |
| P12 | 1716 | 795.7 | 129 |
| P13 | 2332 | 1148.9 | 122 |
| P14 | 1699 | 816.2 | 125 |
| P15 | 2667 | 1180.8 | 136 |
| P16 | 1358 | 671.8 | 121 |

Todos dentro del rango normal de habla conversacional en español (90–220 wpm). Ninguna entrevista quedó sin explicación.

**Turnos Entrevistador/Participante (P09–P16):** P01–P08 ya traían turnos etiquetados y se conservaron al reasignar el contenido. P09–P16 no tenían etiquetas de turno (solo texto corrido con marcas de tiempo). Se generaron por un heurístico automático (segmentación por tramos `¿...?` = Entrevistador, resto = participante, con fusión de fragmentos residuales), revisado y aprobado por el equipo sobre una muestra (P10) antes de aplicarse al resto. **Limitación conocida, no resuelta:** cuando el entrevistador lee una lista de opciones de respuesta sin signo de interrogación antes de la pregunta final, el heurístico puede atribuir ese fragmento al turno equivocado. Requiere revisión manual puntual, no aplicado todavía.

**Dos versiones conservadas por participante** (entregadas en `Transcripciones_finales/`): `PXX_AUTOMATICA_TurboScribe.txt` (salida cruda de TurboScribe, sin editar) y `PXX_REVISADA.md` (contenido reasignado al audio correcto + turnos separados donde aplica).

**Impacto en otros hallazgos del plan:** ver B4 (resuelto por este hallazgo) y B6 (parcialmente resuelto). La Desviación 3 registrada en `desviaciones.md` (P04 incompleta) se basaba en contenido mal atribuido y fue retractada — ver nota de actualización en ese archivo.

### B3 — Duraciones cruzadas en fichas_tecnicas.csv — CORREGIDO

Verificado contra 02_Evidencias/fichas_tecnicas.csv (duraciones en segundos, precisión de microsegundos): los audios etiquetados P10, P11, P12, P13, P14, P15 y P16 no correspondían a su propio vídeo, sino al de otro participante del mismo bloque de grabación (31/08). Se identificó el mapeo real por coincidencia de duración (exacta o con diferencia ≤0.011 s, consistente con redondeo de contenedor, frente a la audio de P06/P07 que difiere ~0.4–0.5 s y NO se trata como el mismo error):

| Etiqueta original | Duración (s) | Participante real (según vídeo) |
|---|---|---|
| Audio "P10" | 835.114667 | P12 |
| Audio "P11" | 1155.818667 | P16 (coincidencia exacta) |
| Audio "P12" | 795.712000 | P10 |
| Audio "P13" | 1148.949333 | P15 |
| Audio "P14" | 816.170667 | P11 (coincidencia exacta) |
| Audio "P15" | 1180.821333 | P13 (coincidencia exacta) |
| Audio "P16" | 671.808000 | P14 (coincidencia exacta) |

**Corrección aplicada:** se generaron copias de los 7 archivos de audio con el nombre de participante correcto en `Audio_corregido/` (mismo contenido/hash, solo el nombre cambia), y se corrigió `02_Evidencias/fichas_tecnicas.csv` para que cada fila de audio use el nombre de archivo del participante real. Falta: reemplazar físicamente los archivos mal etiquetados por las copias corregidas (mover de `Audio_corregido/` a la carpeta de evidencia y eliminar los originales mal nombrados) y recifrar el contenedor `00_Restringido` con los nombres corregidos.

Nota (19/09/2026): esta corrección (identidad del archivo de audio) es independiente de la corrección de contenido documentada en B1 (qué texto transcrito corresponde a cada audio). Ambas se verificaron por separado y ambas quedan resueltas.

### B4 — P01: palabras vs. duración de audio — RESUELTO (19/09/2026)

Se verificó de forma independiente (ffprobe sobre el archivo real, no solo el CSV) que el audio 2026-05-26_Audio_P01_Entrevista.mp3 dura 549.864 s (9.16 min) y su hash SHA-256 (084dc068d4677f8bde28bfecb2e4863392a1558bb4b6ce706d38418b9abcf2e2) coincide exactamente con el registrado en fichas_tecnicas.csv.

El conteo original (2292–2373 palabras, ~250 wpm) se hizo sobre el archivo `P01_revisada.md` vigente en ese momento, que el cotejo de B1 determinó que en realidad era el contenido de **P03**, no de P01. El contenido real de P01 (verificado por contenido y por duración, ver B1) tiene 923 palabras para 549.8 s de audio: **101 wpm, ritmo normal.**

**Conclusión: no hubo manipulación ni fabricación de datos. La discrepancia se explicaba enteramente por el error de etiquetado documentado en B1.**

### B2 — Herramienta de transcripción declarada

Se declaró en 07_Datos/README_datos.md (sección "Herramienta y procedimiento de transcripción") que las 16 entrevistas se transcribieron con TurboScribe (transcripción automática por IA), y que el equipo aplicó etiquetado de turnos y revisión ortográfica sobre la salida automática. Actualización (19/09/2026): ya se conserva copia sin editar de la transcripción automática original por participante (ver B1, `Transcripciones_finales/`), cerrando el pendiente que quedaba abierto en esta entrada.

### B5 — P04 incompleta — RETRACTADO (19/09/2026)

Esta entrada se basaba en la Desviación 3 registrada en `07_Datos/desviaciones.md`, que a su vez se basaba en contenido mal atribuido a P04 (en realidad correspondía a P01, ver B1). El contenido real de P04 es una entrevista completa, sin mención de una visita anterior no grabada. Ver nota de actualización en `desviaciones.md`, Desviación 3.

### B6 — Perfil único por participante (P11–P16) — RESUELTO (19/09/2026)

Se verificó el rol de cada participante contra el campo `Rol` del archivo fuente de su contenido ya reasignado (B1) y contra la autodescripción en el propio texto de la entrevista (ej. P11 se identifica como "auxiliar" y "estudiante" de zootecnia; P16 dice explícitamente "como auxiliar apoyo..."). Tabla final, ya aplicada en las 16 transcripciones entregadas:

| Participante | Rol confirmado | Evidencia |
|---|---|---|
| P09 | Veterinario | Metadato del archivo fuente |
| P10 | Veterinario | Metadato del archivo fuente |
| P11 | Auxiliar veterinario (estudiante de zootecnia) | Autodescripción en el contenido — corrige el campo `Rol` original, que decía "Veterinario" |
| P12 | Veterinario | Metadato del archivo fuente |
| P13 | Veterinario | Metadato del archivo fuente |
| P14 | Auxiliar veterinario | Metadato del archivo fuente |
| P15 | Auxiliar veterinario | Metadato del archivo fuente + autodescripción ("como estudiante...") |
| P16 | Auxiliar veterinario | Metadato del archivo fuente + autodescripción ("como auxiliar apoyo...") |

Se corrigió el campo `Rol` de P11 en la transcripción entregada. El resto ya traía el campo correcto en el archivo fuente; solo estaba mal atribuido por el error de contenido de B1, y quedó resuelto al reasignar el contenido a su participante real.

### B7 — Fechas P09, P04, P07 — RESUELTO (19/09/2026)

Verificado contra fichas_tecnicas.csv y transcripciones_metadata.csv. Decisión aplicada: cuando audio y vídeo/transcripción difieren en fecha de archivo, se usa la fecha del **audio** como fecha real de la sesión — es el archivo que se genera y guarda en el momento mismo de grabar, mientras que vídeo/transcripción pueden tener fecha de archivo posterior por exportación o procesamiento (caso ya confirmado en P09, donde la transcripción quedó fechada 4 días después de la grabación real).

- **P09:** audio y vídeo con fecha de archivo 2026-08-27; transcripción y consentimiento fechados 2026-08-31 (fecha de procesamiento, no de sesión). **Corregido:** `Fecha de la sesión` → 2026-08-27, y el archivo se renombró de `2026-08-31_Transcripcion_P09_Entrevista.md` a `2026-08-27_Transcripcion_P09_Entrevista.md` para mantener la convención de nombre = fecha real de sesión.
- **P04:** audio fechado 2026-07-25; vídeo (Parte1 y Parte2) fechado 2026-07-28 — la división en dos partes es indicio adicional de que el vídeo se procesó/exportó después. Se mantiene 2026-07-25 (fecha del audio) como fecha real de sesión. Sin cambios de archivo (ya usaba esa fecha).
- **P07:** audio fechado 2026-07-27; vídeo fechado 2026-07-28. Mismo criterio: se mantiene 2026-07-27 (fecha del audio). Sin cambios de archivo (ya usaba esa fecha).

---

## Bloque G — Ética y protección de datos personales

### G1 — Datos personales retirados del árbol actual — CORREGIDO (19/09/2026)

**Hallazgo 1 (cédulas):** `08_Etica/Solicitud_Aprobacion_Etica_SGCV-IA.pdf`, página 4 ("Nómina del equipo estudiantil"), exponía las cédulas de identidad reales de los 5 integrantes del equipo.

**Corrección aplicada:** se generó una versión redactada del PDF (`Solicitud_Aprobacion_Etica_SGCV-IA.pdf`, misma ruta) en la que las 5 cédulas se eliminaron del contenido del documento mediante redacción real (no un tachado visual: el texto ya no es extraíble ni buscable en el PDF resultante). Se verificó, tras la redacción, que ninguna de las 5 cadenas de cédula es recuperable con búsqueda de texto sobre el PDF. El resto del contenido del oficio (nombres, correos, roles, cuerpo normativo) no se modificó.

**Hallazgo 2 (nombres de clínicas en nombres de archivo):** los 19 archivos de `02_Evidencias/Fotos_Entorno/` incluían el nombre de la clínica en el propio nombre de archivo (ej. `2026-07-27_Veterinaria911Animal_Recepcion_01.jpeg`), para 6 clínicas de las cuales solo una (Veterinaria Macay) cuenta con un principio de aval institucional (ver G3, aún sin firmar).

**Corrección aplicada:** se renombraron los 19 archivos a un esquema anonimizado `Clinica01`…`Clinica06` que conserva la fecha y el tipo de foto (Exterior, Recepción, Consultorio, Atención Veterinaria) pero no el nombre de la clínica. Se actualizaron en consecuencia las 19 líneas correspondientes de `checksums.sha256` y las 19 líneas de `10_Autoria/exif_inventario.csv` (mismo hash SHA-256 por archivo; solo cambia la ruta/nombre). El mapeo real clínica↔código se mantiene **fuera del repositorio público**, en poder del equipo, y no se publica en `registro_correcciones.md` porque hacerlo anularía la anonimización.

**Nota sobre el alcance de esta corrección:** conforme a la Regla 1 del plan de mejora de datos, esta corrección solo retira los datos personales del **árbol actual** (commit nuevo). Las cédulas y los nombres de clínica en los nombres de archivo originales permanecen visibles en los commits anteriores del historial de git. La limpieza de historial (`git filter-repo` o equivalente) es la única excepción permitida a "no reescribir el historial", y el plan exige coordinarla con el docente y obtener su autorización escrita antes de ejecutarla. **Pendiente:** solicitar esa autorización.

**Hallazgo 3 (cédulas en otros dos documentos, no detectado en la primera revisión):** tras corregir `Solicitud_Aprobacion_Etica_SGCV-IA.pdf`, se hizo una búsqueda de las 5 cédulas sobre **todos** los PDF de `08_Etica/` (no solo ese archivo). Aparecían también en `A09_Anexo.pdf` (Nómina del Equipo Estudiantil) y dos veces dentro de `SGCV-IA_Carpeta_Etica.pdf` (documento consolidado de 38 páginas, páginas 2 y 28 — la misma tabla de nómina repetida). Se detectó además que en estos dos documentos la cédula de Robyn Amagua Sacón está escrita con un dígito de menos (`125123430`, 9 dígitos) respecto a la versión correcta (`1251323430`, 10 dígitos) — un error de tipeo preexistente, no introducido por esta corrección, que no afecta la necesidad de taparla.

**Corrección aplicada:** se redactaron (texto no extraíble, no solo tachado visual) las 5 cédulas en `A09_Anexo.pdf` (5 coincidencias) y en las 2 apariciones de la tabla dentro de `SGCV-IA_Carpeta_Etica.pdf` (10 coincidencias). Verificado por búsqueda de texto tras la redacción: ninguna de las 6 variantes de cédula (las 5 correctas + la versión con el dígito faltante) es recuperable en ninguno de los dos archivos.

**Verificado que `Aval_Institucional.pdf` no contiene ninguna cédula** (solo nombres, RUC de la clínica y firma) — no necesitaba corrección en G1.

### G3 — Aval institucional de Veterinaria Macay — CORREGIDO (19/09/2026)

**Hallazgo original:** `08_Etica/Aval_Institucional.pdf` era un formato sin fecha, cargo, RUC ni firma, y cubría una sola clínica de las 6 donde el equipo recolectó evidencia.

**Corrección aplicada (en 3 entregas sucesivas del equipo, verificadas cada una):**
1. Primera versión recibida: RUC (`0958312653001`) y firma + sello del Dr. Bryan Macay ya presentes; fecha y cargo seguían en blanco.
2. Segunda versión: se agregó la fecha (`19 de 09 de 2026`); el cargo seguía en blanco — verificado con zoom sobre la línea "en mi calidad de ___", que no tenía nada escrito.
3. Versión final: se agregó el cargo (**"Dueño"**) en la línea "en mi calidad de ___". Verificado con zoom: los 4 campos (fecha, cargo, RUC, firma+sello) están completos.

**Documento final:** `08_Etica/Aval_Institucional.pdf` (reemplaza al original), con: Quevedo, 19 de 09 de 2026; Bryan Macay, en su calidad de Dueño de Veterinaria Macay, RUC 0958312653001; firmado y sellado (Md. Macay Macías Bryan, Médico Veterinario, Telf. 096 995 6188).

**Alcance de lo que queda resuelto:** solo el aval de Veterinaria Macay. Las otras 5 clínicas donde el equipo recolectó fotos/entrevistas (ver G1) siguen sin aval institucional — declarado como limitación conocida en `desviaciones.md` ("Declaración — Cobertura real de avales institucionales por clínica"), no como algo pendiente de resolver aquí.

**Fecha de esta corrección:** 19 de septiembre de 2026.

**Confirmado por:** Anthony Alfredo Vera Gómez, verificando cada campo del documento por zoom antes de aceptar cada entrega como completa.

### G6 — Estado real de la aprobación ética declarado — CORREGIDO (19/09/2026)

**Hallazgo:** `08_Etica/Adenda_Segunda_Ronda.pdf` afirmaba que la segunda ronda se ejecuta "bajo el mismo marco ético ya aprobado", pero no existe en el repositorio ninguna comunicación oficial del Vicerrectorado Académico que apruebe el proyecto — solo la solicitud (`Solicitud_Aprobacion_Etica_SGCV-IA.pdf`), con su campo de fecha sin completar.

**Corrección aplicada:** se sustituyó "ya aprobado" por "ya iniciado" en el PDF de la Adenda. Se agregó una declaración completa del estado real del trámite en `07_Datos/desviaciones.md` ("Declaración — Estado real de la aprobación ética institucional"), incluyendo qué falta (fecha de envío del oficio, respuesta oficial con número de acta/resolución).

**Pendiente:** el docente responsable es quien puede confirmar si existe una respuesta del Vicerrectorado no reflejada en este repositorio.

### G7 — Identificadores externos e inconsistencia de fechas — CORREGIDO (19/09/2026)

**Hallazgo 1 (nota desactualizada en el README raíz):** la nota de consistencia de `README.md` (identificadores externos) afirmaba que `11_Defensa/guion.md`, `presentacion.pptx`, `06_Experimento/README.md` y `06_Experimento/prompts_llm/README.md` "todavía citan" un DOI Zenodo y un OSF distintos (`22238486` / `wkg32`). Se verificó archivo por archivo (búsqueda de texto en los `.md` y extracción de texto de cada shape del `.pptx`) y ninguno de los cuatro contiene ya esos identificadores antiguos: los cuatro usan `osf.io/r5p8d` y `10.5281/zenodo.22558095`. La nota estaba desactualizada.

**Corrección aplicada:** se reescribió la nota de consistencia del `README.md` raíz para reflejar el estado real verificado, y se conservó como pendiente real lo que sí sigue sin resolver: la verificación directa de `r5p8d`/`22558095` contra los sitios de OSF y Zenodo (no solo por consistencia interna entre documentos).

**Hallazgo 2 (fecha del registro OSF posterior al inicio de la recolección):** el registro en OSF (`06_Experimento/OSF_Registration.pdf`) muestra fecha de registro 01/08/2026 y estado "Currently Archiving". Se contrastó contra las fechas reales de las 16 entrevistas y la primera respuesta de la encuesta (27/07/2026): el registro es posterior a 8 de las 16 entrevistas (P01–P08) y al inicio de la encuesta, y anterior a las otras 8 (P09–P16).

**Corrección aplicada:** se documentó como Desviación 4 en `07_Datos/desviaciones.md`, con el detalle de qué parte del estudio sí queda protegida por el registro previo (P09–P16) y cuál no (P01–P08 y la encuesta).

### G4 — Consentimientos originales P01–P16 — NO COMPLETADO (19/09/2026)

**Qué pedía la tarea:** entregar en físico al docente los consentimientos originales firmados de P01–P16; explicar la sustitución del 16/09 de los consentimientos de P11–P16 (sus hashes ya no coinciden con `fichas_tecnicas.csv`); aportar el formulario original de P02 (el archivo actual es una captura); declarar que se grabó vídeo aunque el consentimiento firmado solo cubre audio.

**Por qué no se completó:** la entrega física de los 16 originales requiere verlos en persona con el docente, y el equipo no ha podido coordinar esa reunión antes del corte de este documento. Sin esa instancia presencial no se puede cotejar el original contra el escaneo, ni el equipo puede recuperar por su cuenta el formulario original de P02 (solo existe la captura) ni reconstruir por qué se sustituyeron los archivos de P11–P16 el 16/09 sin preguntarle a quien hizo ese cambio.

**Estado de cada punto:**
- Consentimientos originales P01–P16: pendiente de entrega física — sin fecha agendada.
- Sustitución del 16/09 en P11–P16 (hashes no coinciden con `fichas_tecnicas.csv`): sin explicar, se solicitó al equipo (ver coordinación interna) y no ha habido respuesta.
- Formulario original de P02: no localizado; solo existe la captura actual.
- Declaración vídeo-sin-consentimiento-de-vídeo: sin confirmar por el equipo todavía.

**Consecuencia:** esta tarea queda sin puntos (coeficiente "Por iniciar" según la rúbrica del plan, sección 2, salvo que se resuelva antes de la revisión). Se declara así, en vez de omitirla, para que el correo de entrega (punto 4 de la sección "Entrega" del plan) refleje la razón real por la que no se pudo cumplir.

**Fecha de esta declaración:** 19 de septiembre de 2026, por Anthony Alfredo Vera Gómez.

### G5 — Fecha real de redacción de las notas de campo — RESUELTO (19/09/2026)

**Hallazgo original:** las 16 notas de campo (`10_Autoria/notas_campo/P01_Nota_Campo.pdf`…`P16_Nota_Campo.pdf`) se escanearon y subieron el mismo día, 12/09/2026, con formato idéntico (metadato `creationDate` del escáner: `D:20260912081606-05'00'` en las 16, productor "Epson Scan 2"). Esto por sí solo era indistinguible de una reconstrucción posterior en bloque.

**Verificación realizada:** se abrió cada una de las 16 notas (no una muestra) y se leyó el campo manuscrito "Fecha" del encabezado de cada una, contrastándolo contra la fecha real de la entrevista correspondiente (`02_Evidencias/Transcripciones/`, ya verificada en B1/B7):

| Participante | Fecha manuscrita en la nota | Fecha real de la entrevista | Coincide |
|---|---|---|---|
| P01 | 2026-05-26 | 2026-05-26 | Sí |
| P02 | 2026-05-26 | 2026-05-26 | Sí |
| P03 | 2026-07-21 | 2026-07-21 | Sí |
| P04 | 2026-07-25 | 2026-07-25 | Sí |
| P05 | 2026-07-25 | 2026-07-25 | Sí |
| P06 | 2026-07-27 | 2026-07-27 | Sí |
| P07 | 2026-07-27 | 2026-07-27 | Sí |
| P08 | 2026-07-28 | 2026-07-28 | Sí |
| P09 | 2026-08-27 | 2026-08-27 (fecha de sesión, ver B7) | Sí |
| P10 | 2026-08-31 | 2026-08-31 | Sí |
| P11 | 2026-08-31 | 2026-08-31 | Sí |
| P12 | 2026-08-31 | 2026-08-31 | Sí |
| P13 | 2026-08-31 | 2026-08-31 | Sí |
| P14 | 2026-08-31 | 2026-08-31 | Sí |
| P15 | 2026-08-31 | 2026-08-31 | Sí |
| P16 | 2026-08-31 | 2026-08-31 | Sí |

Las 16 notas ya traían, antes de esta corrección, un campo de fecha visible que coincide exactamente con la fecha real de cada entrevista — distinto en cada caso, no una fecha uniforme. El 12/09/2026 corresponde únicamente al metadato de escaneo (cuándo se digitalizaron los 16 papeles ya escritos), no a cuándo se redactaron.

**Declaración del equipo sobre cuándo se escribieron:** confirmado por Anthony Alfredo Vera Gómez que las 16 notas se redactaron a mano el mismo día de cada entrevista (o inmediatamente después, en el sitio), y que el 12/09/2026 fue solo la fecha en que se juntaron y escanearon los 16 papeles físicos ya existentes.

**Conclusión:** el criterio de aceptación ("fecha de redacción visible en cada nota") ya se cumplía en el contenido de las notas; no correspondía rotular ninguna como "reconstrucción posterior", porque según lo declarado por el equipo no hubo redacción posterior a la entrevista.

**Fecha de esta corrección:** 19 de septiembre de 2026.

**Confirmado por:** Anthony Alfredo Vera Gómez.

**Verificado por:** pendiente de confirmación por el resto del equipo (quienes tomaron cada nota en el terreno).

### G2 — Datos confidenciales retirados del árbol público — CORREGIDO (19/09/2026)

**Hallazgo:** `07_Datos/LICENSE-DATA.txt` declara que `datos_crudos/encuesta_respuestas_crudas.csv` y `datos_crudos/Entrevistas/*.md` "NO se publican ni se depositan en ningún repositorio público" y que las transcripciones completas van solo en el contenedor cifrado. En la práctica estaban públicas en dos lugares: `07_Datos/datos_crudos/` (1 CSV + 16 `.md`) y duplicadas en `02_Evidencias/Transcripciones/` (16 `.md`). Se confirmó que el repositorio es público (se clona sin credenciales), por lo que esto era una exposición real de contenido literal de las 16 entrevistas, no un riesgo teórico.

**Corrección aplicada:** se retiraron del árbol público los 33 archivos (`encuesta_respuestas_crudas.csv`, los 16 `.md` de `datos_crudos/Entrevistas/`, y los 16 `.md` de `02_Evidencias/Transcripciones/`). No se reescribió `LICENSE-DATA.txt`: su texto ya describía correctamente la política que debía regir; el problema era que el repositorio no la cumplía, no que el texto estuviera mal.

**Consecuencia sobre otra tarea del plan (nota, no resuelta aquí):** `07_Datos/scripts/importar_datos.R` lee directamente estos mismos archivos, y la tarea A5 exige que la cadena de análisis sea "reproducible con `run_all.R` en una instalación limpia". Al retirar los archivos del árbol público, esa reproducibilidad deja de cumplirse para quien clone el repositorio sin acceso al contenedor cifrado `02_Evidencias/00_Restringido/`. Esto se deja señalado aquí y en `desviaciones.md`; resolverlo (por ejemplo, incorporando estos archivos al contenedor cifrado y ajustando el script) corresponde a cuando se trabaje el Bloque A, no a esta corrección.

**Fecha de esta corrección:** 19 de septiembre de 2026.

**Confirmado por:** Anthony Alfredo Vera Gómez.

**Verificado por:** pendiente de confirmación por el resto del equipo.
