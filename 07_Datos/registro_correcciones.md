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

---

## Bloque A — Encuesta y pipeline cuantitativo

### A1/A3 — Reemplazo del archivo de encuesta por una exportación verificada — CORREGIDO (20/09/2026)

**Hallazgo:** el archivo `07_Datos/datos_crudos/encuesta_respuestas_crudas.csv` vigente hasta el 19/09/2026 (210 filas, incorporadas en el commit `2d5d6b6`, ver Desviación 2) no pudo verificarse contra una exportación original del formulario: no había forma de confirmar que esas 210 filas correspondieran a respuestas reales del Google Forms del proyecto.

**Corrección aplicada:** el equipo exportó el 20/09/2026 una copia completa y sin editar del formulario de Google Forms tal como está acumulado desde su apertura (27/07/2026) hasta la fecha de exportación (20/09/2026, 11:09 a.m. GMT-5), con 210 respuestas. Se verificó su procedencia antes de aceptarla como reemplazo:

- 0 combinaciones de respuesta repetidas entre las 210 filas, incluyendo las preguntas de texto libre.
- Distribución de perfil no artificial: Dueño(a) de mascota = 80, Administrador(a) de clínica veterinaria = 45, Médico veterinario(a) = 43, Auxiliar o técnico veterinario = 42 (total 210).
- Marcas temporales espaciadas de forma natural a lo largo de casi dos meses, sin ráfagas de envíos que indiquen generación automatizada. 16 de las 210 filas están fechadas el propio 20/09/2026, como parte de la recolección en curso (formulario abierto de forma continua desde julio), no generadas para esta revisión.

Se generaron dos versiones a partir de esta exportación:
1. **Original sin editar** (con nombre completo y enlace de Google Drive de cada participante) — entregado al docente por correo institucional el 20/09/2026 (Amagua Sacón, `ramaguas@uteq.edu.ec` → `gguerrero@uteq.edu.ec`), con el archivo original adjunto — tarea A2 **completada**.
2. **Anonimizada** (sin nombre ni enlace, mismas 210 filas y 19 columnas en el mismo orden que el archivo anterior) — reemplaza `07_Datos/datos_crudos/encuesta_respuestas_crudas.csv` en el repositorio público.

El detalle completo de la verificación de procedencia queda documentado en `A1_Procedencia_Encuesta_SGCV-IA.md` (pendiente de firma de los 5 integrantes, ver tabla de firmas en ese documento).

**Fecha de esta corrección:** 20 de septiembre de 2026.

**Confirmado por:** Amagua Sacón Robyn Willian.

**Verificado por:** pendiente de confirmación por el resto del equipo (firmas de `A1_Procedencia_Encuesta_SGCV-IA.md`).

### A4 — Detección de duplicados por contenido (no solo por fila completa) — CORREGIDO (20/09/2026)

**Hallazgo:** `06_Experimento/scripts_analisis/02_limpieza.R` solo detectaba filas duplicadas comparando la fila completa (`duplicated(encuesta)`), lo que no detecta respuestas idénticas en contenido pero con distinta marca temporal o ciudad (el patrón que hizo sospechoso al archivo retirado en A1/A3: 207 de 210 filas casi idénticas salvo fecha y ciudad).

**Corrección aplicada:** se agregó una segunda verificación que excluye explícitamente `Marca temporal` y la columna de ciudad antes de buscar duplicados, y reporta el conteo por separado (sin borrar filas automáticamente — requiere revisión manual, igual que el resto del script):

```r
col_ciudad <- grep("^4\\. Ciudad", names(encuesta), value = TRUE)
cols_contenido <- setdiff(names(encuesta), c("Marca temporal", col_ciudad))
filas_duplicadas_contenido <- duplicated(encuesta[, cols_contenido, drop = FALSE])
n_duplicados_contenido <- sum(filas_duplicadas_contenido)
```

Sobre el nuevo archivo de A1/A3 (210 filas verificadas), este chequeo no encuentra duplicados de contenido, consistente con la verificación de procedencia de A1.

**Fecha de esta corrección:** 20 de septiembre de 2026.

**Confirmado por:** Amagua Sacón Robyn Willian.

**Verificado por:** pendiente de confirmación por el resto del equipo.

### A5 — Cifra hardcodeada, juego de resultados duplicado/desactualizado y dependencia no declarada — CORREGIDO (20/09/2026)

