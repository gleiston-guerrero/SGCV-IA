
# ==============================================================================
# 06_Experimento/scripts_analisis/02_limpieza.R
# ------------------------------------------------------------------------------
# Limpieza basica de los datos importados por 01_importar_datos.R:
#   - Deteccion de filas duplicadas en la encuesta
#   - Deteccion de valores faltantes por columna (encuesta)
#   - Deteccion de transcripciones duplicadas o anormalmente cortas
#
# Este script NO elimina nada por sospecha: solo elimina duplicados EXACTOS
# verificados, y documenta todo lo demas (valores faltantes, transcripciones
# cortas, etc.) en un reporte, para que una persona decida que hacer con
# cada caso -- nunca se descarta un dato real solo porque "se ve raro".
#
# Requisitos: R base unicamente.
# Uso: Rscript 06_Experimento/scripts_analisis/02_limpieza.R
#      (ejecutar desde la raiz del repositorio, DESPUES de 01_importar_datos.R)
# ==============================================================================

ruta_datos_procesados <- "07_Datos/datos_procesados"

ruta_encuesta        <- file.path(ruta_datos_procesados, "encuesta_procesada.csv")
ruta_transcripciones <- file.path(ruta_datos_procesados, "transcripciones_completas.rds")

if (!file.exists(ruta_encuesta) || !file.exists(ruta_transcripciones)) {
  stop(
    "No se encontraron los datos de ", ruta_datos_procesados, ".\n",
    "Corre primero: Rscript 06_Experimento/scripts_analisis/01_importar_datos.R"
  )
}

encuesta <- read.csv(ruta_encuesta, encoding = "UTF-8", stringsAsFactors = FALSE, check.names = FALSE)
transcripciones <- readRDS(ruta_transcripciones)

lineas_reporte <- c("# Reporte de limpieza de datos", "", sprintf("Generado: %s", format(Sys.time(), "%Y-%m-%d %H:%M:%S")), "")

# ------------------------------------------------------------------------------
# 1. Duplicados en la encuesta
# ------------------------------------------------------------------------------
# a) Filas 100% idénticas en todas las columnas -- estos sí se consideran
#    duplicados reales (misma persona registrada dos veces con la misma
#    respuesta exacta) y se eliminan, quedándose con la primera aparición.
filas_duplicadas_exactas <- duplicated(encuesta)
n_duplicados_exactos <- sum(filas_duplicadas_exactas)

if (n_duplicados_exactos > 0) {
  encuesta <- encuesta[!filas_duplicadas_exactas, ]
}

# b) Marca temporal duplicada (dos respuestas con el mismo timestamp exacto
#    de envío) -- se documenta como alerta, pero NO se elimina automáticamente,
#    porque podría ser una coincidencia real o un reenvío legítimo; requiere
#    revisión humana.
duplicados_marca_temporal <- sum(duplicated(encuesta[["Marca temporal"]]))

# c) Duplicados de CONTENIDO: dos filas cuyas respuestas coinciden en todas
#    las columnas EXCEPTO "Marca temporal" y "4. Ciudad" -- estas dos son las
#    únicas columnas que varían de forma casi automática entre respuestas
#    (fecha/hora de envío y la ciudad que la persona escribe), así que una
#    fila que coincide en todo lo demás (rol, edad, sexo, y las 10 preguntas
#    de la encuesta, incluidas las de texto libre) es indistinguible de una
#    copia de otra, aunque la marca temporal y la ciudad difieran. Igual que
#    en (b), esto NO se elimina automáticamente: se cuenta y se documenta
#    para revisión humana (tarea A4 del plan de mejora de datos).
col_ciudad <- grep("^4\\. Ciudad", names(encuesta), value = TRUE)
cols_contenido <- setdiff(names(encuesta), c("Marca temporal", col_ciudad))
filas_duplicadas_contenido <- duplicated(encuesta[, cols_contenido, drop = FALSE])
n_duplicados_contenido <- sum(filas_duplicadas_contenido)

