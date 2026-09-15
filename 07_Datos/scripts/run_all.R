# ==============================================================================
# 07_Datos/scripts/run_all.R
# ------------------------------------------------------------------------------
# Orquestador único del pipeline de datos de 07_Datos/.
# Corre, en orden, todos los scripts del pipeline y genera todos los
# resultados en 07_Datos/resultados/ con UN SOLO COMANDO, sin intervención
# manual.
#
# Uso:
#   Rscript 07_Datos/scripts/run_all.R
#   (ejecutar SIEMPRE desde la raíz del repositorio, igual que los demás
#   scripts de este pipeline — no desde dentro de 07_Datos/ ni de scripts/)
#
# Cómo agregar un script nuevo al pipeline (por ejemplo, cuando Marcillo
# confirme la cifra de códigos/categorías y se puedan programar el conteo y
# la curva de saturación): solo hay que agregar su nombre de archivo al
# vector `pipeline` de abajo, en el orden en que debe ejecutarse. No hace
# falta tocar nada más de este script.
#
# Si un script del vector `pipeline` todavía no existe, se salta con un
# aviso en vez de hacer fallar todo el proceso — así este orquestador ya
# puede usarse desde ahora, aunque falten scripts por crear.
# ==============================================================================

ruta_scripts <- "07_Datos/scripts"

if (!dir.exists(ruta_scripts)) {
  stop(
    "No se encontró la carpeta ", ruta_scripts, ".\n",
    "Este script debe ejecutarse desde la raíz del repositorio, ",
    "por ejemplo: Rscript 07_Datos/scripts/run_all.R"
  )
}

# ------------------------------------------------------------------------------
# Orden del pipeline
# ------------------------------------------------------------------------------
pipeline <- c(
  "importar_datos.R",
  "conteo_codigos.R",     # pendiente de crear: depende de la codificación temática de Marcillo
  "curva_saturacion.R",   # pendiente de crear: depende de la codificación temática de Marcillo
  "justificacion_muestra.R"
)

# ------------------------------------------------------------------------------
# Ejecución en orden, con manejo de errores
# ------------------------------------------------------------------------------
cat("==============================================\n")
cat(" Pipeline de datos SGCV-IA — 07_Datos\n")
cat("==============================================\n\n")

tiempo_inicio <- Sys.time()
registro_pipeline <- data.frame(script = character(), estado = character(), stringsAsFactors = FALSE)

for (script in pipeline) {
  ruta_script <- file.path(ruta_scripts, script)

  if (!file.exists(ruta_script)) {
    cat(sprintf("[OMITIDO] %s todavía no existe — se salta.\n\n", script))
    registro_pipeline <- rbind(registro_pipeline, data.frame(script = script, estado = "omitido (no existe todavía)"))
    next
  }

  cat(sprintf("== Ejecutando %s ==\n", script))

  hubo_advertencias <- FALSE

  estado <- tryCatch({
    withCallingHandlers({
      source(ruta_script, encoding = "UTF-8", echo = FALSE)
    }, warning = function(w) {
      cat(sprintf("ADVERTENCIA en %s: %s\n", script, conditionMessage(w)))
      hubo_advertencias <<- TRUE
      invokeRestart("muffleWarning")  # registra la advertencia pero deja que el script siga
    })
    if (hubo_advertencias) "OK (con advertencias)" else "OK"
  }, error = function(e) {
    cat(sprintf("ERROR en %s: %s\n", script, conditionMessage(e)))
    "ERROR"
  })

  registro_pipeline <- rbind(registro_pipeline, data.frame(script = script, estado = estado))
  cat("\n")

  if (estado == "ERROR") {
    cat("Pipeline detenido: hubo un error en el script anterior.\n")
    cat("Corrígelo y vuelve a correr run_all.R desde el inicio.\n")
    break
  }
}

