# Guion de Defensa — SGCV-IA
### Entrega 4 (2B) · Defensa Final — Proyecto Fin de Curso (ISR-401)

---

## Diapositiva 1 — Portada
**Habla: Marcillo Ponce (Analista líder)**

Buenos días/tardes, distinguido tribunal. Somos el equipo SGCV-IA, y presentamos nuestra Entrega 4, la defensa final del proyecto de fin de curso para la asignatura de Ingeniería de Requerimientos.

Nuestro estudio se titula "Requisitos de explicabilidad para sugerencias diagnósticas de Inteligencia Artificial en una clínica veterinaria real: un estudio empírico". El equipo está conformado por Robyn Amagua como documentadora, Carlos Barrionuevo como apoyo y modelador, Anthony Vera como modelador, Jhon Mesías como verificador, y quien les habla, Alberto Marcillo, como analista líder. El proyecto fue supervisado por el Dr. Gleiston Guerrero Ulloa.

A lo largo de esta defensa explicaremos el problema que identificamos, el sistema que construimos, la metodología empírica que aplicamos, los resultados obtenidos, su discusión crítica, nuestras conclusiones y finalmente haremos una demostración funcional del prototipo.

---

## Diapositiva 2 — El problema
**Habla: Marcillo Ponce**

El punto de partida de este trabajo es una clínica veterinaria real que no cuenta con trazabilidad sobre las sugerencias que genera un sistema de Inteligencia Artificial.

Hoy en día, esta clínica maneja un historial clínico mixto —papel combinado con software básico—, lo que genera búsquedas lentas y, sobre todo, deja al veterinario sin ninguna forma sistemática de auditar por qué el sistema le sugiere un diagnóstico determinado.

La tendencia del sector es clara: los módulos de apoyo diagnóstico con IA están creciendo en clínicas pequeñas, pero rara vez exponen al profesional los factores que sustentan cada sugerencia. Y ahí está la brecha que motiva nuestra investigación: la ingeniería de requisitos de explicabilidad se ha estudiado ampliamente en software clínico humano de gran escala, pero existe muy poca evidencia empírica en el contexto veterinario latinoamericano.

Nuestra evidencia base para afirmar esto proviene de 16 entrevistas de campo realizadas a veterinarios, personal auxiliar y administrativo, recolectadas durante las Entregas 1A y 2A de este mismo proyecto de fin de curso.

---

## Diapositiva 3 — Pregunta de investigación y contribuciones
**Habla: Marcillo Ponce**

A partir de ese problema, formulamos nuestra pregunta de investigación: ¿Qué requisitos de explicabilidad, operacionalizados como requisitos no funcionales verificables, resultan necesarios y suficientes para los distintos perfiles de usuario de un sistema clínico veterinario con IA?

Para responderla, este trabajo hace cuatro contribuciones concretas. Primero, un conjunto de requisitos no funcionales de explicabilidad derivado empíricamente de 16 entrevistas y un cuestionario aplicado a 4 perfiles de usuario. Segundo, la operacionalización verificable de ese requisito —identificado como RNF-18— integrada al ERS/SRS y trazada a los requisitos funcionales RF-17, RF-18 y RF-19, así como al caso de uso CU-06. Tercero, un MVP funcional que demuestra el flujo de Aceptar, Modificar o Rechazar una sugerencia, mostrando los factores clínicos y el nivel de confianza antes de decidir. Y cuarto, un paquete de datos abierto con DOI en Zenodo y un registro previo en el Open Science Framework, para garantizar que el estudio sea replicable.

---

## Diapositiva 4 — El sistema: SGCV-IA y sus partes interesadas
**Habla: Barrionuevo Fuentes (Apoyo · Modelador)**

Este es el diagrama de contexto de SGCV-IA, correspondiente a la versión 2.0 de nuestro ERS/SRS. SGCV-IA es un sistema real pensado para una clínica veterinaria, que integra historiales clínicos, gestión de citas, facturación, inventario y un módulo de apoyo diagnóstico con Inteligencia Artificial, siempre bajo supervisión obligatoria del profesional.

El sistema tiene cuatro actores principales. El médico veterinario, que gestiona historiales y diagnósticos, y decide finalmente sobre las sugerencias de la IA. El propietario de la mascota, que recibe notificaciones y da seguimiento al tratamiento. El personal administrativo, encargado de citas, inventario y facturación. Y el administrador del sistema, responsable de usuarios, roles y permisos.