**Nota de corrección (20/09/2026):** la primera versión de esta entrada solo cubría el punto (1) de abajo. Al releer el texto literal del criterio A5 se confirmó que exige tres cosas, no una; los puntos (2) y (3) se agregan ahora.

**(1) Cifra hardcodeada — Hallazgo:** `06_Experimento/scripts_analisis/08_figuras.R` tenía escrito a mano `"Distribución de participantes por perfil (n = 60)"` en el título de la figura, cifra que no se actualizaba si cambiaba el tamaño de la muestra.

**Corrección:** el título ahora se calcula desde los datos: `sprintf("Distribución de participantes por perfil (n = %d)", sum(as.integer(conteo_perfiles)))`.

**(2) Juego de resultados que contradice al otro — Hallazgo:** `06_Experimento/resultados/` tenía dos archivos huérfanos en su raíz (`curva_saturacion_codigos_abiertos.png` y `tabla_saturacion_codigos_abiertos.csv`, fuera de las subcarpetas `figuras/`/`tablas/`) que ya no genera ningún script del pipeline actual — son salida de una versión anterior de `03_curva_saturacion_codigos_abiertos.R` (con rutas previas a la reorganización), abandonada después de que el script se corrigiera para escribir en `tablas/`/`figuras/`. Además, `09_Publicacion/dataset_zenodo/03_curva_saturacion_codigos_abiertos.R` (copia empaquetada para el depósito Zenodo) seguía usando esas rutas viejas (`../resultados/...`, pensadas para ejecutarse dentro de `scripts_analisis/`), que al ejecutarse desde su ubicación real (`dataset_zenodo/`, un paquete plano) resolverían a una ruta equivocada y romperían la reproducibilidad que el propio README del paquete promete.

**Corrección:** se eliminaron los 2 archivos huérfanos de `06_Experimento/resultados/` (`git rm`). Se corrigieron las rutas de `dataset_zenodo/03_curva_saturacion_codigos_abiertos.R` para ser relativas a su propia carpeta (paquete plano y autocontenido). Se verificó ejecutándolo in situ (`cd 09_Publicacion/dataset_zenodo && Rscript 03_curva_saturacion_codigos_abiertos.R`): corre sin error y su salida es idéntica byte a byte a la tabla canónica de `06_Experimento/resultados/tablas/`. Con esto, `06_Experimento/resultados/` y `07_Datos/resultados/` quedan como un único juego de resultados consistente (verificado con `diff` archivo por archivo sobre las 6 tablas compartidas: sin diferencias).

**(3) Dependencia `car` no declarada — Hallazgo:** `05_supuestos.R` requiere el paquete `car` (Levene) y no estaba documentado en ningún README, pese a que `07_Datos/README_datos.md` afirmaba "R base, evitando dependencias externas siempre que sea posible" sin excepción.

**Corrección:** se agregó la dependencia y su instalación (CRAN o `r-cran-car` vía apt) a `07_Datos/README_datos.md`, sección 6.

**Fecha de esta corrección:** 20 de septiembre de 2026.

**Confirmado por:** Amagua Sacón Robyn Willian.

**Verificado por:** pendiente de confirmación por el resto del equipo.

### A6 — Alcance de Holm-Bonferroni y margen de error tratado como muestreo aleatorio — CORREGIDO (20/09/2026)

**Nota de corrección (20/09/2026):** la primera versión de esta entrada solo cubría el punto (1). El criterio A6 también exige el punto (2), agregado ahora.

**(1) Alcance de Holm-Bonferroni — Hallazgo:** `06_Experimento/scripts_analisis/06_pruebas_hipotesis.R` aplicaba `p.adjust(..., method = "holm")` **dentro** del bucle por pregunta, es decir, corrigiendo por familias de 6 comparaciones (una por pregunta) en vez de sobre el total de 24 comparaciones del experimento (4 preguntas × 6 pares de perfiles).

**Corrección:** se movió `p.adjust()` fuera del bucle, aplicándolo una sola vez sobre `tabla_final` (las 24 filas ya combinadas):

```r
tabla_final$valor_p_holm <- p.adjust(tabla_final$valor_p, method = "holm")
```