# ------------------------------------------------------------------------------
# Pipeline del componente empírico (06_Experimento/scripts_analisis)
# ------------------------------------------------------------------------------
# El paquete de datos de 07_Datos/ y el análisis estadístico del componente
# empírico vivían como dos pipelines separados y no conectados: este último
# generaba las tablas que cita el manuscrito (descriptivos, supuestos,
# pruebas de hipótesis, tamaño del efecto) directo en 09_Publicacion/tablas/,
# sin que 07_Datos/resultados/ -el paquete de datos reproducible oficial-
# incluyera nunca esas tablas. Desde aquí se ejecuta ese segundo pipeline y
# se copian sus tablas finales a 07_Datos/resultados/, para que "una sola
# orden" (Rscript 07_Datos/scripts/run_all.R) reproduzca de verdad todo lo
# que el manuscrito cita, no solo la parte cualitativa.
if (!any(registro_pipeline$estado == "ERROR")) {

  ruta_analisis_empirico <- "06_Experimento/scripts_analisis/run_all.R"

  if (file.exists(ruta_analisis_empirico)) {
    cat("== Ejecutando 06_Experimento/scripts_analisis/run_all.R (componente empírico) ==\n")

    hubo_advertencias <- FALSE

    estado <- tryCatch({
      withCallingHandlers({
        source(ruta_analisis_empirico, encoding = "UTF-8", echo = FALSE)
      }, warning = function(w) {
        cat(sprintf("ADVERTENCIA en %s: %s\n", ruta_analisis_empirico, conditionMessage(w)))
        hubo_advertencias <<- TRUE
        invokeRestart("muffleWarning")
      })
      if (hubo_advertencias) "OK (con advertencias)" else "OK"
    }, error = function(e) {
      cat(sprintf("ERROR en %s: %s\n", ruta_analisis_empirico, conditionMessage(e)))
      "ERROR"
    })

    registro_pipeline <- rbind(
      registro_pipeline,
      data.frame(script = "06_Experimento/scripts_analisis/run_all.R", estado = estado)
    )
    cat("\n")

    # Copiar las tablas finales del manuscrito también a 07_Datos/resultados/,
    # para que el paquete de datos quede autocontenido (09_tablas.R ya las
    # dejó consolidadas y con nombres estables en 09_Publicacion/tablas/).
    if (estado != "ERROR") {
      ruta_tablas_publicacion <- "09_Publicacion/tablas"
      ruta_resultados_datos   <- "07_Datos/resultados"

      if (dir.exists(ruta_tablas_publicacion)) {
        tablas_manuscrito <- list.files(ruta_tablas_publicacion, pattern = "\\.csv$", full.names = TRUE)
        copiadas_ok <- file.copy(tablas_manuscrito, ruta_resultados_datos, overwrite = TRUE)
        cat(sprintf(
          "Copiadas %d de %d tablas del manuscrito a %s/\n\n",
          sum(copiadas_ok), length(tablas_manuscrito), ruta_resultados_datos
        ))
      }
    }
  } else {
    cat(sprintf("[OMITIDO] %s todavía no existe — se salta.\n\n", ruta_analisis_empirico))
    registro_pipeline <- rbind(
      registro_pipeline,
      data.frame(script = "06_Experimento/scripts_analisis/run_all.R", estado = "omitido (no existe todavía)")
    )
  }
}

tiempo_fin <- Sys.time()

# ------------------------------------------------------------------------------
# Resumen final
# ------------------------------------------------------------------------------
cat("==============================================\n")
cat(" Resumen del pipeline\n")
cat("==============================================\n")
print(registro_pipeline, row.names = FALSE)
cat(sprintf(
  "\nTiempo total: %.1f segundos\n",
  as.numeric(difftime(tiempo_fin, tiempo_inicio, units = "secs"))
))

if (any(registro_pipeline$estado == "ERROR")) {
  cat("\nEl pipeline terminó con al menos un error. Revisa los mensajes de arriba.\n")
  quit(status = 1, save = "no")
}

cat("\nListo. Todos los resultados quedaron en 07_Datos/resultados/\n")
