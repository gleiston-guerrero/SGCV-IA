# C5 — Doble codificación independiente a nivel de código axial

Reemplaza la versión de `resultado_doble_codificacion.md` que comparaba
presencia/ausencia de las 7 categorías amplias (κ=0,36, IC 95% [-0,32, 1,04]).
Esa versión no cumplía el criterio de aceptación del plan de mejora
("κ por código, no por presencia de categorías"): con solo 7 categorías,
que además corresponden a las 7 secciones del guion de entrevista, el
acuerdo esperado por azar ya era altísimo (pe=0,83), lo que deprimía el
kappa sin que aportara información real sobre fiabilidad.

## Método

- **Subconjunto codificado:** P02, P07, P13, P16 (25% del corpus).
- **Codificador 1:** Alberto Jeanpool Marcillo Ponce (codificación original,
  43 fragmentos).
- **Codificador 2:** Jhon Alexander Mesías Quijije (codificación
  independiente, 77 fragmentos), sin acceso previo a la codificación de
  Marcillo.
- **Unidad de comparación:** presencia/ausencia de cada **código axial**
  (el mismo codebook de 50 códigos usado en C1/C2), por participante — no
  las 7 categorías amplias. Se evita forzar un alineamiento fragmento a
  fragmento (los dos codificadores segmentaron distinto) clasificando cada
  fragmento de cada codificador, por separado, contra el mismo codebook
  fijo de 50 códigos; la comparación es sobre esa clasificación, no sobre
  los fragmentos en bruto.
- **Universo comparado:** 32 de los 50 códigos axiales — los que al menos
  un codificador marcó presente para al menos uno de los 4 participantes.
  Los 18 códigos restantes del codebook no aparecen para ninguno de los
  dos en este subconjunto y se excluyen para no inflar el acuerdo con
  ceros triviales.

## Resultado

| Métrica | Valor |
|---|---|
| N (participante × código axial) | 128 |
| Acuerdo observado | 81,25% (104/128) |
| Acuerdo esperado por azar | 50,84% |
| **Kappa de Cohen** | **0,619** |
| IC 95% | [0,481, 0,756] |

Nivel "moderado a sustancial" (Landis y Koch, 1977), con un intervalo de
confianza que no cruza cero — a diferencia de la versión por categoría,
sí permite afirmar con razonable precisión que el acuerdo es real y no
producto del azar.

## Los 24 desacuerdos

De los 24 desacuerdos, **22 son del mismo tipo**: Mesías marcó presente un
código que Marcillo no había extraído para ese participante (Marcillo=0,
Mesías=1). Solo 2 van en sentido contrario (Marcillo=1, Mesías=0):
"Registro de inventario en herramientas no integradas" (P02) y
"Condiciones de confianza en IA" (P16).

Esto es consistente con lo ya observado en la versión anterior de este
documento: **diferencia de cobertura/selección de fragmentos**, no de
interpretación del contenido. Mesías extrajo más fragmentos por
transcripción (77 vs. 43) y por lo tanto detectó más códigos; no hay
ningún caso en el que ambos codificadores hayan visto el mismo contenido
y lo hayan clasificado en códigos axiales incompatibles entre sí.

## Hallazgo adicional: cobertura del codebook

Al clasificar los fragmentos de Mesías contra el codebook de 50 códigos,
**16 de sus 77 fragmentos (≈21%)** no encajan con claridad en ningún
código axial existente — por ejemplo, contenido sobre orientación
nutricional verbal no estandarizada, ajuste remoto de medicación por
teléfono, o menciones de ausencia de un problema (conectividad estable,
revisión de inventario que sí funciona) que el codebook actual solo
registra en su forma positiva (el problema existe), no en su ausencia.
Esto no entra en el cálculo de kappa (no se fuerza a ningún código
existente), pero es un hallazgo legítimo de C1/C5 conjuntas: **el codebook
de 50 códigos, construido principalmente sobre la codificación de
Marcillo, no cubre por completo lo que un segundo codificador
independiente encuentra en las mismas transcripciones.**

## Limitación declarada

La clasificación de los fragmentos de ambos codificadores contra el
codebook de 50 códigos la hizo una tercera persona (no Marcillo ni
Mesías) aplicando el mismo criterio de contenido usado en C1. Es un paso
adicional de interpretación entre "lo que cada codificador escribió" y
"el código axial correspondiente", y por tanto una fuente de error
independiente de la fiabilidad Marcillo–Mesías que se quiere medir. Sería
preferible que cada codificador clasificara sus propios fragmentos
directamente contra el codebook de 50 códigos, sin este paso intermedio,
en una repetición futura del ejercicio.

## Archivos

- `kappa_codigo.py` — script reproducible: clasificación fija de ambos
  codificadores contra el codebook de 50 códigos, cálculo de kappa e IC.
- `resultado_kappa_codigo.csv` — tabla completa (128 filas) + estadísticos.