**Verificación:** se re-ejecutó `Rscript 07_Datos/scripts/run_all.R` de punta a punta (9/9 scripts OK) sobre el dataset de A1/A3. `pruebas_hipotesis_perfiles.csv` resultante tiene 24 filas. El valor p más bajo antes de corregir era 0.0245 (Dueño(a) de mascota vs. Médico veterinario(a), pregunta 6); tras la corrección Holm sobre las 24 comparaciones queda en 0.5885 — ninguna resulta significativa a α=0.05, coherente con el carácter exploratorio ya declarado en `07_tamano_efecto.R`/`justificacion_potencia.md`. Sin fallas en los scripts posteriores que consumen esta tabla.

**(2) Margen de error tratado como muestreo aleatorio — Hallazgo:** `07_Datos/scripts/justificacion_muestra.R` calculaba un margen de error (`e = Z·√(p(1-p)/n)`) para n=210, fórmula válida solo bajo muestreo probabilístico de una población definida. La encuesta de este proyecto se distribuyó por conveniencia (enlace compartido, sin marco muestral), así que ese cálculo daba una precisión estadística que la recolección real no respalda.

**Corrección:** se retiró por completo el cálculo de margen de error del script y de `justificacion_muestra.md` (ya no reporta ninguna cifra de margen de error ni tabla de "n mínimo requerido por margen objetivo"). En su lugar, el reporte reformulado explica por qué no aplica esa fórmula y remite al análisis de potencia real y ya existente (Cohen d=0.5, α=0.05, potencia=0.80) de `07_tamano_efecto.R` (Parte B) / `justificacion_potencia.md`, que sí es válido para un muestreo no probabilístico. Verificado regenerando el archivo con `run_all.R`: `07_Datos/resultados/justificacion_muestra.md` ya no menciona margen de error.

**Fecha de esta corrección:** 20 de septiembre de 2026.

**Confirmado por:** Amagua Sacón Robyn Willian.

**Verificado por:** pendiente de confirmación por el resto del equipo.

### A7 — Cifra de muestra (n) desactualizada o inconsistente en documentación — CORREGIDO (20/09/2026)

**Hallazgo:** dos documentos tenían cifras de muestra desactualizadas o internamente inconsistentes con los datos de A1/A3:
- `06_Experimento/README.md` declaraba "60 respuestas de cuestionario" y "ninguno [perfil] alcanza aún el mínimo n≥60", además de "1 de 10 scripts implementado" (el pipeline ya estaba completo, 9/9, según su propio `scripts_analisis/README.md`).
- `06_Experimento/scripts_analisis/README.md` ya decía "n = 210" en el texto, pero el desglose por perfil que lo acompañaba (26/18/11/5) sumaba 60, no 210 — una inconsistencia aritmética interna.

**Corrección aplicada:** ambos archivos se actualizaron con las cifras verificadas del dataset de A1/A3 (n=210; Dueño(a) de mascota 80, Administrador(a) de clínica veterinaria 45, Médico veterinario(a) 43, Auxiliar o técnico veterinario 42) y con el estado real del pipeline (9/9 scripts). `07_Datos/resultados/perfil_participantes_agregado.csv`, `README.md` raíz y `10_Autoria/retrospectiva_equipo.md` ya reportaban n=210 correctamente (el primero se regenera automáticamente con `run_all.R`) y no requirieron cambios.

**Fecha de esta corrección:** 20 de septiembre de 2026.

**Confirmado por:** Amagua Sacón Robyn Willian.

**Verificado por:** pendiente de confirmación por el resto del equipo.

### A8 — Limitaciones del instrumento no declaradas — CORREGIDO (20/09/2026)

**Nota de corrección (20/09/2026):** una primera versión de este trabajo documentó, bajo la etiqueta "A8", el cambio de redacción del formulario ("clínica veterinaria" → "veterinaria"/"centro veterinario"). Ese hallazgo es real, pero al releer el texto literal del criterio A8 se confirmó que no es lo que pide: A8 exige declarar (1) que falta el tramo de experiencia "1–2 años" y (2) que el PDF del instrumento (30/07) es posterior a la primera respuesta (27/07). El hallazgo del cambio de redacción se mantiene como `desviaciones.md`, Desviación 6 (hallazgo independiente, no cuenta como A8); lo que sí cumple A8 se documentó como Desviación 7.

