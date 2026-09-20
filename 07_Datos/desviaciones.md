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

**Consecuencia:** el tamaño muestral final (n=210) supera con holgura el mínimo exigido por la guía (n≥60) y el margen de error alcanzado (~6.8%) es adecuado para un nivel de confianza del 95%. Los resultados y tablas de `07_Datos/resultados/` fueron regenerados con `run_all.R` sobre el conjunto completo de 210 respuestas el 11 de septiembre de 2026, por lo que el manuscrito y el README reportan la cifra real (n=210) y no la cifra original de la propuesta (n=60).

**Fecha de identificación de la desviación:** 11 de septiembre de 2026.

**Confirmado por:** Carlos Daniel Barrionuevo Fuentes, por escrito.

**Verificado por:** Carlos Daniel Barrionuevo Fuentes, contrastando el historial de Git (`git log --follow` sobre `encuesta_respuestas_crudas.csv`) contra la fecha de generación de `justificacion_muestra.md`.

## Desviación 3 — P04 no cubre la visita mencionada como anterior

**Qué establecía el protocolo:** cada participante debía contar con una transcripción y grabación completas de su sesión de entrevista.

**Qué se ejecutó en su lugar:** P04 menciona, dentro de la entrevista grabada del 25/07/2026 (audio: 2026-07-25_Audio_P04_Entrevista.mp3, 879.70 s), una visita anterior a la clínica que no fue grabada ni transcrita. Solo existe registro de la sesión del 25/07.

**Motivo de la desviación:** la visita anterior mencionada por el participante ocurrió antes de que se coordinara la recolección de datos con consentimiento informado; no se cuenta con grabación de ese evento.

**Consecuencia:** cualquier información de P04 sobre esa visita anterior queda excluida del análisis por no tener respaldo de recolección documentada (regla 2 del plan de mejora de datos: no se crean datos).

**Fecha de identificación de la desviación:** 19 de septiembre de 2026.

**Confirmado por:** Anthony Alfredo Vera Gómez.

**Verificado por:** pendiente de confirmación por el resto del equipo.

**Nota de actualización (19/09/2026):** esta desviación se identificó sobre el archivo `P04_revisada.md`, que en ese momento se creía correspondiente a P04. La verificación de cotejo completo (ver `registro_correcciones.md`, sección "Cotejo completo P01–P16") determinó que ese archivo en realidad corresponde a **P01**, no a P04. El contenido real de P04 (recuperado del archivo que estaba mal etiquetado como P03) es una entrevista completa que **no** menciona ninguna visita anterior no grabada. **Esta desviación queda retractada: no ocurrió tal como se describió.** Se mantiene el registro original sin borrar, conforme a la nota de formato de este archivo. No se identificaron, hasta la fecha, entrevistas incompletas entre las 16 verificadas.

## Desviación 4 — Registro previo en OSF posterior al inicio de la recolección de datos

**Protocolo registrado:** `Elicitación y Validación de Requisitos de Explicabilidad para el Módulo de Sugerencias Diagnósticas Asistidas por IA del Sistema SGCV-IA`, OSF (`osf.io/r5p8d`).

**Qué se asumía:** que el registro previo (pre-registration) se realizó antes de iniciar la recolección de datos empíricos del proyecto, como salvaguarda metodológica contra HARKing y p-hacking (así se afirma en `11_Defensa/guion.md` y `06_Experimento/README.md`).

**Qué muestra la evidencia:** la captura de pantalla del registro (`06_Experimento/OSF_Registration.pdf`) indica **"Date registered: Aug 1, 2026"** y **"Date created: Aug 1, 2026"**, y la propia página muestra el estado *"This Registration Is Currently Archiving. And No Changes Can Be Made At This Time."* — es decir, es una captura de una página en proceso de archivado, no de un registro ya finalizado y verificable de forma independiente.

Contrastando esa fecha (01/08/2026) contra las fechas reales de las 16 entrevistas (`02_Evidencias/Transcripciones/`, verificadas en B1 y B7 de `registro_correcciones.md`) y la primera respuesta de la encuesta (`encuesta_respuestas_crudas.csv`, primera marca temporal: 27/07/2026):