El módulo de IA que está bajo estudio en esta investigación comprende dos funcionalidades: IA-01, el asistente de sugerencias diagnósticas, e IA-02, el recomendador nutricional. Es importante subrayar que ambos exigen revisión y aprobación explícita del veterinario antes de que cualquier sugerencia se aplique al historial del paciente.

---

## Diapositiva 5 — Metodología: Enfoque 3
**Habla: Amagua Sacón (Documentadora)**

Nuestro marco teórico se sustenta en los trabajos de Chazette y Schneider (2020) y Chazette, Brunotte y Speith (2021 y 2022), quienes conceptualizan la explicabilidad como un requisito no funcional dentro de la ingeniería de software.

En cuanto al diseño metodológico, aplicamos un estudio de caso con elicitación cualitativa mediante entrevistas semiestructuradas, complementado con un cuestionario cuantitativo dirigido a cuatro perfiles de usuario distintos.

Un aspecto que quiero resaltar es el registro previo: inscribimos nuestro protocolo de investigación en el Open Science Framework, en osf.io/r5p8d, antes de iniciar la recolección de datos. Esto funciona como salvaguarda metodológica contra el HARKing y el p-hacking, es decir, contra formular hipótesis después de ver los resultados o manipular el análisis para obtener resultados favorables.

La unidad de análisis de este estudio es específicamente el módulo de sugerencias diagnósticas por IA, correspondiente a los requisitos funcionales RF-17, RF-18 y RF-19 del propio sistema SGCV-IA.

---

## Diapositiva 6 — Cierre del trabajo de campo
**Habla: Amagua Sacón**

Con el trabajo de campo cerrado, estos son nuestros números finales: realizamos 16 entrevistas, identificadas de P01 a P16; de ellas surgieron 167 códigos abiertos; estos se consolidaron en 50 códigos axiales, distribuidos en 7 categorías; y de esos 50, 8 códigos axiales corresponden específicamente a Inteligencia Artificial.

En cuanto al manejo de la evidencia, los consentimientos, transcripciones y la codificación están alojados en una zona pública, mientras que los videos, audios y consentimientos originales permanecen cifrados con AES-256 en una zona restringida, protegiendo la confidencialidad de los participantes.

Quiero ser transparente sobre el rigor metodológico aplicado: recontamos íntegramente la codificación axial antes de esta entrega, y el total pasó de 47 a 50 códigos verificados. Además, corregimos una frecuencia que en un borrador previo del manuscrito se había reportado como 6 de 16, y que tras revisar participante por participante quedó correctamente establecida en 4 de 16.

El cuestionario cuantitativo cerró finalmente con 210 respuestas, ampliamente por encima de la meta mínima de 60 por perfil dominante, y las actas de member checking con los participantes P03, P09 y P15 ya están cargadas en el repositorio.

---

## Diapositiva 7 — Punto de saturación temática
**Habla: Amagua Sacón**

Esta gráfica muestra la acumulación de códigos axiales nuevos por entrevista, desde P01 hasta P16. Se observa una curva que crece rápidamente al inicio y se va aplanando hacia el final, lo cual es la señal clásica de saturación temática en investigación cualitativa.

Nuestro criterio de saturación establece que esta se alcanza cuando el promedio de códigos nuevos en las últimas tres entrevistas es menor o igual al 5% del total acumulado. En nuestro caso, ese promedio fue de 1.33 códigos nuevos entre las entrevistas P14 y P16, lo que representa apenas un 2.67% del acumulado final —claramente por debajo del umbral del 5%.

Con esta evidencia, concluimos que la saturación temática se sostiene con el conjunto final de 50 códigos axiales verificados, lo cual respalda la suficiencia de nuestra muestra de 16 entrevistas.

---

## Diapositiva 8 — Resultados: códigos axiales por categoría
**Habla: Barrionuevo Fuentes**

Esta gráfica distribuye los 50 códigos axiales en las 7 categorías identificadas. Historia clínica, Citas y comunicación, y Usabilidad y desempeño concentran 10 códigos cada una; Inteligencia Artificial reúne 8; Gestión administrativa y financiera, 5; Inventario, 4; y Seguridad, 3.