**Hallazgo (verificado directamente, no por confianza en el texto del plan):**
1. Las categorías reales de la pregunta de años de experiencia en `encuesta_respuestas_crudas.csv` (210 filas) son "Menos de 1 años", "De 2 a 5 años", "De 6 a 10 años", "Más de 10 años", "No aplica" — sin tramo "1–2 años".
2. `CreationDate` de ambas copias del PDF del instrumento (`08_Etica/Encuesta_Consentimiento.pdf`, `06_Experimento/ instrumentos/Encuesta_Consentimiento_Formato_A1.pdf`) es 30/07/2026; la primera respuesta de la encuesta tiene marca temporal 27/07/2026 09:38:53 — 3 días antes.

**Corrección aplicada:** ambos hallazgos quedan declarados en `07_Datos/desviaciones.md`, Desviación 7, con la evidencia y su consecuencia sobre la interpretación de los datos de experiencia y sobre cualquier afirmación de que el instrumento antecede a la recolección.

**Fecha de esta corrección:** 20 de septiembre de 2026.

**Confirmado por:** Amagua Sacón Robyn Willian.

**Verificado por:** pendiente de confirmación por el resto del equipo.

---

## Bloque D — ERS: citas, requisitos y trazabilidad

### D6 — Amenaza de "caso único" — YA CUMPLIDO, verificado (20/09/2026)

**Criterio literal del plan:** "Corregir la amenaza de 'caso único': las fotos y las entrevistas corresponden a unas seis clínicas." Criterio de aceptación: "Número de clínicas declarado."

**Verificación realizada (no se asumió cumplido por lo que dice el plan):**
1. `01_ERS/ERS_SRS_2B_v2.0.txt`, §8.2 "Amenazas a la validez" → Validez externa, ya declara explícitamente: *"se recolectó evidencia (entrevistas y observación documental) en 6 clínicas distintas (VeterinariaColombia, VeterinariaMacay, VeterinariaPetCat, VeterinariaDrMONG, VeterinariaMediClikPet, Veterinaria911Animal), lo que reduce el riesgo de caso único aislado"*.
2. Ese texto ya estaba en el archivo subido por Barrionuevo Fuentes (commit `d17455c`, 19/09/2026 22:11) — no se agregó en esta revisión, solo se confirmó que existe y es correcto.
3. Contraste contra evidencia real: `02_Evidencias/Fotos_Entorno/` (38 fotos) muestra 6 clínicas físicamente distintas por fecha — 2026-06-30 (Colombia, Macay), 2026-07-20/21 (PetCat), 2026-07-25 (DrMONG, MediCli[i]kPet), 2026-07-27 (911Animal) — coincide con la lista de 6 del ERS.
4. Diferencia menor detectada: el ERS escribe **"VeterinariaMediClikPet"** y la carpeta de fotos usa **"VeterinariaMediCliikPet"** (doble "i"). No afecta el criterio de aceptación (que solo exige declarar el número), pero se deja anotado por si se homogeniza la nomenclatura más adelante.
5. Se revisó si esto entra en conflicto con el manuscrito (`09_Publicacion/manuscrito_final.tex`, líneas 171 y 231), que describe el estudio como "single case" (metodología Runeson & Höst): no hay conflicto — "el caso" es SGCV-IA como sistema/organización bajo estudio, no el número de sitios de recolección; un estudio de caso único puede legítimamente recolectar evidencia de campo en varias clínicas físicas. El propio §8.2 del ERS ya distingue ambas cosas.

**Conclusión:** D6 ya está cumplido en el ERS vigente; no requirió corrección. Se documenta aquí solo la verificación, para dejar constancia de que se comprobó y no se dio por hecho.

**Fecha de esta verificación:** 20 de septiembre de 2026.

**Verificado por:** Amagua Sacón Robyn Willian.

---

### D1 — Citas de participantes en el ERS: verificación literal — HALLAZGO DOCUMENTADO, ERS sin editar aún (20/09/2026)

**Criterio literal del plan:** "Toda cita de un participante en el ERS debe ser literal y localizable (participante y marca de tiempo). La frase atribuida a P02 en RC-17/RF-17, 'si tengo que dar un visto bueno antes, sí' (líneas 2664 y 11863), no aparece en ninguna transcripción. La justificación de RF-18 ('primera opción seleccionada en ambos casos') contradice lo que dicen P01 y P02." Criterio de aceptación: "Cada cita, con su ubicación exacta. Las que no se encuentren se retiran."

**Estado del hallazgo original del plan:** la frase de P02 señalada por el plan ya no está en el ERS — el equipo la reemplazó en una subida previa (commit `d17455c`, Barrionuevo Fuentes, 19/09/2026). RF-18 también fue reescrito, citando ahora a P10, P11, P14 y P15 en vez de P01/P02.

