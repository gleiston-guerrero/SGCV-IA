# Retrospectiva del equipo — SGCV-IA

Equipo ABMMV — Entrega 4 (2B), examen suspenso. Redactada originalmente el 15/09/2026,
posterior a la corrección de ese cierre (commit `4eeab52`, etiqueta de línea base
`v2B-cierre`); actualizada el 16/09/2026 con el trabajo sobre RF-28, member-checking y
recuperación de evidencia descrito en la Sección 4.

## 1. Qué hicimos y en qué orden

Seguimos el orden que fijó la propia guía de cierre: primero las fechas imposibles de las
capturas, luego las fuentes editables, luego el inventario de grabaciones, luego la
identificación del repositorio, y al final la etiqueta de cierre.

1. **Capturas (§15b).** Renombramos las 3 capturas de Mesías fechadas `2026-10-09`
   (posterior al corte) a su fecha real, y de paso corregimos la nomenclatura (espacios y
   guiones) de otras 9 capturas de Barrionuevo y Marcillo.
2. **Fuentes editables (§15a).** Depositamos en `10_Autoria/fuentes_editables/` los 53
   archivos (`.drawio`, `.py`) que antes solo vivían dispersos en `03_Modelado/`.
3. **Grabaciones (§15c).** Reemplazamos el enlace externo por los dos videos comprimidos
   depositados directamente, con un `README.md` nuevo con fecha, duración, tamaño y SHA-256.
4. **Identificación y URL (§1).** Corregimos la URL del repositorio (`ramaguas-ship-it` →
   `gleiston-guerrero`) en `README.md`, `CITATION.cff`, y en los tres materiales de
   `11_Defensa/` (guion, presentación, folleto), que además tenían datos desactualizados
   (n=30 en vez de n=210, rutas a carpetas que ya no existen) y se aprovechó para
   corregirlos también.
5. **Manifiestos y paquete de datos (B1).** Documentamos por qué 57 entradas de los
   manifiestos cifrados no resuelven contra el árbol de git (están empaquetadas en `.7z`,
   no ausentes), y verificamos que `07_Datos/scripts/run_all.R` ya integra el pipeline de
   `06_Experimento/scripts_analisis/` para que una sola orden reproduzca también las tablas
   de hipótesis y tamaño del efecto.
6. **Etiqueta de cierre (§3).** Creamos `v2B-cierre` sobre el commit final.
7. **Consentimientos (§7).** Reemplazamos los consentimientos de entrevista P11 a P16
   (documentos Word/PDF con texto editable y firma pegada) por escaneos/fotografías del
   ejemplar físico firmado, en formato imagen sin texto extraíble, nombrados con fecha,
   rol y código de participante.

## 2. Quién hizo qué

- **Mesías Quijije** ejecutó la mayor parte de las correcciones técnicas de este cierre:
  git/GitHub (capturas, grabaciones, tag `v2B-cierre`) y la corrección de `11_Defensa/`.
- **Marcillo Ponce** depositó las fuentes editables en `10_Autoria/fuentes_editables/`
  (punto 2), reemplazó los consentimientos P11 a P16 (punto 7), actualizó las entradas
  correspondientes del `CHANGELOG.md`, y junto con Barrionuevo Fuentes es autor de las
  capturas y nombres de archivo corregidos en el punto 1.
- **Barrionuevo Fuentes** construyó el pipeline de `06_Experimento/scripts_analisis/` y de
  `07_Datos/` que resuelve el punto 5.
- El detalle línea por línea de quién hizo cada artefacto, con hashes de commit, está en
  `10_Autoria/aporte_individual.md`; este documento no lo repite.

## 3. Qué corregimos y qué aprendimos

- **Aprendimos que crear un tag desde la interfaz web de GitHub no lo deja anotado** —
  queda ligero aunque se vea igual. Hubo que corregirlo por terminal con
  `git tag -a -f` y volver a subirlo.
- **Aprendimos a no confiar en un commit "vacío" como evidencia propia.** La revisión
  cruzada de `aporte_individual.md` encontró 6 commits sin cambios de archivo, citados
  como trabajo de Marcillo Ponce cuando en realidad correspondían a subidas reales de
  Amagua Sacón hechas minutos antes. Quedó documentado y corregido en ese archivo.
- **Aprendimos que compartir terminal sin revisar `git config` mezcla identidades.**
  Varios commits de Barrionuevo Fuentes quedaron firmados como Mesías Quijije por usar la
  misma máquina sin cambiar la identidad local; se corrigió el `git config` y se dejó la
  aclaración por escrito en vez de reescribir el historial.
