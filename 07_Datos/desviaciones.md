# Registro de desviaciones respecto del protocolo registrado

Proyecto SGCV-IA. Conforme a la Guía de Desarrollo (Sección 5, ítem 6) y a la práctica de reporte transparente para estudios con protocolo pre-registrado (Nosek et al., 2018). Cada desviación se documenta con fecha, motivo, y quién la identificó/confirmó.

---

## Desviación 1 — Componente de validación cuantitativa del Enfoque 3 no ejecutado

**Protocolo registrado:** `Elicitación y Validación de Requisitos de Explicabilidad para el Módulo de Sugerencias Diagnósticas Asistidas por IA del Sistema SGCV-IA`, OSF, registrado el 1 de agosto de 2026 (https://osf.io/r5p8d/).

**Qué establecía el protocolo:** un componente de validación cuantitativa en dos rondas independientes (Ronda 1 y Ronda 2, seis participantes por ronda: tres técnicos y tres no técnicos), aplicado mediante el instrumento "Guion de validación v2.0". El instrumento incluye un estímulo simulado (sugerencia diagnóstica del paciente "Rocky"), escalas Likert de comprensión y satisfacción, y un checklist de cobertura contra las cuatro dimensiones del marco de explicabilidad de Chazette et al. (causal, contraste, ejemplos, temporalidad). El plan de análisis registrado preveía el cálculo del coeficiente kappa de Cohen entre rondas, una comparación de Mann-Whitney U entre usuarios técnicos y no técnicos, y el cálculo de cobertura del marco como variable dependiente de RQ2.

**Qué se ejecutó en su lugar:** el instrumento fue diseñado y finalizado, pero no se aplicó a los 12 participantes (6 por ronda) dentro del plazo del proyecto. No existen respuestas, checklists completados, ni actas de sesión para este componente. El hallazgo de RQ1 reportado en el manuscrito final se derivó, en su lugar, de la elicitación general ya completada (16 entrevistas semiestructuradas, P01–P16), interpretada bajo el mismo marco de explicabilidad.

**Motivo de la desviación:** restricción de tiempo del equipo para coordinar y ejecutar 12 sesiones adicionales de validación antes del corte de la Entrega 4.

**Consecuencia:** los análisis cuantitativos previstos para el Enfoque 3 (cobertura del marco de explicabilidad para RQ2, kappa de Cohen entre rondas, prueba U de Mann-Whitney técnico/no técnico) no pudieron completarse para esta versión del manuscrito. Se documentan como limitación del estudio (Amenazas a la Validez, validez de conclusión) y como primer punto de trabajo futuro.

**Fecha de identificación de la desviación:** 5 de septiembre de 2026.

**Confirmado por:** Anthony Alfredo Vera Gómez (responsable del componente empírico del Enfoque 3), por escrito.

**Verificado por:** Alberto Jeanpool Marcillo Ponce, mediante contraste entre el protocolo registrado, el instrumento diseñado (`Guion_Validacion_v2_0`), y la ausencia de datos de aplicación en el repositorio.

---

## Notas sobre el formato de este registro

Toda desviación adicional que se identifique antes del corte de la Entrega 4 debe agregarse a este archivo como una nueva entrada numerada, siguiendo la misma estructura (protocolo registrado, qué establecía, qué se ejecutó en su lugar, motivo, consecuencia, fecha, quién la confirmó y quién la verificó). No se elimina ni se reescribe una entrada ya registrada; si una desviación se resuelve posteriormente (por ejemplo, si las Rondas 1 y 2 llegaran a ejecutarse antes del corte), se agrega una nota de actualización fechada al final de la entrada correspondiente, sin borrar el registro original.

## Desviación 2 — Tamaño de muestra de la encuesta ampliado de n=60 a n=210 sin registro previo

**Protocolo registrado:** Guía de Desarrollo y Consolidación del PFC (Sección 5), que establecía un mínimo de n≥60 respuestas de cuestionario, distribuidas entre los 4 perfiles de participante (médico veterinario, dueño de mascota, técnico, administrador).

**Qué establecía el plan original:** recolectar 60 respuestas como mínimo estadísticamente justificado, documentado en `justificacion_n60.md`, calculado antes de cerrar la recolección.

**Qué se ejecutó en su lugar:** entre el 8 y el 10 de septiembre de 2026, la recolección de la encuesta continuó más allá del umbral de 60 y llegó a 210 respuestas (commit `2d5d6b6`, 2026-09-10). El archivo `justificacion_n210.md` que documenta la adecuación estadística de n=210 se generó el 11 de septiembre de 2026, es decir, después de que la muestra ya había crecido — no como una decisión de diseño tomada de antemano, sino como una justificación de una muestra que ya existía. Además, el commit que registra el crecimiento de la encuesta (`2d5d6b6`) lleva un mensaje de commit que no describe el cambio real ("Update print statement from 'Hello' to 'Goodbye'"), lo cual se señala aquí para dejarlo aclarado en vez de que quede como una inconsistencia sin explicar en el historial.

**Motivo de la desviación:** El archivo `encuesta_respuestas_crudas.csv` se generó originalmente
a partir de una exportación temprana del formulario de Google Forms, que en ese momento tenía 60
respuestas. El equipo no volvió a exportar el formulario para actualizar el archivo de datos
crudos sino hasta el 10 de septiembre de 2026; para entonces, el formulario había permanecido
abierto y acumulado 210 respuestas. No hubo una decisión deliberada de truncar la muestra a 60:
simplemente no se regeneró la exportación de datos crudos a tiempo para reflejar las respuestas
que ya se habían recolectado.

**Consecuencia:** el tamaño muestral final (n=210) supera con holgura el mínimo exigido por la guía (n≥60) y el margen de error alcanzado (~6.8%) es adecuado para un nivel de confianza del 95%. Los resultados y tablas de `07_Datos/resultados/` fueron regenerados con `run_all.R` sobre el conjunto completo de 210 respuestas el 11 de septiembre de 2026, por lo que `README.md` y `07_Datos/README_datos.md` reportan la cifra real (n=210) y no la cifra original de la propuesta (n=60). El manuscrito académico de `09_Publicacion/` no reporta esta cifra porque su alcance se limita al componente cualitativo (16 entrevistas, P01–P16); la encuesta no forma parte de ese estudio.

**Fecha de identificación de la desviación:** 11 de septiembre de 2026.

**Confirmado por:** Carlos Daniel Barrionuevo Fuentes, por escrito.

**Verificado por:** Carlos Daniel Barrionuevo Fuentes, contrastando el historial de Git (`git log --follow` sobre `encuesta_respuestas_crudas.csv`) contra la fecha de generación de `justificacion_muestra.md`.