- Entrevistas realizadas **antes** del registro (01/08/2026): P01, P02 (26/05), P03 (21/07), P04, P05 (25/07), P06, P07 (27/07) y P08 (28/07) — **8 de las 16**.
- Entrevistas realizadas **después** del registro: P09–P16 (31/08/2026) — las otras 8.
- La encuesta ya había recibido respuestas (desde el 27/07/2026) antes del registro del 01/08/2026.

**Motivo de la desviación:** el registro en OSF se creó una vez avanzada la primera ronda de recolección, no antes de iniciarla como requiere un pre-registro en sentido estricto.

**Consecuencia:** el registro previo protege metodológicamente la segunda mitad de las entrevistas (P09–P16) y cualquier análisis que dependa solo de ellas, pero no puede invocarse como salvaguarda contra HARKing/p-hacking para las primeras 8 entrevistas ni para la encuesta, que ya estaban en curso cuando se registró el protocolo. El manuscrito y los materiales de defensa (`guion.md`, `presentacion.pptx`) que presentan el registro como anterior a "iniciar la recolección de datos" en términos generales deben matizar esa afirmación. Los identificadores (`osf.io/r5p8d`, DOI Zenodo `10.5281/zenodo.22558095`) siguen sin verificarse por acceso directo a las plataformas (ver nota de consistencia en el `README.md` raíz); solo se confirmó, contra el PDF de captura, la fecha de registro y el estado "Currently Archiving".

**Fecha de identificación de la desviación:** 19 de septiembre de 2026.

**Confirmado por:** pendiente de confirmación por escrito de Anthony Alfredo Vera Gómez (responsable del registro OSF).

**Verificado por:** Anthony Alfredo Vera Gómez, contrastando `06_Experimento/OSF_Registration.pdf` contra las fechas de `02_Evidencias/Transcripciones/` y la primera marca temporal de `encuesta_respuestas_crudas.csv`.

## Declaración — Estado real de la aprobación ética institucional (tarea G6 del plan de mejora de datos)

**Qué afirmaba `08_Etica/Adenda_Segunda_Ronda.pdf`:** que la segunda ronda de recolección se ejecuta "bajo el mismo marco ético ya aprobado".

**Qué muestra la evidencia:** `08_Etica/Solicitud_Aprobacion_Etica_SGCV-IA.pdf` (Oficio Nro. FCC-ISR401-SGCV-IA-2026, dirigido al Dr. Eduardo Díaz Ocampo, Vicerrector Académico UTEQ) es una solicitud de aprobación ética, no una aprobación. El campo de fecha del oficio quedó sin completar ("____ de ____________ de 2026") y no existe en el repositorio ningún acta, resolución o comunicación de respuesta del Vicerrectorado que certifique la aprobación, tal como el propio oficio la pide en su punto 3 ("comunicación oficial... con número de acta o resolución, fecha y vigencia").

**Corrección aplicada:** se retiró la palabra "aprobado" de `Adenda_Segunda_Ronda.pdf` y se sustituyó por "iniciado", que es lo verificable: el trámite de aprobación ética se inició (solicitud enviada, carpeta de ética completa adjunta), pero no consta una aprobación institucional formal a la fecha de este documento.

**Estado real declarado:** trámite de aprobación ética **iniciado y en curso**, no aprobado. Pendiente: fecha de envío real del oficio, y respuesta oficial del Vicerrectorado Académico (número de acta/resolución, fecha, vigencia).

**Fecha de identificación:** 19 de septiembre de 2026.

**Confirmado por:** Anthony Alfredo Vera Gómez, contrastando el texto de la Adenda contra el oficio de solicitud y la ausencia de respuesta en el repositorio.

**Verificado por:** pendiente de confirmación por el resto del equipo y, en última instancia, por el docente responsable del trámite (Ing. Gleiston Guerrero Ulloa, PhD), quien es la única persona que puede certificar si existe o no una respuesta del Vicerrectorado que no esté en este repositorio.