Quiero destacar que Inteligencia Artificial concentra 8 de los 50 códigos axiales totales, y que estos alimentan directamente el requisito de explicabilidad RNF-18, que es el foco central de este estudio.

Todo este análisis está respaldado por una trazabilidad completa: contamos con 64 filas en nuestra matriz de trazabilidad Necesidad → Requisito → Modelo → Implementación → Verificación, que permite seguir cada hallazgo cualitativo hasta su implementación concreta en el sistema.

---

## Diapositiva 9 — El requisito operacionalizado: RNF-18
**Habla: Vera Gómez (Modelador)**

Aquí presentamos el corazón de nuestra contribución: el RNF-18, de adecuación funcional para la explicabilidad de la IA. Este requisito establece que toda sugerencia generada por el sistema debe presentar los factores clínicos de entrada y el nivel de confianza, de una forma comprensible para alguien sin conocimientos técnicos en IA.

El criterio de verificación que definimos es concreto y medible: el 100% de las sugerencias deben mostrar al menos 3 factores de mayor peso y un indicador de confianza —alto, medio o bajo— visibles antes de que el veterinario tome una decisión.

Este requisito está trazado a los requisitos funcionales RF-17, RF-18 y RF-19, al caso de uso CU-06 —que se muestra en el diagrama de esta diapositiva— y a los registros de campo RC-17, RC-18 y RC-19.

Un dato relevante de nuestra codificación: el código axial "revisión obligatoria antes de aplicar la sugerencia de IA" aparece en 4 de las 16 entrevistas, una frecuencia que verificamos participante por participante.

---

## Diapositiva 10 — Discusión: qué significan estos hallazgos
**Habla: Mesías Quijije (Verificador)**

Estos hallazgos tienen implicaciones tanto para la investigación como para la práctica. Para la investigación, demostramos que la explicabilidad en el contexto veterinario pudo operacionalizarse con pocos elementos verificables —factores clínicos más nivel de confianza— sin necesidad de exigir explicaciones técnicas complejas sobre el funcionamiento interno del modelo de IA.

Para la práctica, el flujo de Aceptar, Modificar o Rechazar, con esos factores visibles, ofrece un punto de partida replicable para clínicas pequeñas que no cuentan con equipos de ciencia de datos propios.

El hallazgo que consideramos más llamativo es que solo 4 de los 16 participantes exigieron espontáneamente una revisión obligatoria antes de aplicar la sugerencia de IA. Esto nos permite argumentar que la exigencia normativa —pensemos en la LOPDP y en la ética profesional— antecede a la demanda explícita del usuario; es decir, protegemos al paciente y al profesional incluso cuando el usuario no lo pide directamente.

Es importante delimitar el alcance: estas conclusiones se restringen al módulo de IA diagnóstica de SGCV-IA y a la clínica veterinaria estudiada; no las generalizamos a otros dominios clínicos.

---

## Diapositiva 11 — Amenazas a la validez
**Habla: Mesías Quijije**

Como equipo, identificamos y documentamos de forma proactiva cinco amenazas a la validez de este estudio.

En validez interna, la codificación abierta inicial fue realizada por el equipo sin una doble codificación independiente completa. Como mitigación, recontamos la codificación axial en su totalidad antes de esta entrega, corrigiendo el conteo de 47 a 50 códigos.

En validez externa, el estudio se realizó en una sola clínica veterinaria ecuatoriana, con un número acotado de participantes. Por ello, restringimos los hallazgos a ese contexto específico y proponemos réplicas en otras clínicas como trabajo futuro.

En validez de constructo, operacionalizamos "explicabilidad" únicamente como factores de peso más nivel de confianza, lo cual es un subconjunto del marco teórico de Chazette et al. Documentamos explícitamente qué dimensiones de ese marco no fueron cubiertas. En el cuestionario cuantitativo, además, la variable "frecuencia de uso" no estaba disponible tal como se había registrado en el protocolo, por lo que la sustituimos por la pregunta sobre frecuencia de inconvenientes en la clínica; declaramos esta sustitución explícitamente porque cambia el constructo medido.

