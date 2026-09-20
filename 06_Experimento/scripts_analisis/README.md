# scripts_analisis

## Estado: COMPLETO — 9 de 9 scripts implementados, integrados a `07_Datos/scripts/run_all.R`

Según la Sección 4 de la guía, todo análisis debe ejecutarse con scripts
versionados que reproduzcan exactamente cada tabla y figura del manuscrito.
No se aceptan tablas producidas manualmente en hojas de cálculo ni figuras
pegadas sin script que las genere.

## Estructura

| Script | Función | Estado |
|---|---|---|
| 01_importar_datos.R | Carga datos_crudos/ (transcripciones, respuestas, corpus RF/RNF) | **Completo** |
| 02_limpieza.R | Limpieza básica, detección de duplicados y valores faltantes | **Completo** |
| 03_curva_saturacion_codigos_abiertos.R | Curva de saturación de códigos por entrevista | **Completo** |
| 04_descriptivos.R | Estadísticos descriptivos por grupo (mediana, media, DE, mín, máx, IQR) | **Completo** |
| 05_supuestos.R | Shapiro-Wilk (normalidad), Levene (homogeneidad de varianzas) | **Completo** |
| 06_pruebas_hipotesis.R | t pareada / Wilcoxon según corresponda, corrección Holm-Bonferroni | **Completo** |
| 07_tamano_efecto.R | d de Cohen / delta de Cliff con bootstrap (10.000 réplicas) | **Completo** |
| 08_figuras.R | Genera todas las figuras del manuscrito hacia 09_Publicacion/figuras/ | **Completo** |
| 09_tablas.R | Genera todas las tablas del manuscrito hacia 09_Publicacion/tablas/ | **Completo** |
| run_all.R | Ejecuta los scripts anteriores en orden, de principio a fin | **Completo** |

## Regla de reproducibilidad (checklist de aceptación, Sección 9.3)

El requisito de cierre es que `run_all.R` (o `make all`) reproduzca
exactamente las cifras del manuscrito partiendo de `datos_crudos/`.
Ningún script debe contener resultados o cifras escritas a mano.

`07_Datos/scripts/run_all.R` ejecuta este pipeline como parte del
orquestador general y copia sus tablas finales a `07_Datos/resultados/`,
de modo que una sola orden (`Rscript 07_Datos/scripts/run_all.R`)
reproduce también el componente cuantitativo, no solo el cualitativo.

## Estado real de los datos de entrada (verificado sobre el repositorio)

- **Transcripciones:** 16 de 16 mínimas — **completas** (`07_Datos/datos_crudos/Entrevistas/`).
- **Respuestas de cuestionario:** el cuestionario cerró con **n = 210** respuestas
  totales (`07_Datos/resultados/justificacion_muestra.md`), repartidas en 4 perfiles:
  - Dueño(a) de mascota: 80
  - Administrador(a) de clínica veterinaria: 45
  - Médico veterinario(a): 43
  - Auxiliar o técnico veterinario: 42

  El perfil dominante (Dueño(a) de mascota, n=80) ya supera el mínimo
  n≥60 requerido; con d=0.5 y α=0.05 alcanza una potencia de 0.882 (88.2%)
  — ver `justificacion_potencia.md`. Aun así, las comparaciones entre
  perfiles siguen siendo exploratorias, no confirmatorias (ver
  `07_tamano_efecto.R`).
- **Codificación temática:** cerrada y verificada (50 códigos axiales en 7 categorías;
  ver `02_Evidencias/Codificacion_Tematica/`).

## Nota histórica

Este pipeline se implementó completamente después de la evaluación que
documentó su estado inicial ("1 de 9 scripts", n=60). Esa etapa quedó
superada; ver `CHANGELOG.md` para el detalle de cuándo se integró al
orquestador general del paquete de datos.