## Declaración — Cobertura real de avales institucionales por clínica (tarea G3 del plan de mejora de datos)

**Qué establecía el plan:** "Aval institucional firmado y sellado de cada clínica participante", con criterio de aceptación "un aval firmado por clínica, o declaración de cuáles no lo tienen".

**Qué muestra la evidencia:** las fotos de entorno (`02_Evidencias/Fotos_Entorno/`, ver corrección G1) y las entrevistas del proyecto corresponden a 6 clínicas distintas (Veterinaria Macay y otras 5). Solo Veterinaria Macay cuenta con un documento de aval institucional (`08_Etica/Aval_Institucional.pdf`). Las otras 5 clínicas no cuentan con ningún aval institucional en el repositorio.

**Estado real declarado:**
- **Veterinaria Macay:** aval institucional firmado, con RUC y sello de la organización. (Ver estado de completitud de fecha y cargo del firmante en el registro de correcciones, tarea G3.)
- **Otras 5 clínicas donde se recolectaron fotos y/o entrevistas:** **sin aval institucional firmado.** La participación de su personal y la toma de fotografías se sustentó únicamente en el consentimiento informado individual de cada participante (Anexo A3/C), no en una autorización de la organización como tal.

**Decisión del equipo:** no se retira del repositorio la evidencia (fotos/entrevistas) de las 5 clínicas sin aval — hacerlo reintroduciría la amenaza de "caso único" que la tarea D6 del plan pidió corregir declarando el número real de clínicas (6). En su lugar, se declara explícitamente esta limitación: el estudio de campo cubrió 6 clínicas, pero el respaldo institucional formal (aval firmado) solo se obtuvo de una.

**Consecuencia:** cualquier afirmación en el ERS o el manuscrito que dé a entender aval institucional generalizado a las 6 clínicas debe matizarse. La cobertura multi-clínica (D6) se mantiene declarada con las 6 organizaciones; el respaldo institucional formal (G3) se mantiene declarado como parcial (1 de 6).

**Fecha de identificación:** 19 de septiembre de 2026.

**Confirmado por:** Anthony Alfredo Vera Gómez, contrastando `Fotos_Entorno/` y las transcripciones contra los documentos de `08_Etica/`.

**Verificado por:** pendiente de confirmación por el resto del equipo.

## Desviación 5 — Retiro de datos confidenciales del árbol público rompe la reproducibilidad declarada en A5 (tarea G2 del plan de mejora de datos)

**Qué establecía `LICENSE-DATA.txt`:** que `encuesta_respuestas_crudas.csv` y `datos_crudos/Entrevistas/*.md` nunca se publican en un repositorio público.

**Qué se ejecutó (corrección G2):** se retiraron del árbol público esos archivos, más sus 16 duplicados en `02_Evidencias/Transcripciones/` (33 archivos en total), porque el repositorio es público y esos datos confidenciales estaban expuestos.

**Consecuencia no resuelta:** `07_Datos/scripts/importar_datos.R` depende de leer esos mismos archivos desde `07_Datos/datos_crudos/`, y la tarea A5 del plan exige que toda la cadena de análisis sea reproducible con `run_all.R` en una instalación limpia. Tras este retiro, `run_all.R` fallará (`stop()` en `importar_datos.R`) para cualquiera que clone el repositorio sin acceso al contenedor cifrado `02_Evidencias/00_Restringido/`.

**Motivo de dejarlo como desviación en vez de resolverlo aquí:** resolver esto (mover los archivos al contenedor cifrado y ajustar el script para leer desde ahí, con la contraseña que ya maneja el equipo) es trabajo del Bloque A del plan, no del Bloque G. Se declara aquí para que no quede como una regresión silenciosa cuando alguien intente reproducir el análisis.

**Fecha de identificación:** 19 de septiembre de 2026.

**Confirmado por:** Anthony Alfredo Vera Gómez.

**Verificado por:** pendiente — a resolver cuando se trabaje el Bloque A.