En validez de conclusión, habíamos diseñado una validación cuantitativa de dos rondas, registrada en el protocolo OSF, pero no llegamos a ejecutarla dentro del plazo del proyecto; nuestras conclusiones principales se restringen a las 16 entrevistas cualitativas. Adicionalmente, el cuestionario sí permitió comparar los cuatro perfiles de usuario mediante Wilcoxon con corrección de Holm, pero dos de esos subgrupos son pequeños —cinco participantes en el perfil administrador, comparado contra once y contra veintiséis en otros perfiles—, lo que produce intervalos de efecto demasiado amplios para sostener una conclusión sobre la magnitud real de la diferencia. Reportamos esos resultados con fines de transparencia, no como hallazgo concluyente.

---

## Diapositiva 12 — Conclusiones y trabajos pendientes
**Habla: Marcillo Ponce**

Respondiendo directamente a nuestra pregunta de investigación: sí es posible derivar, a partir de trabajo de campo real, requisitos de explicabilidad verificables. Concretamente, el RNF-18 establece que basta con mostrar los factores de mayor peso y un nivel de confianza antes de que el veterinario decida sobre una sugerencia de IA.

En cuanto a trabajos pendientes, el alcance planteado para esta entrega se cumplió en su totalidad; la única salvedad honesta es la ya mencionada sobre los subgrupos pequeños del cuestionario, que dejamos como línea de trabajo futuro con una muestra ampliada.

Nuestras contribuciones quedan así consolidadas: un requisito no funcional de explicabilidad trazado en el ERS, un MVP con el flujo completo de Aceptar, Modificar y Rechazar, y un paquete de datos con DOI en Zenodo y registro en OSF.

---

## Diapositiva 13 — Estado declarado de los artefactos
**Habla: Marcillo Ponce**

Para cerrar con total transparencia, presentamos el estado de cada artefacto del proyecto. Está completo el ERS/SRS versión 2.0, la evidencia de campo con las 16 entrevistas, el modelado y la trazabilidad, el MVP funcional, el registro en OSF, el DOI en Zenodo y el identificador de Software Heritage. También está completa la carga de datos crudos y procesados, el manuscrito final y las actas de member checking en el repositorio.

Los scripts de análisis están completos y son reproducibles en su totalidad: la cadena en R —importación, limpieza, curva de saturación, descriptivos, contraste de hipótesis y tamaño del efecto— corre con una sola orden desde un clon limpio del repositorio y reproduce exactamente los resultados ya publicados. La única reserva honesta que mantenemos es la ya declarada en validez de conclusión: los subgrupos pequeños del cuestionario deben leerse como exploratorios, no como evidencia concluyente.

---

## Diapositiva 14 — Demostración del prototipo (MVP)
**Habla: Vera Gómez**

A continuación realizaremos una demostración en vivo del MVP. El flujo que verán consta de cuatro pasos: primero, el login por rol; segundo, el acceso a la ficha del paciente; tercero, la generación de una sugerencia de IA junto con sus factores clínicos y su nivel de confianza; y cuarto, la decisión del veterinario de Aceptar, Modificar o Rechazar esa sugerencia.

El despliegue se realiza con docker compose up dentro de la carpeta 05_MVP. La arquitectura combina un frontend en React de archivo único con un backend en Node.js, Express y SQLite, con persistencia real de datos.

Las credenciales que usaremos son cuentas de demostración documentadas en el README del MVP; en ningún momento se trata de credenciales reales de la clínica cliente.

Con este prototipo cubrimos los requisitos funcionales de prioridad Must-have: login (RF-24), historial clínico (RF-02 y RF-03), consulta (RF-04), facturación (RF-07 y RF-08), agenda (RF-11), sugerencias de IA (RF-17, RF-18 y RF-19), y auditoría (RF-23).

[Aquí se ejecuta la demostración en vivo del sistema]

---

## Diapositiva 15 — Cierre
**Habla: Marcillo Ponce**

Con esto concluye la presentación de nuestro proyecto SGCV-IA. Todos los artefactos del estudio son públicos y verificables: el repositorio en GitHub, en github.com/gleiston-guerrero/SGCV-IA; el conjunto de datos con DOI en Zenodo, 10.5281/zenodo.22558095; y el protocolo de registro previo en el Open Science Framework, en osf.io/r5p8d.

Agradecemos al tribunal por su tiempo y atención, y quedamos atentos a sus observaciones.

---
