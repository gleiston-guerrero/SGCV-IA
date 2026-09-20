
# ==============================================================================
# 06_Experimento/scripts_analisis/04_descriptivos.R
# ------------------------------------------------------------------------------
# Estadisticos descriptivos (media, mediana, DE, minimo, maximo, IQR) de las
# preguntas tipo Likert de la encuesta, desagregados por perfil de
# participante (Dueno de mascota / Medico veterinario(a) / Auxiliar o
# tecnico veterinario / Administrador(a) de clinica veterinaria).
#
# Las preguntas Likert de la encuesta son categoricas ordinales en texto
# (ej. "Totalmente en desacuerdo" ... "Totalmente de acuerdo"). Este script
# las convierte a escala numerica 1-5 SOLO para el calculo estadistico,
# documentando explicitamente el mapeo usado -- nunca se inventa un numero
# sin dejar constancia de que categoria de texto representa.
#
# Requisitos: R base unicamente.
# Uso: Rscript 06_Experimento/scripts_analisis/04_descriptivos.R
#      (ejecutar desde la raiz del repositorio, DESPUES de 02_limpieza.R)
# ==============================================================================

ruta_datos_procesados <- "07_Datos/datos_procesados"
ruta_resultados       <- "06_Experimento/resultados"
ruta_tablas           <- file.path(ruta_resultados, "tablas")

ruta_encuesta <- file.path(ruta_datos_procesados, "encuesta_limpia.csv")

if (!file.exists(ruta_encuesta)) {
  stop(
    "No se encontro ", ruta_encuesta, ".\n",
    "Corre primero: Rscript 06_Experimento/scripts_analisis/02_limpieza.R"
  )
}

if (!dir.exists(ruta_tablas)) dir.create(ruta_tablas, recursive = TRUE)

encuesta <- read.csv(ruta_encuesta, encoding = "UTF-8", stringsAsFactors = FALSE, check.names = FALSE)

col_perfil <- "1. Rol del participante (Seleccione una opción)"

# ------------------------------------------------------------------------------
# Mapeo de las preguntas Likert de la encuesta a escala numérica 1-5.
# Cada mapeo se documenta explícitamente: la dirección (1 = negativo/bajo,
# 5 = positivo/alto) se mantiene consistente entre preguntas.
# ------------------------------------------------------------------------------
preguntas_likert <- list(
  "1. ¿Cómo califica la organización y gestión de la información en las clínicas veterinarias que conoce o utiliza?" = c(
    "Muy mala" = 1, "Mala" = 2, "Regular" = 3, "Buena" = 4, "Muy buena" = 5
  ),
  "3. ¿Qué tan importante considera el uso de un sistema informático para mejorar la atención y gestión de una clínica veterinaria?" = c(
    "Nada importante" = 1, "Poco importante" = 2, "Neutral" = 3, "Importante" = 4, "Muy importante" = 5
  ),
  "5. ¿Qué tan útil considera recibir recordatorios de citas, vacunas, tratamientos o controles veterinarios mediante un sistema digital?" = c(
    "Nada útil" = 1, "Poco útil" = 2, "Neutral" = 3, "Útil" = 4, "Muy útil" = 5
  ),
  "6. ¿Qué tan de acuerdo está con el uso de Inteligencia Artificial como apoyo para mejorar la gestión y atención en las clínicas veterinarias?" = c(
    "Totalmente en desacuerdo" = 1, "En desacuerdo" = 2, "Neutral" = 3, "De acuerdo" = 4, "Totalmente de acuerdo" = 5
  )
)

# Resolución por PREFIJO, no por texto exacto completo: el formulario de
# Google Forms cambió de redacción en algún punto de la recolección
# ("clínica veterinaria" -> "veterinaria" / "centro veterinario", ver
# 07_Datos/desviaciones.md). Se toma el número de pregunta + las primeras
# palabras (la parte que no cambió) como prefijo de búsqueda, y se avisa
# explícitamente si no hay exactamente una columna que calce -- en vez de
# fallar en silencio calculando estadísticos de una columna vacía.
prefijos_busqueda <- c(
  "1. ¿Cómo califica la organización y gestión de la información en",
  "3. ¿Qué tan importante considera el uso de un sistema informático para mejorar",
  "5. ¿Qué tan útil considera recibir recordatorios de citas, vacunas, tratamientos o controles veterinarios",
  "6. ¿Qué tan de acuerdo está con el uso de Inteligencia Artificial como apoyo para mejorar"
)
nombres_resueltos <- character(0)
for (prefijo in prefijos_busqueda) {
  encontrada <- grep(prefijo, names(encuesta), value = TRUE, fixed = TRUE)
  if (length(encontrada) != 1) {
    stop(sprintf(
      "No se encontró (o se encontró más de una vez) una columna que empiece con '%s' en encuesta_limpia.csv. Columnas disponibles: %s",
      prefijo, paste(names(encuesta), collapse = " | ")
    ))
  }
  nombres_resueltos <- c(nombres_resueltos, encontrada)
}
names(preguntas_likert) <- nombres_resueltos

calcular_descriptivos <- function(valores_numericos) {
  valores_numericos <- valores_numericos[!is.na(valores_numericos)]
  if (length(valores_numericos) == 0) {
    return(data.frame(n = 0, media = NA, mediana = NA, de = NA, minimo = NA, maximo = NA, iqr = NA))
  }
  data.frame(
    n       = length(valores_numericos),
    media   = round(mean(valores_numericos), 2),
    mediana = median(valores_numericos),
    de      = round(sd(valores_numericos), 2),
    minimo  = min(valores_numericos),
    maximo  = max(valores_numericos),
    iqr     = IQR(valores_numericos)
  )
}

resultados_todos <- list()

for (pregunta in names(preguntas_likert)) {
  mapeo <- preguntas_likert[[pregunta]]
  valores_texto <- encuesta[[pregunta]]

  valores_no_mapeados <- setdiff(unique(valores_texto[valores_texto != ""]), names(mapeo))
  if (length(valores_no_mapeados) > 0) {
    stop(
      "La pregunta '", pregunta, "' tiene respuestas que no están en el mapeo: ",
      paste(valores_no_mapeados, collapse = ", "),
      ". Actualiza `preguntas_likert` en este script."
    )
  }

  valores_numericos <- unname(mapeo[valores_texto])

  # Global (todos los perfiles)
  fila_global <- cbind(pregunta = pregunta, perfil = "Todos los perfiles", calcular_descriptivos(valores_numericos))

  # Por perfil
  filas_por_perfil <- do.call(rbind, lapply(sort(unique(encuesta[[col_perfil]])), function(perfil) {
    idx <- encuesta[[col_perfil]] == perfil
    cbind(pregunta = pregunta, perfil = perfil, calcular_descriptivos(valores_numericos[idx]))
  }))

  resultados_todos[[pregunta]] <- rbind(fila_global, filas_por_perfil)
}

tabla_final <- do.call(rbind, resultados_todos)
rownames(tabla_final) <- NULL

cat("== Estadísticos descriptivos por pregunta y perfil (escala 1-5) ==\n")
print(tabla_final, row.names = FALSE)

write.csv(
  tabla_final,
  file.path(ruta_tablas, "descriptivos_likert.csv"),
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("\nGuardado en", file.path(ruta_tablas, "descriptivos_likert.csv"), "\n")
