
# ==============================================================================
# 06_Experimento/scripts_analisis/05_supuestos.R
# ------------------------------------------------------------------------------
# Verifica los supuestos estadisticos necesarios para decidir que prueba usar
# en 06_pruebas_hipotesis.R:
#   - Normalidad por grupo: Shapiro-Wilk
#   - Homogeneidad de varianzas entre grupos: Levene (con mediana, mas robusto
#     que la version con media)
#
# Se aplica sobre las mismas 4 preguntas Likert de 04_descriptivos.R,
# comparando los 4 perfiles de participante.
#
# IMPORTANTE: Shapiro-Wilk sobre datos Likert (escala ordinal 1-5, con pocos
# valores posibles y muchos empates) casi siempre rechaza normalidad -- esto
# es normal y esperado, no un error del script. El resultado de este script
# es justamente el que le dice a 06_pruebas_hipotesis.R si debe usar pruebas
# parametricas o no parametricas; no se asume de antemano.
#
# Requisitos:
#   - R base para Shapiro-Wilk (shapiro.test ya viene incluido)
#   - Paquete 'car' para el test de Levene (car::leveneTest). Si no esta
#     instalado, correr una vez: install.packages("car")
#
# Uso: Rscript 06_Experimento/scripts_analisis/05_supuestos.R
#      (ejecutar desde la raiz del repositorio, DESPUES de 04_descriptivos.R)
# ==============================================================================

ruta_datos_procesados     <- "07_Datos/datos_procesados"
ruta_resultados           <- "06_Experimento/resultados"
ruta_salidas_estadisticas <- file.path(ruta_resultados, "salidas_estadisticas")

ruta_encuesta <- file.path(ruta_datos_procesados, "encuesta_limpia.csv")

if (!file.exists(ruta_encuesta)) {
  stop(
    "No se encontro ", ruta_encuesta, ".\n",
    "Corre primero: Rscript 06_Experimento/scripts_analisis/02_limpieza.R"
  )
}

if (!requireNamespace("car", quietly = TRUE)) {
  stop("Falta el paquete 'car' para el test de Levene. Instálalo con: install.packages(\"car\")")
}

if (!dir.exists(ruta_salidas_estadisticas)) dir.create(ruta_salidas_estadisticas, recursive = TRUE)

encuesta <- read.csv(ruta_encuesta, encoding = "UTF-8", stringsAsFactors = FALSE, check.names = FALSE)

col_perfil <- "1. Rol del participante (Seleccione una opción)"

# Mismo mapeo que 04_descriptivos.R -- si cambia ahí, debe cambiar aquí también.
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

resultados <- list()

for (pregunta in names(preguntas_likert)) {
  mapeo <- preguntas_likert[[pregunta]]
  valores_numericos <- unname(mapeo[encuesta[[pregunta]]])
  grupo <- factor(encuesta[[col_perfil]])

  # --- Shapiro-Wilk por grupo (requiere entre 3 y 5000 observaciones por grupo) ---
  filas_shapiro <- do.call(rbind, lapply(levels(grupo), function(perfil) {
    valores_grupo <- valores_numericos[grupo == perfil]
    if (length(valores_grupo) < 3) {
      return(data.frame(
        pregunta = pregunta, perfil = perfil, n = length(valores_grupo),
        estadistico_W = NA, valor_p = NA,
        nota = "n < 3, no se puede calcular Shapiro-Wilk"
      ))
    }
    resultado <- shapiro.test(valores_grupo)
    data.frame(
      pregunta = pregunta, perfil = perfil, n = length(valores_grupo),
      estadistico_W = round(unname(resultado$statistic), 4),
      valor_p = round(resultado$p.value, 4),
      nota = ifelse(resultado$p.value < 0.05, "rechaza normalidad (p < 0.05)", "no rechaza normalidad")
    )
  }))

  # --- Levene (homogeneidad de varianzas ENTRE los 4 grupos, con mediana) ---
  resultado_levene <- car::leveneTest(valores_numericos, grupo, center = median)
  fila_levene <- data.frame(
    pregunta = pregunta,
    gl1 = resultado_levene$Df[1],
    gl2 = resultado_levene$Df[2],
    estadistico_F = round(resultado_levene$`F value`[1], 4),
    valor_p = round(resultado_levene$`Pr(>F)`[1], 4),
    nota = ifelse(resultado_levene$`Pr(>F)`[1] < 0.05, "rechaza homogeneidad (p < 0.05)", "no rechaza homogeneidad")
  )

  resultados[[pregunta]] <- list(shapiro = filas_shapiro, levene = fila_levene)
}

tabla_shapiro <- do.call(rbind, lapply(resultados, function(x) x$shapiro))
tabla_levene  <- do.call(rbind, lapply(resultados, function(x) x$levene))
rownames(tabla_shapiro) <- NULL
rownames(tabla_levene) <- NULL

cat("== Shapiro-Wilk (normalidad por perfil) ==\n")
print(tabla_shapiro, row.names = FALSE)
cat("\n== Levene (homogeneidad de varianzas entre los 4 perfiles) ==\n")
print(tabla_levene, row.names = FALSE)

# ------------------------------------------------------------------------------
# Recomendación automática de qué tipo de prueba usar en 06_pruebas_hipotesis.R
# ------------------------------------------------------------------------------
alguna_no_normal <- any(tabla_shapiro$valor_p < 0.05, na.rm = TRUE)
recomendacion <- if (alguna_no_normal) {
  "No paramétrica (Wilcoxon / Mann-Whitney U) -- al menos un grupo rechaza normalidad en al menos una pregunta"
} else {
  "Paramétrica (t) puede considerarse -- ningún grupo rechaza normalidad, pero revisar homogeneidad de varianzas también"
}
cat("\nRecomendación para 06_pruebas_hipotesis.R:", recomendacion, "\n")

# ------------------------------------------------------------------------------
# Guardar
# ------------------------------------------------------------------------------
write.csv(tabla_shapiro, file.path(ruta_salidas_estadisticas, "supuestos_shapiro.csv"), row.names = FALSE, fileEncoding = "UTF-8")
write.csv(tabla_levene, file.path(ruta_salidas_estadisticas, "supuestos_levene.csv"), row.names = FALSE, fileEncoding = "UTF-8")
writeLines(
  c("# Recomendación de prueba estadística (basada en supuestos)", "", recomendacion),
  file.path(ruta_salidas_estadisticas, "recomendacion_prueba.md")
)

cat("\nGuardado en", ruta_salidas_estadisticas, ": supuestos_shapiro.csv, supuestos_levene.csv, recomendacion_prueba.md\n")
