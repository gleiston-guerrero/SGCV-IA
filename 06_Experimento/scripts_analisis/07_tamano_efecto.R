
# ==============================================================================
# 06_Experimento/scripts_analisis/07_tamano_efecto.R
# ------------------------------------------------------------------------------
# Dos cosas, ambas exigidas por la guia/rubrica y por el README de esta
# carpeta:
#
# PARTE A) Tamano del efecto (d de Cohen y delta de Cliff, con intervalo de
#           confianza por bootstrap de 10.000 replicas) para cada
#           comparacion entre perfiles, en cada pregunta Likert. Delta de
#           Cliff es la medida principal (apropiada para datos ordinales no
#           normales, consistente con la decision no parametrica de
#           05_supuestos.R); d de Cohen se reporta como referencia adicional.
#
# PARTE B) Calculo de potencia estadistica / tamano de muestra requerido,
#           para resolver formalmente la nota de "Dependencia" del README de
#           esta carpeta: la guia exige n >= 60 POR PERFIL DOMINANTE, o una
#           justificacion explicita con calculo de potencia (d=0.5, alfa=0.05,
#           potencia=0.80). Este script hace ese calculo con los datos reales
#           que ya existen (no requiere participantes nuevos).
#
# Requisitos: R base unicamente (usa stats::power.t.test, incluida en
# cualquier instalacion de R -- no requiere instalar ningun paquete).
#
# Uso: Rscript 06_Experimento/scripts_analisis/07_tamano_efecto.R
#      (ejecutar desde la raiz del repositorio, DESPUES de 06_pruebas_hipotesis.R)
# ==============================================================================

set.seed(2026)  # reproducibilidad del bootstrap

ruta_datos_procesados     <- "07_Datos/datos_procesados"
ruta_resultados           <- "06_Experimento/resultados"
ruta_salidas_estadisticas <- file.path(ruta_resultados, "salidas_estadisticas")

ruta_encuesta <- file.path(ruta_datos_procesados, "encuesta_limpia.csv")

if (!file.exists(ruta_encuesta)) {
  stop("No se encontró ", ruta_encuesta, ". Corre primero 02_limpieza.R")
}
if (!dir.exists(ruta_salidas_estadisticas)) dir.create(ruta_salidas_estadisticas, recursive = TRUE)

encuesta <- read.csv(ruta_encuesta, encoding = "UTF-8", stringsAsFactors = FALSE, check.names = FALSE)
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

perfiles <- sort(unique(encuesta[[col_perfil]]))
pares_perfiles <- combn(perfiles, 2, simplify = FALSE)
N_BOOTSTRAP <- 10000

# ------------------------------------------------------------------------------
# Funciones de tamaño del efecto
# ------------------------------------------------------------------------------
cliff_delta <- function(x, y) {
  # delta de Cliff = (2U / (n1*n2)) - 1, donde U es el estadístico de Mann-Whitney
  n1 <- length(x); n2 <- length(y)
  u <- suppressWarnings(wilcox.test(x, y, exact = FALSE)$statistic)
  (2 * u / (n1 * n2)) - 1
}

cohen_d <- function(x, y) {
  n1 <- length(x); n2 <- length(y)
  sd_pooled <- sqrt(((n1 - 1) * var(x) + (n2 - 1) * var(y)) / (n1 + n2 - 2))
  (mean(x) - mean(y)) / sd_pooled
}

bootstrap_ic <- function(x, y, funcion_estadistico, n_boot = N_BOOTSTRAP) {
  valores <- numeric(n_boot)
  for (i in seq_len(n_boot)) {
    x_boot <- sample(x, length(x), replace = TRUE)
    y_boot <- sample(y, length(y), replace = TRUE)
    valores[i] <- funcion_estadistico(x_boot, y_boot)
  }
  quantile(valores, c(0.025, 0.975), na.rm = TRUE)
}

# ------------------------------------------------------------------------------
# PARTE A: tamaño del efecto por comparación y pregunta
# ------------------------------------------------------------------------------
cat("== Parte A: tamaño del efecto (delta de Cliff y d de Cohen, IC 95% bootstrap) ==\n")
cat(sprintf("(%d réplicas bootstrap por comparación; puede tardar unos segundos)\n\n", N_BOOTSTRAP))

filas_efecto <- list()

for (pregunta in names(preguntas_likert)) {
  mapeo <- preguntas_likert[[pregunta]]
  valores_numericos <- unname(mapeo[encuesta[[pregunta]]])
  grupo <- encuesta[[col_perfil]]

  filas_pregunta <- lapply(pares_perfiles, function(par) {
    x <- valores_numericos[grupo == par[1]]
    y <- valores_numericos[grupo == par[2]]

    delta <- cliff_delta(x, y)
    ic_delta <- bootstrap_ic(x, y, cliff_delta)

    d <- cohen_d(x, y)
    ic_d <- bootstrap_ic(x, y, cohen_d)

    data.frame(
      pregunta = pregunta, perfil_a = par[1], perfil_b = par[2],
      delta_cliff = round(delta, 3),
      delta_cliff_ic95_inf = round(ic_delta[1], 3),
      delta_cliff_ic95_sup = round(ic_delta[2], 3),
      cohen_d = round(d, 3),
      cohen_d_ic95_inf = round(ic_d[1], 3),
      cohen_d_ic95_sup = round(ic_d[2], 3)
    )
  })

  filas_efecto[[pregunta]] <- do.call(rbind, filas_pregunta)
}