**Lo que se encontró al verificar ese reemplazo y, por extensión, todas las citas "P0X (‘…’)" del ERS (~30 instancias) contra las 16 transcripciones crudas de `07_Datos/datos_crudos/Entrevistas/` (búsqueda de substring exacto, normalizada solo en mayúsculas/tildes):**

**A. Citas con texto verbatim real, pero atribuidas al participante equivocado (evidencia: coincidencia exacta de texto en otra transcripción):**
| Cita en el ERS | Atribuida a | Texto real pertenece a |
|---|---|---|
| "la parte más demorada" (RF, sección búsqueda) | P01 y P02 | **P04** |
| "es la parte más demorada" | P02 | **P04** |
| "no sabemos qué pasó con el paciente" | P02 | **P04** |
| "facilidad de utilizarla" | P02 | **P04** |
| "en base a la edad va a agarrar el peso" | P01 | **P05** |
| "confianza moderada porque no se parecen los diagnósticos, ya todo es en la práctica, viendo al paciente, viendo en directo" (RC-17, líneas 2664/11867) | P02 | **P05** |
| "bajo valor económico" | P01 | **P05** |
| "que las recomendaciones tengan respaldo científico" (RC-18/RF-18) | P14 | **P12** |
| cita larga sobre respaldo bibliográfico y confianza (RC-18/RF-18, línea 2724) | P11 | **P15** (verbatim, líneas 15:16 y 15:39 de su transcripción) |
| cita sobre "animalitos... no puede dar diagnósticos así por así" (RC-18/RF-18, línea 2724) | P15 | **P13** (verbatim, líneas 14:59–15:28 de su transcripción) |

**B. Citas que no aparecen en ninguna de las 16 transcripciones (ni siquiera parcialmente, en ningún participante):**
- P01: "siempre se caducan por falta de precaución"
- P01: "inculcarle al dueño del perro la alimentación nutritiva adecuada"
- P01: "se le indica que hay que hacer pruebas de sangre o llevar a una clínica con todos los equipos" (RC-16)
- P02: "no está bien organizado el tema de buscar por nombre y dueño" (RC-03)
- P02: "los resultados de exámenes se lo enviamos directamente por WhatsApp"
- P02: "esperamos que lleguen; si no, no podemos saber"

**Interpretación:** las "Actas de Entrevista N.° 1 y 2" del ERS para P01 y P02 (Tabla 20 y Tabla 22, fechadas 23/05 y con entrevistador Anthony Vera Gómez) no corresponden a las transcripciones de `07_Datos/datos_crudos/Entrevistas/` fechadas 26/05/2026 para esos mismos códigos — son instancias de entrevista distintas (misma persona, fecha y contenido distintos) y la de mayo no tiene transcripción cruda en el repositorio, solo el resumen parafraseado del acta. Las citas "textuales" de P01/P02 en RF-02 a RF-07 no son verificables contra ningún archivo del repositorio.

**Alcance de esto:** afecta más citas de las que señala literalmente el criterio D1 del plan (que solo nombra 2 casos puntuales). Es un problema de trazabilidad en todo el bloque de RF tempranos basados en P01/P02, no solo en RC-17/RF-17/RF-18.

**Decisión:** por instrucción explícita de Amagua Sacón, este hallazgo se deja documentado aquí con evidencia verificable, sin editar aún `01_ERS/ERS_SRS_2B_v2.0.txt` — dado que la corrección afecta un documento compartido y el alcance real es mayor al esperado, se prefiere que el equipo lo revise antes de aplicar cambios.

**Fecha de este hallazgo:** 20 de septiembre de 2026.

**Confirmado por:** Amagua Sacón Robyn Willian.

**Verificado por:** pendiente de confirmación por el resto del equipo.

---

### D2 — Origen real de RNF-18 declarado — CORREGIDO (20/09/2026)

**Criterio literal:** "Declarar el origen real de RNF-18: se incorporó el 01/09, después de la última entrevista, y el propio ERS lo vincula a la rúbrica. Se traza a códigos reales o se marca como requisito derivado, no elicitado." Aceptación: "Origen explícito en el ERS y en la matriz."