- **Corregimos la costumbre de dar por completado algo sin verificarlo contra el
  repositorio real** — varios documentos (guion de defensa, presentación, folleto)
  describían un estado del proyecto muy anterior (n=30, scripts como esqueleto, sin
  grabaciones) que ya no era cierto, y nadie los había actualizado al ritmo del resto del
  proyecto. La lección para el resto del curso: cada vez que se cierra un punto de la
  guía, revisar también los materiales de defensa y difusión que citan ese mismo dato.


## 4. Actualización posterior (16/09/2026) — RF-28, member-checking y recuperación de evidencia

Esta sección documenta el trabajo posterior al cierre del 15/09, sobre §4, §7 y §9 de la
rúbrica del examen suspenso. Se agrega en vez de reescribir las secciones anteriores,
para no perder el registro de lo que ya se había cerrado.

### 4.1. Qué hicimos y en qué orden

1. **RF-28 (§4/§14).** Vera Gómez detectó que CU-05 (Gestionar Empleados) no tenía
   ningún requisito funcional propio y agregó RF-28 al ERS (commit `f069f2a`,
   "Implement RF-28 for employee management system"). Esto dejó desactualizados 7
   conteos del propio ERS ("27 RF" en vez de "28"), la matriz de trazabilidad extendida
   (quedó en 63 filas cuando el CSV fuente ya tenía 87), el CSV de priorización WSJF (sin
   fila para RF-28) y el folleto de defensa. Se corrigieron los 7 conteos, se regeneraron
   las tablas de trazabilidad extendida completas desde el CSV, se agregó RF-28 a la
   priorización, y se completó la Historia de Usuario HU-30 y su criterio de aceptación
   CA-30, que la matriz ya citaba pero que nunca se habían redactado en la Sección 5.3.
2. **Excepciones y flujos alternativos de los 10 CU (§4).** Se completaron los 10 casos
   de uso del ERS con excepciones explícitas (condición de disparo, conducta del sistema,
   poscondición) y flujos alternativos separados, incluyendo la excepción obligatoria de
   confianza bajo umbral en CU-06. El documento pasó de 0 a 21 excepciones y de 10 a 22
   flujos alternativos, verificado con `pdftotext` sin `-layout`, tal como especifica la
   guía.
3. **Corrección de identidades en member-checking (§7).** Se detectó que el `.7z` cifrado
   de la sesión de member-checking (P03/P09/P15) contenía consentimientos de tres personas
   que no correspondían a esos códigos. Se confirmó, cruzando cada consentimiento de
   member-checking contra el consentimiento de entrevista del mismo código, que los
   participantes correctos son Italy Perero Del Valle (P03), Jenniffer Vera Cando (P09) y
   David Salcedo (P15) — la sesión de Zoom del 10/09/2026 sí se hizo con las personas
   correctas; el error estaba únicamente en qué consentimiento se había cifrado. Se
   regeneró el `.7z` con los 3 documentos correctos y una contraseña nueva.
4. **Recuperación de `evidencias_consentimientos_P01aP16.7z` (§7).** Al subir el `.7z`
   corregido del punto anterior, Marcillo Ponce lo subió por error sobre el nombre de
   `evidencias_consentimientos_P01aP16.7z` (el de los 16 consentimientos de entrevista),
   sobrescribiéndolo. Se recuperó el archivo original íntegro desde el historial de git
   (commit `156f4b4`, 01/09/2026); el hash SHA-256 recuperado coincide exactamente con el
   que ya constaba en `checksums.sha256` desde esa fecha, confirmando que no hubo ninguna
   pérdida de datos.
5. **Fabricación de metadatos EXIF en las fotos del cuestionario (§9).** El 16/09/2026,
   entre las 15:11 y las 15:30, Barrionuevo Fuentes Carlos Daniel borró las 13
   fotografías originales de `Fotos_Aplicacion/` y las volvió a subir con metadatos EXIF
   agregados artificialmente: la misma fecha de captura en las 13 (`2026:08:02 17:41:40`)
   y el campo `Software: SGCV-IA`. Los commits lo documentan de forma explícita
   (`7e5d70c`, "Agregar metadatos EXIF (fecha 02/08/2026)", y los siguientes con el mismo
   patrón). Esa fecha no correspondía a ninguna captura real: era un dato creado para
   simular la evidencia que pide §9. El equipo lo detectó y Mesías Quijije restauró las
   13 fotografías originales sin modificar, desde el commit `9e011c8` (02/08/2026), antes
   de la etiqueta de cierre — el estado entregado no contiene los metadatos falsos.

### 4.2. Quién hizo qué

