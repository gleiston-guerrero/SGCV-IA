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
