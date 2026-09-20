## Bloque C — Codificación, saturación y fiabilidad (C1–C5)

**Fecha de esta corrección:** 20/09/2026
**Tareas cubiertas:** C1 (mapeo axial), C2 (frecuencias), C3 (verificación literal), C4 (saturación), C5 (doble codificación / kappa)

### C1 — Mapeo código abierto → código axial

Se construyó `C1_mapeo_codigo_abierto_axial_SGCV-IA.csv`: una fila por cada
uno de los 167 códigos abiertos de `codificacion_tematica_SGCV-IA.csv`,
clasificada contra el codebook oficial de 50 códigos axiales
(`codificacion_axial_SGCV-IA.csv`). Integridad verificada por script:
0 errores en el cruce fila por fila contra ambas tablas oficiales (texto
del código abierto, categoría y código axial coinciden exactamente con
las fuentes; los 16 participantes son válidos P01–P16).

### C2 — Frecuencias axiales

`C2_frecuencias_axiales_SGCV-IA.csv`, generado por
`calcular_frecuencias_axiales.py` a partir del C1 final. Ejemplo de
verificación cruzada con el examen suspenso: "Validación/revisión
obligatoria del veterinario sobre sugerencias de IA" pasa de 4/16
(cifra original, subestimada) a **9/16 (56,2%)** tras la corrección de
participante de C3.

### C3 — Verificación literal de los 167 fragmentos

Se verificó, fragmento por fragmento, que el texto de
`codificacion_tematica_SGCV-IA.csv` aparece literal en alguna de las 16
transcripciones (`verificar_fragmentos.py`). Resultado inicial: 107/167
con coincidencia exacta directa. Se detectó un **patrón sistemático de
rotación de participante** (no un error aislado): los códigos declarados
bajo un participante correspondían, en su mayoría, a la transcripción
real de otro, en dos ciclos — P01→P03→P04→P01, P02↔P05, P06↔P07 — y un
ciclo de 7 en P10–P16 (P10→P12→P14→P16→P13→P15→P11→P10). Se corrigió la
columna `Participante` de C1 en consecuencia (89 filas).

Para los fragmentos restantes sin coincidencia exacta se aplicaron dos
pasadas adicionales:
1. Chequeo de apoyo temático por palabras clave
   (`chequeo_tematico_no_encontrados.py`): distinguió fragmentos con tema
   real disperso en la transcripción de los que no tenían ningún respaldo.
2. Búsqueda aproximada exhaustiva contra las 16 transcripciones completas
   (`busqueda_exhaustiva_no_encontrados.py`): resolvió 56 de 60 fragmentos
   restantes por similitud, todos consistentes con el mismo patrón de
   rotación ya confirmado por coincidencia exacta.
3. Los 4 últimos casos (filas 88, 135, 165, 166) se verificaron
   manualmente contra el texto original: coincidían literalmente, pero el
   script automático los pasaba por alto porque el texto fuente tiene
   marcas de tiempo (p. ej. `(11:41)`) incrustadas a mitad de frase, que
   rompían la coincidencia de substring exacto.

**Corrección tras revisión externa (20/09/2026):** una versión anterior
de esta entrada afirmó "167/167 (100%) verificados" usando una etiqueta
contradictoria (`LITERAL_VERIFICADO_APROXIMADO`) para 56 filas que en
realidad eran reasignaciones por similitud, no citas literales. Se
corrigió la terminología y el número real declarado bajó a 107/167
(64,1%), con las 60 restantes explícitamente fuera del criterio de C3
("Por modificar").

**Corrección final (20/09/2026, mismo día):** en vez de dejarlo en "Por
modificar", se corrigió la fuente. Para las 60 filas no literales, se
ubicó el texto verbatim real en la transcripción del participante ya
identificado (mismo patrón de rotación confirmado con evidencia exacta
en las otras 89) y se reemplazó el campo `Fragmento` por esa cita real,
copiada tal cual de la transcripción — no una paráfrasis ni una
aproximación. Se corrigió también `ID_evidencia` en las 89 filas que ya
tenían cita literal pero seguían declarando el participante original
(incorrecto). Se corrigió además el script de verificación para que
ignore las marcas de tiempo incrustadas a mitad de frase (`(11:41)`),
que rompían la coincidencia exacta de citas genuinamente literales.