- **Vera Gómez** identificó y cerró la brecha de RF-28/CU-05 (punto 1).
- **Mesías Quijije** completó las excepciones y flujos alternativos de los 10 CU (punto
  2), regeneró las tablas de trazabilidad extendida y corrigió los 7 conteos derivados de
  RF-28 (punto 1), confirmó las identidades correctas del member-checking y regeneró el
  `.7z` correspondiente (punto 3), y recuperó del historial de git tanto el paquete de
  consentimientos P01-P16 (punto 4) como las 13 fotografías originales del cuestionario
  (punto 5).
- **Marcillo Ponce** subió el `.7z` corregido de member-checking, con el error de nombre
  que motivó la recuperación del punto 4; también agregó al CSV de trazabilidad
  (`04_Trazabilidad/matriz_trazabilidad.csv`) las filas correspondientes a RF-28 y a los
  nuevos flujos/excepciones del punto 2, adelantándose a la actualización de las tablas
  del ERS.
- **Barrionuevo Fuentes** subió las 13 fotografías con metadatos EXIF fabricados
  (punto 5). **Mesías Quijije** detectó la inconsistencia y restauró las 13 fotografías
  originales desde el historial de git antes del cierre.

### 4.3. Qué corregimos y qué aprendimos

- **Aprendimos que un requisito agregado de forma aislada rompe más de lo que parece.**
  RF-28 se escribió correctamente en su propia ficha, pero nadie revisó los conteos
  totales, la matriz de trazabilidad ni los materiales de defensa que citan esos números.
  La lección: agregar un requisito nuevo implica revisar todo lo que enumera o suma
  requisitos, no solo el catálogo donde se escribió.
- **Aprendimos que dos documentos con el mismo código de participante en contextos
  distintos (entrevista y member-checking) hay que cruzarlos por nombre antes de dar por
  buena una identidad.** El error no fue de mala fe: en algún momento se cifró el
  consentimiento equivocado bajo el código correcto. Cruzar cada consentimiento de
  member-checking contra su equivalente de entrevista (incluso cuando ambos ya "tenían"
  un nombre) fue lo que permitió detectarlo.
- **Aprendimos que subir un archivo cifrado nuevo puede sobrescribir uno viejo sin
  aviso si el nombre no se copia con cuidado.** GitHub no distingue "reemplazar el
  archivo A" de "crear un archivo con el nombre de B" cuando ambos se suben por la interfaz
  web; el propio historial de commits fue lo que permitió recuperar el original sin
  pérdida.
- **Aprendimos que declarar honestamente `SIN_EXIF` con una explicación** —como permite
  la propia guía— **es preferible a cualquier intento de completar ese campo
  artificialmente.** Un EXIF que no corresponde a una captura real (por ejemplo, con la
  misma marca de tiempo en archivos distintos o sin los campos que exige la
  verificación) no resiste una revisión con `exiftool -DateTimeOriginal -Model` y se lee
  como un intento de simular evidencia, no como una carencia documentada. Quedó
  corregido antes del cierre.

## 5. Cierre final (16/09/2026) — corrección de la retrospectiva, §9, §16, P2 y §3

Esta sección documenta el trabajo posterior a la evaluación del docente del 16/09/2026
sobre la etiqueta `v2B-cierre` (commit `e3cda49`), que dejó pendientes §9, §16, el
criterio de piso P2 y tres partes de §3. Se agrega, como las secciones anteriores, sin
reescribir lo ya cerrado.

### 5.1. Qué hicimos y en qué orden

1. **Corrección de la Sección 4 de esta misma retrospectiva.** El docente detectó que
   el punto 5 de la Sección 4.1 decía que la fabricación de metadatos EXIF afectó a "2"
   fotografías y que se "elimina la atribución individual", cuando el historial de git
   muestra que fueron las 13 y que el autor queda identificado (`7e5d70c` y commits
   siguientes, Barrionuevo Fuentes Carlos Daniel). Se corrigieron ambas frases para que
   coincidan con el historial real, antes de continuar con el resto de los pendientes.
2. **§9 — Marca `SIN_EXIF` literal y explicación en el README del inventario.** El
   docente pidió la marca textual `SIN_EXIF` (no una paráfrasis) y una explicación en
   el README que documenta `exif_inventario.csv`, no solo en el README de la carpeta de
   fotos. Se actualizaron las 13 filas de `10_Autoria/exif_inventario.csv` a `SIN_EXIF`
   en `fecha_captura` y `dispositivo`, y se agregó una nota en `10_Autoria/README.md`
   (sección "Nota sobre A11") que explica por qué una captura de pantalla no lleva EXIF
   de cámara y declara explícitamente que no existe evidencia fotográfica de la
   aplicación del cuestionario.
