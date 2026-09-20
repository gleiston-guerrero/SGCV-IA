# ==============================================================================
# 03_curva_saturacion_codigos_abiertos.R
# SGCV-IA - Ingeniería de Requisitos (ISR-401)
#
# Calcula la curva de saturación temática a nivel de código abierto a partir
# de 02_Evidencias/Codificacion_Tematica/codificacion_tematica_SGCV-IA.csv
#
# Produce:
#   - 06_Experimento/resultados/tabla_saturacion_codigos_abiertos.csv
#   - 06_Experimento/resultados/curva_saturacion_codigos_abiertos.png
#
# Ningún número de esta tabla/figura debe escribirse a mano en ningún
# documento: siempre debe reproducirse ejecutando este script sobre
# datos_crudos / la evidencia de codificación tal como está en el repositorio.
# ==============================================================================

# --- 0. Rutas (relativas a ESTA carpeta: dataset_zenodo/ es un paquete
#        plano y autocontenido -- entrada y salidas viven junto al script,
#        no en la estructura de carpetas del repositorio principal) --------
ruta_entrada  <- "codificacion_tematica_SGCV-IA.csv"
ruta_tabla    <- "tabla_saturacion_codigos_abiertos.csv"
ruta_figura   <- "curva_saturacion_codigos_abiertos.png"

dir.create(dirname(ruta_tabla), recursive = TRUE, showWarnings = FALSE)

# --- 1. Cargar datos -----------------------------------------------------------
datos <- read.csv(ruta_entrada, stringsAsFactors = FALSE, encoding = "UTF-8")

columnas_esperadas <- c("Fragmento", "Codigo", "Categoria",
                         "Requisito_derivado", "ID_evidencia",
                         "Analista_codificador")
faltantes <- setdiff(columnas_esperadas, names(datos))
if (length(faltantes) > 0) {
  stop("Faltan columnas esperadas en el CSV de codificación: ",
       paste(faltantes, collapse = ", "))
}

# --- 2. Ordenar por participante (P01 -> P16), respetando el orden de recolección ---
orden_participantes <- sprintf("P%02d", 1:16)
datos$ID_evidencia <- factor(datos$ID_evidencia, levels = orden_participantes, ordered = TRUE)
datos <- datos[order(datos$ID_evidencia), ]

participantes_presentes <- orden_participantes[orden_participantes %in% unique(as.character(datos$ID_evidencia))]

# --- 3. Calcular códigos nuevos por entrevista (nivel de código abierto) -----
codigos_vistos <- character(0)
filas_resultado <- list()

for (p in participantes_presentes) {
  codigos_de_este <- unique(datos$Codigo[datos$ID_evidencia == p])
  nuevos <- setdiff(codigos_de_este, codigos_vistos)
  codigos_vistos <- union(codigos_vistos, codigos_de_este)

  filas_resultado[[length(filas_resultado) + 1]] <- data.frame(
    Participante           = p,
    Codigos_en_entrevista  = length(codigos_de_este),
    Codigos_nuevos         = length(nuevos),
    Codigos_acumulados     = length(codigos_vistos),
    stringsAsFactors = FALSE
  )
}

tabla_saturacion <- do.call(rbind, filas_resultado)

# Porcentaje de códigos nuevos respecto al total acumulado final (criterio de saturación)
total_final <- tail(tabla_saturacion$Codigos_acumulados, 1)
tabla_saturacion$Pct_nuevos_del_total <- round(
  100 * tabla_saturacion$Codigos_nuevos / total_final, 2
)

# --- 4. Guardar tabla ----------------------------------------------------------
write.csv(tabla_saturacion, ruta_tabla, row.names = FALSE, fileEncoding = "UTF-8")
cat("Tabla guardada en:", normalizePath(ruta_tabla), "\n")
print(tabla_saturacion)

# --- 5. Generar figura (barras = códigos nuevos, línea = acumulado) -----------
Sys.setlocale("LC_ALL", "C.UTF-8")
png(ruta_figura, width = 1400, height = 900, res = 150, type = "cairo")

par(mar = c(5, 5, 4, 5))
bp <- barplot(
  tabla_saturacion$Codigos_nuevos,
  names.arg = tabla_saturacion$Participante,
  col = "#4472C4",
  border = NA,
  ylim = c(0, max(tabla_saturacion$Codigos_en_entrevista) + 2),
  ylab = "Códigos nuevos por entrevista",
  xlab = "Participante (orden de recolección)",
  main = "Curva de saturación temática — nivel de código abierto\nSGCV-IA (n = 16 entrevistas)",
  las = 2
)

par(new = TRUE)
plot(
  bp, tabla_saturacion$Codigos_acumulados,
  type = "o", pch = 19, col = "#C00000",
  axes = FALSE, xlab = "", ylab = "",
  ylim = c(0, total_final + 10)
)
axis(side = 4, col = "#C00000", col.axis = "#C00000")
mtext("Códigos acumulados", side = 4, line = 3, col = "#C00000")

legend("topleft",
       legend = c("Códigos nuevos (barras)", "Acumulado (línea)"),
       fill = c("#4472C4", NA), border = c(NA, NA),
       lty = c(NA, 1), pch = c(NA, 19), col = c("#4472C4", "#C00000"),
       bty = "n")

dev.off()
cat("Figura guardada en:", normalizePath(ruta_figura), "\n")

# --- 6. Resumen en consola -------------------------------------------------
cat("\n=== Resumen ===\n")
cat("Total de códigos abiertos únicos:", total_final, "\n")
cat("Total de entrevistas:", length(participantes_presentes), "\n")
ultimas3 <- tail(tabla_saturacion$Codigos_nuevos, 3)
cat("Códigos nuevos en las últimas 3 entrevistas:", paste(ultimas3, collapse = ", "),
    "(promedio =", round(mean(ultimas3), 2), ")\n")
cat("NOTA: A nivel de código ABIERTO no se espera saturación completa (cada\n")
cat("fragmento conserva la redacción propia del participante); el criterio de\n")
cat("saturación formal debe aplicarse sobre los códigos AXIALES consolidados,\n")
cat("una vez completada esa etapa de análisis.\n")