**Corrección aplicada en `01_ERS/ERS_SRS_2B_v2.0.txt`:**
1. Sección 3.3 (definición de RNF-18): se agregó declaración explícita — incorporado 01/09/2026, después de la última entrevista (P16, 31/08/2026), por exigencia del criterio C3 de la rúbrica; clasificado como **requisito derivado (no elicitado)**; se aclara que los códigos RC-17/RC-18/RC-19 citados como "Fuente" son una correspondencia retrospectiva, no el origen del requisito.
2. Tabla B de la matriz extendida (TR-50/RNF-18): se agregó la misma nota antes de la tabla.

**Fecha:** 20 de septiembre de 2026. **Confirmado por:** Amagua Sacón Robyn Willian. **Verificado por:** pendiente de confirmación por el resto del equipo.

---

### D3 — Alcance real de la elicitación frente a explicabilidad — CORREGIDO (20/09/2026)

**Criterio literal:** guion sin preguntas de explicabilidad, sin participantes propietarios/administrativos, rondas de validación no ejecutadas; no afirmar requisitos de explicabilidad diferenciados por perfil. Aceptación: "Limitación declarada en el ERS y en desviaciones.md."

**Verificación:** confirmado contra `Guion_Entrevista_v2.0.pdf` (sin preguntas de explicabilidad; C5 es adyacente, no equivalente), campo "Rol" de las 16 transcripciones (todos veterinarios/auxiliares/estudiantes, ninguno propietario no clínico o administrativo puro), y Desviación 1 de `desviaciones.md` (rondas de validación no ejecutadas, ya documentado). El ERS no afirma requisitos de explicabilidad diferenciados por perfil — verificado, correcto, sin cambios necesarios ahí.

**Corrección aplicada:** declaración agregada en `01_ERS/ERS_SRS_2B_v2.0.txt` §8.2 (Amenazas a la validez, validez de constructo) y nueva entrada en `07_Datos/desviaciones.md` ("Declaración — Alcance real de la elicitación frente a la pregunta de investigación sobre explicabilidad").

**Fecha:** 20 de septiembre de 2026. **Confirmado por:** Amagua Sacón Robyn Willian. **Verificado por:** pendiente de confirmación por el resto del equipo.

---

### D4 — Referencias obsoletas, contradicción RNF-21, uso indebido de CA-16, recuentos de requisitos — CORREGIDO (20/09/2026)

**Criterio literal:** corregir referencias obsoletas a RNF-16 como explicabilidad (CU-06, MoSCoW), contradicción de RNF-21 ("en cualquier momento" vs "24 horas"), uso de CA-16 para RNF-18, y recuento de requisitos (28 RF/21 RNF en ERS vs 27/17 en CHANGELOG vs "25 RF formalizados"). Retirar frase "sin verificación adicional de mi parte" (§6.1.1). Aceptación: "Recuentos iguales en todos los documentos, sin referencias rotas."

**Verificado y corregido en `01_ERS/ERS_SRS_2B_v2.0.txt`:**
1. CU-06 (flujo principal) y justificación MoSCoW citaban "RNF-16" para explicabilidad — corregido a RNF-18 en ambos lugares (RNF-16 es retención/eliminación de datos, sin relación).
2. RNF-21: descripción decía "en cualquier momento antes de su aplicación clínica" mientras el criterio de aceptación fijaba "24 horas desde la emisión" — reconciliado: "antes de su aplicación clínica y dentro de un plazo máximo de 24 horas desde su emisión, lo que ocurra primero".
3. CA-16 (bibliografía, RF-18) estaba siendo citado también para RNF-18 (TR-50, 3 filas) en la matriz — CA-16 no cubre factores/indicador de confianza. Se creó **CA-31**, específico para RNF-18, y se actualizaron las 3 filas de TR-50 para citar CA-31 en vez de CA-16.
4. "25 RF formalizados" (línea señalada por el plan): ya no existe con ese texto en la versión actual — el documento ya dice consistentemente "28 RF" en las dos ocurrencias verificadas (línea ~5417 y ~10883). Verificado además el conteo real por `\subparagraph{RF-NN}`/`\paragraph{RF-01}`: 28 RF (RF-01 a RF-28) y 21 RNF (RNF-01 a RNF-21) — coincide con lo declarado.
5. `CHANGELOG.md` se quedó en "27 RF"/"17 RNF" (entrega [2A]) y nunca documentó el salto a 28 RF/21 RNF de la entrega [2B] (RF-28, RNF-18 a RNF-21) — se agregó la entrada faltante en el bloque [2B], con nota fechada explicando el faltante.
6. §6.1.1: retirada la frase "sin verificación adicional de mi parte" (primera persona singular en documento de autoría colectiva), sustituida por una declaración impersonal que mantiene el mismo contenido (no verificado contra código fuente).

