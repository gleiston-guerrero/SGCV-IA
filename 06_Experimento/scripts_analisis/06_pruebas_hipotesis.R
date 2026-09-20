
# ==============================================================================
# 06_Experimento/scripts_analisis/06_pruebas_hipotesis.R
# ------------------------------------------------------------------------------
# Compara los 4 perfiles de participante entre si, para cada una de las 4
# preguntas Likert, usando t de Student o Wilcoxon/Mann-Whitney U segun lo
# que haya recomendado 05_supuestos.R (decidido POR PREGUNTA, no de forma
# global: si algun perfil rechaza normalidad en esa pregunta especifica, se
# usa Wilcoxon solo para esa pregunta).
#
# Se hacen las 6 comparaciones posibles entre los 4 perfiles
# (Dueno vs Veterinario, Dueno vs Auxiliar, ... ) por cada pregunta, y se
# corrige por comparaciones multiples con Holm-Bonferroni DENTRO de cada
# pregunta (familia = las 6 comparaciones de esa pregunta).
#
# NOTA METODOLOGICA IMPORTANTE: con n=60 repartidos en 4 perfiles desiguales
# (el perfil dominante, dueno de mascota, tiene 26 de 60), estas pruebas son
# EXPLORATORIAS, no confirmatorias -- ver 07_tamano_efecto.R para el calculo
# de potencia estadistica que documenta esta limitacion formalmente.
#
# Requisitos: R base unicamente.
# Uso: Rscript 06_Experimento/scripts_analisis/06_pruebas_hipotesis.R
#      (ejecutar desde la raiz del repositorio, DESPUES de 05_supuestos.R)
# ==============================================================================

ruta_datos_procesados     <- "07_Datos/datos_procesados"
ruta_resultados           <- "06_Experimento/resultados"
ruta_salidas_estadisticas <- file.path(ruta_resultados, "salidas_estadisticas")

ruta_encuesta <- file.path(ruta_datos_procesados, "encuesta_limpia.csv")
ruta_shapiro  <- file.path(ruta_salidas_estadisticas, "supuestos_shapiro.csv")

if (!file.exists(ruta_encuesta)) {
  stop("No se encontró ", ruta_encuesta, ". Corre primero 02_limpieza.R")
}
if (!file.exists(ruta_shapiro)) {
  stop("No se encontró ", ruta_shapiro, ". Corre primero 05_supuestos.R")
}

encuesta <- read.csv(ruta_encuesta, encoding = "UTF-8", stringsAsFactors = FALSE, check.names = FALSE)
shapiro  <- read.csv(ruta_shapiro, encoding = "UTF-8", stringsAsFactors = FALSE)

col_perfil <- "1. Rol del participante (Seleccione una opción)"

# Mismo mapeo que 04_descriptivos.R y 05_supuestos.R
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

perfiles <- sort(unique(encuesta[[col_perfil]]))
pares_perfiles <- combn(perfiles, 2, simplify = FALSE)

filas_resultado <- list()

for (pregunta in names(preguntas_likert)) {
  mapeo <- preguntas_likert[[pregunta]]
  valores_numericos <- unname(mapeo[encuesta[[pregunta]]])
  grupo <- encuesta[[col_perfil]]

  # Decisión de prueba POR PREGUNTA: si algún perfil rechazó normalidad en
  # esta pregunta específica (según 05_supuestos.R), se usa Wilcoxon.
  shapiro_pregunta <- shapiro[shapiro$pregunta == pregunta, ]
  usar_no_parametrica <- any(shapiro_pregunta$valor_p < 0.05, na.rm = TRUE)
  prueba_usada <- if (usar_no_parametrica) "Wilcoxon (Mann-Whitney U)" else "t de Student"

  filas_pregunta <- lapply(pares_perfiles, function(par) {
    grupo_a <- valores_numericos[grupo == par[1]]
    grupo_b <- valores_numericos[grupo == par[2]]

    if (usar_no_parametrica) {
      resultado <- wilcox.test(grupo_a, grupo_b, exact = FALSE)
      data.frame(
        pregunta = pregunta, perfil_a = par[1], perfil_b = par[2],
        prueba = prueba_usada, n_a = length(grupo_a), n_b = length(grupo_b),
        estadistico = round(unname(resultado$statistic), 4),
        gl = NA,
        valor_p = resultado$p.value
      )
    } else {
      resultado <- t.test(grupo_a, grupo_b)
      data.frame(
        pregunta = pregunta, perfil_a = par[1], perfil_b = par[2],
        prueba = prueba_usada, n_a = length(grupo_a), n_b = length(grupo_b),
        estadistico = round(unname(resultado$statistic), 4),
        gl = round(unname(resultado$parameter), 2),
        valor_p = resultado$p.value
      )
    }
  })

  tabla_pregunta <- do.call(rbind, filas_pregunta)
  filas_resultado[[pregunta]] <- tabla_pregunta
}

tabla_final <- do.call(rbind, filas_resultado)
rownames(tabla_final) <- NULL

# Corrección Holm-Bonferroni sobre TODAS las comparaciones del experimento
# juntas (4 preguntas x 6 pares de perfiles = 24 comparaciones), no una
# familia de 6 por pregunta por separado -- así lo exige el criterio de
# aceptación de la tarea A6 del plan de mejora de datos: aplicar la
# corrección sobre "todas las comparaciones (24), no dentro de cada ítem".
tabla_final$valor_p_holm <- p.adjust(tabla_final$valor_p, method = "holm")
tabla_final$valor_p <- round(tabla_final$valor_p, 4)
tabla_final$valor_p_holm <- round(tabla_final$valor_p_holm, 4)
tabla_final$significativo_holm_0.05 <- tabla_final$valor_p_holm < 0.05

cat("== Pruebas de hipótesis: comparación entre perfiles, por pregunta (con corrección Holm-Bonferroni sobre las 24 comparaciones) ==\n")
print(tabla_final, row.names = FALSE)

n_significativas <- sum(tabla_final$significativo_holm_0.05)
cat(sprintf(
  "\n%d de %d comparaciones resultaron significativas después de la corrección Holm-Bonferroni sobre el total de comparaciones (α = 0.05).\n",
  n_significativas, nrow(tabla_final)
))
cat("Recordatorio: resultado EXPLORATORIO, no confirmatorio -- ver 07_tamano_efecto.R (cálculo de potencia).\n")

if (!dir.exists(ruta_salidas_estadisticas)) dir.create(ruta_salidas_estadisticas, recursive = TRUE)
write.csv(
  tabla_final,
  file.path(ruta_salidas_estadisticas, "pruebas_hipotesis_perfiles.csv"),
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("\nGuardado en", file.path(ruta_salidas_estadisticas, "pruebas_hipotesis_perfiles.csv"), "\n")