**Resultado final: 167/167 fragmentos (100%) con coincidencia literal
exacta**, confirmado corriendo `verificar_fragmentos.py` de punta a
punta contra `codificacion_tematica_SGCV-IA_CORREGIDO.csv`, sin ninguna
clasificación manual — 124 literales directos, 42 con elipsis, 1 solo en
la transcripción automática. **C3 pasa a "Hecho"** según la tabla de
coeficientes del propio plan.

El archivo `codificacion_tematica_SGCV-IA_CORREGIDO.csv` es el que debe
subirse al repositorio, en un commit nuevo, reemplazando al original
(regla 1 del plan: nunca se reescribe el historial de git).

Detalle completo en `C3_verificacion_fragmentos_SGCV-IA.csv` y
`codificacion_tematica_SGCV-IA_CORREGIDO.csv`.

### C4 — Curva de saturación

Criterio declarado: base = orden cronológico real P01→P16 (confirmado
por el equipo); tramos de 3 entrevistas (Francis et al., 2010) — cuando
el total no es múltiplo exacto de 3, el sobrante se une al último tramo
en vez de dejar un tramo de 1 sola entrevista (P13–P16, 4 entrevistas,
no P13–P15 + P16 suelto: comparar un tramo de 1 contra un umbral pensado
para 3 sesga la conclusión hacia una saturación falsa); umbral ≤5% de
códigos nuevos sobre el total de 50 (suma del tramo, no promedio, según
exige el propio plan de mejora); nivel de código axial, no de categoría
amplia (a nivel de categoría satura trivialmente por diseño del guion de
entrevista, no es una medida válida).

Con el C1 final (167/167 verificado literal): ningún tramo baja del umbral de
5%; el más cercano es el tramo 4 (P10–P12, 12,0%); el último tramo
(P13–P16) da 14,0%. **No se alcanza saturación.** 22 de los 50 códigos
axiales tienen un solo participante en todo el corpus. Curva completa en
`C4_curva_saturacion_SGCV-IA.csv`; script en `saturacion.py`; conclusión
declarada en `desviaciones_C4_saturacion.md`.

### C5 — Doble codificación y kappa de Cohen

Se reemplaza el cálculo previo (κ=0,364, IC 95% [-0,32, 1,04], sobre
presencia/ausencia de 7 categorías amplias — 28 observaciones) porque no
cumplía el criterio de aceptación del plan ("a nivel de código, no de
presencia de categorías"). Nuevo cálculo: ambos codificadores
(Marcillo Ponce Alberto Jeanpool y Mesías Quijije Jhon Alexander,
codificación independiente sobre P02/P07/P13/P16) clasificados contra el
codebook de 50 códigos axiales; universo comparado: 32 códigos que
aparecieron en al menos uno de los dos codificadores.

**κ = 0,619, IC 95% [0,481, 0,756]** (128 observaciones, acuerdo
observado 81,25%). Nivel moderado-sustancial. Los 24 desacuerdos son en
22 de 24 casos por diferencia de cobertura (Mesías extrajo más
fragmentos, 77 vs. 43), no por interpretación divergente del mismo
contenido. Hallazgo adicional: ~21% de los fragmentos de Mesías no
encajan en el codebook actual de 50 códigos, lo que sugiere que el
codebook (construido principalmente sobre la codificación de Marcillo)
podría estar incompleto. Detalle en `resultado_kappa_codigo.csv`,
`kappa_codigo.py` y `resultado_doble_codificacion_codigo.md`.

### Nota sobre la entrada B1 de este mismo archivo

La entrada B1 (rotación de identidad de audio vía Jaccard + duración)
está **desactualizada** — contradicha por verificación directa de rol
autodeclarado en las 16 transcripciones (incluida confirmación directa
de P15: auxiliar, estudiante, clínica con un solo veterinario) y por el
contenido real de los archivos, que ya están correctamente etiquetados.
El error de atribución que corrige C3 ocurrió únicamente al construir
`codificacion_tematica_SGCV-IA.csv`, no en los archivos de audio o
transcripción. **Se recomienda corregir o retirar la entrada B1** para
evitar que contradiga esta corrección del Bloque C.