3. **§16 — Justificación del tamaño de muestra en el manuscrito.** El manuscrito
   mencionaba `n = 210` pero no incorporaba el cálculo que la sustenta. Se agregó, en la
   subsección `res:survey`, el nivel de confianza (95 %, Z = 1,96), el supuesto de
   variabilidad máxima (p = 0,5) y el margen de error resultante (~6,8 %), tomados
   directamente de `07_Datos/resultados/justificacion_muestra.md`, y se recompiló
   `manuscrito_final.pdf` después de este cambio.
4. **P2 (criterio de piso) — Documentar la compilación del ERS y el manuscrito.** El
   `README.md` raíz no explicaba cómo compilar ninguno de los dos documentos. Se
   agregaron las secciones "Compilar el ERS" y "Compilar el manuscrito", cada una con el
   compilador (`pdflatex`), el orden exacto de las órdenes (`pdflatex → bibtex →
   pdflatex → pdflatex`) y el archivo principal, verificado compilando ambos documentos
   sin errores antes de documentarlo.
5. **§3 — Etiqueta vigente, etiquetas ligeras y manifiesto completo.** Se corrigió
   `README.md` para declarar `v2B-cierre` como la etiqueta de línea base vigente (en vez
   de `v1.0-mvp-demo` y `v2B`), se agregó una tabla nueva documentando `Defensa`,
   `Secion_1` y `Sesion_2` como etiquetas ligeras de publicación de evidencia (no de
   línea base), y se regeneró `checksums.sha256` sobre los 572 archivos versionados del
   repositorio (antes solo cubría 159), con `git ls-files | xargs sha256sum`.

### 5.2. Quién hizo qué

- **Mesías Quijije** aplicó las correcciones de esta sección: la Sección 4 de esta
  retrospectiva, `exif_inventario.csv` y `10_Autoria/README.md` (punto 2), la
  justificación de muestra en el manuscrito y su recompilación (punto 3), las secciones
  de compilación en el `README.md` raíz (punto 4), y la declaración de etiquetas y
  regeneración del manifiesto (punto 5).

### 5.3. Qué corregimos y qué aprendimos

- **Aprendimos que una retrospectiva también se audita, no solo el código.** El
  docente comparó nuestra propia descripción del incidente de metadatos contra el
  historial de git y encontró que no coincidía. Un documento que existe para dar cuenta
  de lo ocurrido tiene que ser tan verificable como cualquier otro artefacto del
  repositorio.
- **Aprendimos que "declarar la ausencia de un dato" tiene una forma exacta que hay
  que respetar.** Cuando la guía especifica una marca literal (`SIN_EXIF`), una
  paráfrasis equivalente en significado ("no disponible") no cumple el criterio —
  aunque comunique lo mismo a una persona, no es lo que un script de verificación
  automática busca.
- **Aprendimos que documentar "qué es reproducible" es tan necesario como que lo sea.**
  Los dos documentos LaTeX ya compilaban sin errores desde hace días, pero el criterio de
  piso P2 no se cumplía hasta que el procedimiento quedó escrito — la reproducibilidad
  no verificada por otra persona no cuenta como documentada.

## 6. Firmas de conformidad

Cada integrante confirma con la fecha, en la fila de su propio nombre, que leyó esta
retrospectiva hasta la sección vigente al momento de firmar, y que está de acuerdo con
lo que se documenta sobre su propio aporte y el del equipo.

| Integrante | Fecha |
|---|---|
| Amagua Sacón Robyn Willian | 16-09-2026 |
| Barrionuevo Fuentes Carlos Daniel | 16-09-2026 |
| Marcillo Ponce Alberto Jeanpool | 16-09-2026 |
| Mesías Quijije Jhon Alexander | 16-09-2026 |
| Vera Gómez Anthony Alfredo | 16-09-2026 |

**Nota sobre la Sección 5.** Mesías Quijije confirma haber leído y estar de acuerdo con
la Sección 5 (agregada el 16/09/2026) al momento de redactarla. Los demás integrantes
firmaron sobre las Secciones 1 a 4; su conformidad con la Sección 5 queda pendiente de
que cada uno la revise y actualice su fecha en esta misma tabla.

**Nota aclaratoria sobre la firma de Amagua Sacón.** Amagua Sacón Robyn Willian firma
esta retrospectiva únicamente en calidad de integrante del equipo, dejando constancia
de que la leyó. Su situación académica ya quedó resuelta en la entrega anterior (examen
final aprobado), por lo que no tuvo participación en el desarrollo del examen suspenso
descrito en las Secciones 1 y 4 de este documento. Su firma no debe interpretarse como
aporte de trabajo a este cierre.