tabla_efecto <- do.call(rbind, filas_efecto)
rownames(tabla_efecto) <- NULL
print(tabla_efecto, row.names = FALSE)

write.csv(
  tabla_efecto,
  file.path(ruta_salidas_estadisticas, "tamano_efecto.csv"),
  row.names = FALSE,
  fileEncoding = "UTF-8"
)
cat("\nGuardado:", file.path(ruta_salidas_estadisticas, "tamano_efecto.csv"), "\n")

# ------------------------------------------------------------------------------
# PARTE B: justificación de potencia estadística / tamaño de muestra
# ------------------------------------------------------------------------------
cat("\n== Parte B: justificación de potencia estadística (n por perfil dominante) ==\n")

D_OBJETIVO <- 0.5
ALFA <- 0.05
POTENCIA_OBJETIVO <- 0.80

# n requerido por grupo para detectar d=0.5 con alfa=0.05 y potencia=0.80
calculo_n_requerido <- power.t.test(
  delta = D_OBJETIVO, sd = 1, sig.level = ALFA, power = POTENCIA_OBJETIVO,
  type = "two.sample"
)
n_requerido_por_grupo <- ceiling(calculo_n_requerido$n)

tabla_n_perfiles <- as.data.frame(table(encuesta[[col_perfil]]))
names(tabla_n_perfiles) <- c("perfil", "n_actual")
tabla_n_perfiles <- tabla_n_perfiles[order(-tabla_n_perfiles$n_actual), ]

perfil_dominante <- tabla_n_perfiles$perfil[1]
n_dominante <- tabla_n_perfiles$n_actual[1]

# Potencia realmente alcanzada con el n actual del perfil dominante
calculo_potencia_actual <- power.t.test(
  n = n_dominante, delta = D_OBJETIVO, sd = 1, sig.level = ALFA,
  type = "two.sample"
)
potencia_alcanzada <- calculo_potencia_actual$power

cumple_n60 <- n_dominante >= 60

cat(sprintf("Perfil dominante: %s (n = %d)\n", perfil_dominante, n_dominante))
cat(sprintf("¿Cumple n >= 60 por perfil dominante? %s\n", ifelse(cumple_n60, "SÍ", "NO")))
cat(sprintf(
  "n requerido por grupo para detectar d=%.1f con alfa=%.2f y potencia=%.2f: %d\n",
  D_OBJETIVO, ALFA, POTENCIA_OBJETIVO, n_requerido_por_grupo
))
cat(sprintf(
  "Potencia realmente alcanzada con el n actual del perfil dominante (n=%d, d=%.1f, alfa=%.2f): %.3f (%.1f%%)\n",
  n_dominante, D_OBJETIVO, ALFA, potencia_alcanzada, potencia_alcanzada * 100
))

print(tabla_n_perfiles, row.names = FALSE)

reporte_potencia <- c(
  "# Justificación de potencia estadística — comparación entre perfiles",
  "",
  "## Requisito de la guía",
  "",
  "n ≥ 60 por perfil dominante, o justificación explícita con cálculo de",
  "potencia estadística (Cohen d = 0.5, α = 0.05, 1−β = 0.80).",
  "",
  "## Estado actual",
  "",
  sprintf("- Perfil dominante: **%s** (n = %d)", perfil_dominante, n_dominante),
  sprintf("- ¿Cumple n ≥ 60? **%s**", ifelse(cumple_n60, "Sí", "No")),
  sprintf(
    "- n requerido por grupo para detectar d = %.1f con α = %.2f y potencia = %.2f: **%d**",
    D_OBJETIVO, ALFA, POTENCIA_OBJETIVO, n_requerido_por_grupo
  ),
  sprintf(
    "- Potencia real alcanzada con el n actual del perfil dominante: **%.1f%%** (objetivo: %.0f%%)",
    potencia_alcanzada * 100, POTENCIA_OBJETIVO * 100
  ),
  "",
  "## n actual por perfil",
  "",
  "| Perfil | n |",
  "|---|---|",
  sprintf("| %s | %d |", tabla_n_perfiles$perfil, tabla_n_perfiles$n_actual),
  "",
  "## Interpretación",
  "",
  if (cumple_n60) {
    "El perfil dominante cumple el mínimo de n ≥ 60 exigido por la guía."
  } else {
    paste0(
      "El perfil dominante NO alcanza n ≥ 60. Con el tamaño de muestra actual, ",
      "la potencia estadística para detectar un efecto mediano (d = 0.5) es de ",
      sprintf("%.1f%%", potencia_alcanzada * 100),
      ", por debajo del 80% convencionalmente aceptado. Esto significa que las ",
      "comparaciones entre perfiles reportadas en `06_pruebas_hipotesis.R` deben ",
      "tratarse como **evidencia exploratoria, no confirmatoria** -- un efecto real ",
      "de tamaño mediano podría no detectarse como estadísticamente significativo ",
      "simplemente por falta de potencia, no porque no exista. Esta limitación debe ",
      "declararse explícitamente en el manuscrito."
    )
  }
)

writeLines(reporte_potencia, file.path(ruta_salidas_estadisticas, "justificacion_potencia.md"), useBytes = TRUE)
cat("\nGuardado:", file.path(ruta_salidas_estadisticas, "justificacion_potencia.md"), "\n")