lineas_reporte <- c(
  lineas_reporte,
  "## Duplicados en la encuesta",
  "",
  sprintf("- Filas 100%% idénticas encontradas y eliminadas: %d", n_duplicados_exactos),
  sprintf("- Filas con \"Marca temporal\" duplicada (NO eliminadas, requieren revisión manual): %d", duplicados_marca_temporal),
  sprintf(
    "- Filas duplicadas por CONTENIDO, excluyendo \"Marca temporal\" y \"%s\" (NO eliminadas, requieren revisión manual): %d",
    if (length(col_ciudad) == 1) col_ciudad else "4. Ciudad",
    n_duplicados_contenido
  ),
  ""
)

# ------------------------------------------------------------------------------
# 2. Valores faltantes por columna en la encuesta
# ------------------------------------------------------------------------------
es_faltante <- function(x) is.na(x) | trimws(as.character(x)) == ""

conteo_faltantes <- sapply(encuesta, function(col) sum(es_faltante(col)))
tabla_faltantes <- data.frame(
  columna = names(conteo_faltantes),
  valores_faltantes = as.integer(conteo_faltantes),
  porcentaje = round(100 * as.integer(conteo_faltantes) / nrow(encuesta), 1)
)
tabla_faltantes <- tabla_faltantes[tabla_faltantes$valores_faltantes > 0, ]
tabla_faltantes <- tabla_faltantes[order(-tabla_faltantes$valores_faltantes), ]

lineas_reporte <- c(
  lineas_reporte,
  "## Valores faltantes por columna (encuesta)",
  ""
)
if (nrow(tabla_faltantes) == 0) {
  lineas_reporte <- c(lineas_reporte, "Ninguna columna tiene valores faltantes.", "")
} else {
  lineas_reporte <- c(
    lineas_reporte,
    "| Columna | Valores faltantes | % |",
    "|---|---|---|",
    sprintf("| %s | %d | %.1f%% |", tabla_faltantes$columna, tabla_faltantes$valores_faltantes, tabla_faltantes$porcentaje),
    ""
  )
}

# ------------------------------------------------------------------------------
# 3. Transcripciones: duplicados de id_participante y transcripciones
#    anormalmente cortas (posible archivo truncado o corrupto)
# ------------------------------------------------------------------------------
ids_duplicados <- transcripciones$id_participante[duplicated(transcripciones$id_participante)]

# Umbral de longitud mínima esperada: la transcripción más corta observada en
# el conjunto histórico ronda las 850 palabras. Por debajo de 300 palabras se
# marca como sospechosamente corta para revisión manual (no se elimina sola).
UMBRAL_PALABRAS_MINIMO <- 300
transcripciones_cortas <- transcripciones[
  !is.na(transcripciones$n_palabras_transcripcion) &
  transcripciones$n_palabras_transcripcion < UMBRAL_PALABRAS_MINIMO,
]

lineas_reporte <- c(
  lineas_reporte,
  "## Transcripciones",
  "",
  sprintf("- IDs de participante duplicados: %s", if (length(ids_duplicados) == 0) "ninguno" else paste(ids_duplicados, collapse = ", ")),
  sprintf(
    "- Transcripciones con menos de %d palabras (revisar manualmente, no se descartan solas): %s",
    UMBRAL_PALABRAS_MINIMO,
    if (nrow(transcripciones_cortas) == 0) "ninguna" else paste(transcripciones_cortas$id_participante, collapse = ", ")
  ),
  ""
)

cat(paste(lineas_reporte, collapse = "\n"))
cat("\n")

# ------------------------------------------------------------------------------
# 4. Guardar datos limpios + reporte
# ------------------------------------------------------------------------------
write.csv(
  encuesta,
  file.path(ruta_datos_procesados, "encuesta_limpia.csv"),
  row.names = FALSE,
  fileEncoding = "UTF-8"
)
saveRDS(transcripciones, file.path(ruta_datos_procesados, "transcripciones_limpias.rds"))
writeLines(lineas_reporte, file.path(ruta_datos_procesados, "reporte_limpieza.md"), useBytes = TRUE)

cat("\nListo. Archivos generados en", ruta_datos_procesados, ":\n")
cat(" - encuesta_limpia.csv\n")
cat(" - transcripciones_limpias.rds\n")
cat(" - reporte_limpieza.md\n")