**Fecha:** 20 de septiembre de 2026. **Confirmado por:** Amagua Sacón Robyn Willian. **Verificado por:** pendiente de confirmación por el resto del equipo.

---

### D5 — Matriz de trazabilidad: caso de prueba, filas sin evidencia, MU-010 — PARCIAL (20/09/2026)

**Criterio literal:** "Matriz de trazabilidad: añadir la columna de caso de prueba, completar las 35 filas sin evidencia y enlazar hacia atrás con códigos concretos, no solo con la entrevista. MU-010 está etiquetado como RNF-09 y no muestra los factores ni el indicador de confianza." Aceptación: "Ninguna fila vacía sin justificación. Enlaces verificables."

**1. MU-010 — CORREGIDO.** Verificado directamente contra `03_Modelado/Mockups/MU-010_Sugerencia_IA.png`: el encabezado rotula "RF-17 · RF-18 · RF-19 · RNF-09" (RNF-18 ausente, confirma el hallazgo del plan). El contenido muestra confianza como porcentaje por diagnóstico (no como alto/medio/bajo) y factores en prosa (no como lista explícita de ≥3). Se declaró en `01_ERS/ERS_SRS_2B_v2.0.txt` (junto a la nota de TR-50) como brecha de implementación de RNF-18 en el mockup, sin editar la imagen — corregir la imagen requeriría rehacer el mockup, que no corresponde a esta tarea de datos.

**2. Columna "caso de prueba" — NO AGREGADA, por instrucción explícita de Amagua Sacón.** Verificado: no existe ningún caso de prueba (CP-XX ni documento equivalente) en todo el repositorio. Agregar la columna implicaría inventar IDs de pruebas inexistentes, lo que viola la regla de no fabricación de datos. Queda pendiente de que el equipo defina casos de prueba reales antes de agregar esta columna.

**3. 32 filas con columna ID-EV vacía ("—") — IDENTIFICADAS, no completadas fila por fila.** Verificado contra la matriz (`Tabla B — Trazabilidad de diseño`, ~87 filas): 32 filas tienen EV vacío (el plan reporta 35; la diferencia puede deberse a duplicados en la Tabla D.2 del anexo, no verificado). Lista completa:
- TR-30 (RF-25), TR-42 (RNF-10), TR-43 (RNF-11), TR-46 (RNF-14), TR-48 (RNF-16), TR-49 (RNF-17), TR-54 (RST-04), TR-59 (RST-09), TR-60 (RST-10), TR-61 (RNF-19), TR-62 (RNF-20): requisitos no funcionales/restricciones derivados de análisis legal (C4), rubrica o arquitectura — no elicitados de entrevista. Varios ya tienen justificación textual en otras secciones del ERS (ej. RF-25 declarado "sin evidencia asociada" en "7.2 Hallazgos que modificaron decisiones previas"), pero esa justificación no está enlazada en la fila misma de la matriz.
- TR-67 a TR-87 (21 filas: RF-04, RF-16, RF-02, RF-05, RF-06, RF-28 ×4, RF-17, RF-13, RF-14, RF-09, RF-10, RF-06, RF-05, RF-08 ×2): filas adicionales que trazan el mismo RF contra distintos casos de uso (CU-02 a CU-10); varias son trazas secundarias de un RF que ya tiene evidencia en su fila principal (Tabla A), pero la fila secundaria no la repite ni la referencia.

**Motivo para no completarlas ahora:** requiere revisar, fila por fila, si cada una debe (a) enlazar la evidencia ya existente de la fila principal del mismo RF, (b) citar el análisis legal/rubrica correspondiente como origen documental, o (c) quedar marcada explícitamente como "sin evidencia — requisito derivado" con su justificación. Es un trabajo de las 32 filas que requiere criterio caso por caso y no se puede resolver de forma mecánica sin revisar cada RF/RNF contra su contexto — se deja pendiente de decisión del equipo antes de tocar la matriz compartida, siguiendo la misma instrucción que para la columna de caso de prueba.

**Fecha:** 20 de septiembre de 2026. **Confirmado por:** Amagua Sacón Robyn Willian. **Verificado por:** pendiente de confirmación por el resto del equipo.
