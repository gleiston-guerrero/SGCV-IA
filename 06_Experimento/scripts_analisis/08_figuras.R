# ==============================================================================
# 06_Experimento/scripts_analisis/08_figuras.R
# ------------------------------------------------------------------------------
# Genera todas las figuras del componente cuantitativo del informe a partir
# de los datos y resultados ya calculados por los scripts anteriores.
# Ningun numero ni forma de estas figuras se dibuja a mano: todo sale de
# encuesta_limpia.csv (02) y tamano_efecto.csv (07).
#
# Figuras generadas (en 09_Publicacion/figuras/):
#   - fig_distribucion_perfiles.png   : cuantos participantes hay por perfil
#   - fig_boxplot_pregunta_1.png .. _6.png : distribucion de respuestas Likert
#     por perfil, una figura por pregunta (4 preguntas)
#   - fig_tamano_efecto_delta_cliff.png : panel 2x2 con delta de Cliff + IC95%
#     por comparacion entre perfiles, una pregunta por panel
#
# Requisitos: R base unicamente.
# Uso: Rscript 06_Experimento/scripts_analisis/08_figuras.R
#      (ejecutar desde la raiz del repositorio, DESPUES de 07_tamano_efecto.R)
# ==============================================================================

ruta_datos_procesados     <- "07_Datos/datos_procesados"
ruta_resultados           <- "06_Experimento/resultados"
ruta_salidas_estadisticas <- file.path(ruta_resultados, "salidas_estadisticas")
ruta_figuras              <- "09_Publicacion/figuras"

ruta_encuesta      <- file.path(ruta_datos_procesados, "encuesta_limpia.csv")
ruta_tamano_efecto <- file.path(ruta_salidas_estadisticas, "tamano_efecto.csv")

if (!file.exists(ruta_encuesta)) stop("No se encontró ", ruta_encuesta, ". Corre primero 02_limpieza.R")
if (!file.exists(ruta_tamano_efecto)) stop("No se encontró ", ruta_tamano_efecto, ". Corre primero 07_tamano_efecto.R")

if (!dir.exists(ruta_figuras)) dir.create(ruta_figuras, recursive = TRUE)

encuesta      <- read.csv(ruta_encuesta, encoding = "UTF-8", stringsAsFactors = FALSE, check.names = FALSE)
tamano_efecto <- read.csv(ruta_tamano_efecto, encoding = "UTF-8", stringsAsFactors = FALSE)

col_perfil <- "1. Rol del participante (Seleccione una opción)"

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

# Resolución por PREFIJO (no texto exacto completo): el formulario cambió de
# redacción en algún punto de la recolección ("clínica veterinaria" ->
# "veterinaria" / "centro veterinario", ver 07_Datos/desviaciones.md).
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
      "No se encontró (o se encontró más de una vez) una columna que empiece con '%s' en encuesta_limpia.csv.",
      prefijo
    ))
  }
  nombres_resueltos <- c(nombres_resueltos, encontrada)
}
names(preguntas_likert) <- nombres_resueltos

etiquetas_cortas <- c("1. Organización actual", "3. Importancia del sistema", "5. Utilidad de recordatorios", "6. Acuerdo con IA")

perfiles <- sort(unique(encuesta[[col_perfil]]))
# Nombres cortos para que no se amontonen en los ejes de las figuras
perfiles_cortos <- c(
  "Administrador(a) de clínica veterinaria" = "Administrador(a)",
  "Auxiliar o técnico veterinario"          = "Auxiliar/técnico",
  "Dueño(a) de mascota"                     = "Dueño(a) mascota",
  "Médico veterinario(a)"                   = "Veterinario(a)"
)

# ------------------------------------------------------------------------------
# Figura 1: distribución de participantes por perfil
# ------------------------------------------------------------------------------
conteo_perfiles <- table(encuesta[[col_perfil]])
nombres_cortos_orden <- perfiles_cortos[names(conteo_perfiles)]

png(file.path(ruta_figuras, "fig_distribucion_perfiles.png"), width = 1400, height = 900, res = 150)
par(mar = c(7, 5, 4, 2))
bp <- barplot(
  as.integer(conteo_perfiles),
  names.arg = nombres_cortos_orden,
  col = "#4472C4", border = NA,
  ylab = "Número de participantes",
  main = sprintf("Distribución de participantes por perfil (n = %d)", sum(as.integer(conteo_perfiles))),
  las = 2
)
text(bp, as.integer(conteo_perfiles) + 1.2, labels = as.integer(conteo_perfiles))
dev.off()
cat("Guardada: fig_distribucion_perfiles.png\n")

# ------------------------------------------------------------------------------
# Figuras 2-5: boxplot de cada pregunta Likert, por perfil
# ------------------------------------------------------------------------------
i <- 0
for (pregunta in names(preguntas_likert)) {
  i <- i + 1
  mapeo <- preguntas_likert[[pregunta]]
  valores_numericos <- unname(mapeo[encuesta[[pregunta]]])
  grupo <- factor(perfiles_cortos[encuesta[[col_perfil]]], levels = unname(perfiles_cortos[perfiles]))

  nombre_archivo <- sprintf("fig_boxplot_pregunta_%d.png", i)
  png(file.path(ruta_figuras, nombre_archivo), width = 1400, height = 900, res = 150)
  par(mar = c(7, 5, 4, 2))
  boxplot(
    valores_numericos ~ grupo,
    col = "#4472C4", border = "#2E4E8C",
    ylim = c(1, 5),
    ylab = "Puntaje (escala 1-5)",
    xlab = "",
    main = paste0("Distribución por perfil\n", etiquetas_cortas[i]),
    las = 2
  )
  dev.off()
  cat("Guardada:", nombre_archivo, "\n")
}

# ------------------------------------------------------------------------------
# Figura 6: panel 2x2 con delta de Cliff + IC95% por comparación, una
# pregunta por panel (forest plot horizontal)
# ------------------------------------------------------------------------------
png(file.path(ruta_figuras, "fig_tamano_efecto_delta_cliff.png"), width = 1800, height = 1400, res = 150)
par(mfrow = c(2, 2), mar = c(4, 12, 3, 2))

for (i in seq_along(names(preguntas_likert))) {
  pregunta <- names(preguntas_likert)[i]
  datos_pregunta <- tamano_efecto[tamano_efecto$pregunta == pregunta, ]
  etiquetas_comparacion <- paste(
    perfiles_cortos[datos_pregunta$perfil_a], "vs.", perfiles_cortos[datos_pregunta$perfil_b]
  )

  plot(
    datos_pregunta$delta_cliff, seq_len(nrow(datos_pregunta)),
    xlim = c(-1, 1), pch = 19, col = "#C00000",
    yaxt = "n", ylab = "", xlab = "Delta de Cliff",
    main = etiquetas_cortas[i]
  )
  axis(2, at = seq_len(nrow(datos_pregunta)), labels = etiquetas_comparacion, las = 2, cex.axis = 0.7)
  segments(
    datos_pregunta$delta_cliff_ic95_inf, seq_len(nrow(datos_pregunta)),
    datos_pregunta$delta_cliff_ic95_sup, seq_len(nrow(datos_pregunta)),
    col = "#C00000"
  )
  abline(v = 0, lty = 2, col = "grey50")
}

dev.off()
cat("Guardada: fig_tamano_efecto_delta_cliff.png\n")

cat("\nListo. 6 figuras generadas en", ruta_figuras, "\n")
