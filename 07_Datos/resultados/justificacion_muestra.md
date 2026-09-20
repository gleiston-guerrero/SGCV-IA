# Tamaño de muestra alcanzado (n = 210)

- Tamaño de muestra: n = 210 respuestas de cuestionario.
- Tipo de muestreo: por conveniencia (enlace de Google Forms compartido, sin
  marco muestral ni selección aleatoria de la población).

## Por qué este reporte NO calcula un margen de error

Las fórmulas de margen de error para proporciones (e = Z·√(p(1−p)/n)) exigen
muestreo probabilístico (aleatorio simple) de una población definida. Este
estudio usó muestreo por conveniencia, así que calcular un margen de error
con esas fórmulas daría una falsa sensación de precisión estadística que la
recolección real no respalda -- exactamente el error que corrige la tarea A6
del plan de mejora de datos (19/09/2026): "retirar el margen de error
calculado como si fuera un muestreo aleatorio".

La justificación estadística válida para las comparaciones cuantitativas de
este componente empírico es el **análisis de potencia** (Cohen d = 0.5,
α = 0.05, potencia objetivo = 0.80), calculado en
`06_Experimento/scripts_analisis/07_tamano_efecto.R` (Parte B) y reportado
en `06_Experimento/resultados/salidas_estadisticas/justificacion_potencia.md`.

## Nota metodológica

La variable "frecuencia de uso" no existe como tal en la encuesta cerrada.
Se usó como aproximación la pregunta sobre frecuencia de inconvenientes en la
atención/gestión de la clínica, por ser la columna de frecuencia más cercana
disponible. Si el equipo define una variable de frecuencia de uso distinta,
hay que actualizar `col_frecuencia` en este script y volver a ejecutarlo.

## Privacidad

Este reporte y el archivo `perfil_participantes_agregado.csv` contienen
únicamente conteos agregados. No incluyen nombres ni ninguna otra columna
que permita reidentificar a un participante individual.
