# 07_Datos — Datos y pipeline de análisis del proyecto SGCV-IA

## 1. Descripción

Esta carpeta contiene los datos utilizados y los resultados generados para el análisis empírico del proyecto **SGCV-IA**.

El conjunto de datos integra dos fuentes principales:

- **Encuesta cerrada:** 210 respuestas obtenidas mediante Google Forms.
- **Entrevistas semiestructuradas:** 16 transcripciones identificadas como P01–P16.

La carpeta separa los **datos crudos**, los **resultados procesados**, los **scripts reproducibles** y los archivos de **trazabilidad, calidad e integridad**.

---

## 2. Estructura

```text
07_Datos/
├── datos_crudos/
│   ├── encuesta_respuestas_crudas.csv
│   └── Entrevistas/
│       ├── ..._P01_Entrevista.md
│       ├── ..._P02_Entrevista.md
│       └── ..._P16_Entrevista.md
│
├── datos_procesados/
│   └── perfil_participantes_agregado.csv
│
├── resultados/
│   ├── conteo_codigos_categorias.csv
│   ├── curva_saturacion.csv
│   ├── encuesta_limpia.csv
│   ├── encuesta_procesada.csv
│   ├── justificacion_muestra.md
│   ├── perfil_participantes_agregado.csv
│   ├── reporte_limpieza.md
│   ├── saturacion_reporte.md
│   ├── transcripciones_completas.rds
│   ├── transcripciones_limpias.rds
│   └── transcripciones_metadata.csv
│
├── scripts/
│   ├── importar_datos.R
│   ├── conteo_codigos.R
│   ├── curva_saturacion.R
│   ├── justificacion_muestra.R
│   ├── generar_checksums.R
│   └── run_all.R
│
├── diccionario_datos.csv
├── desviaciones.md
├── registro_deposito.md
├── checksums_datos.sha256
├── LICENSE-DATA.txt
└── README.md
```

---

## 3. Datos crudos

### Encuesta

`datos_crudos/encuesta_respuestas_crudas.csv`

Contiene las respuestas originales de la encuesta. La encuesta tiene **210 participantes** y conserva los nombres de las variables exportadas por Google Forms.

Incluye variables demográficas, percepción sobre la gestión de clínicas veterinarias, importancia de sistemas informáticos, utilidad de recordatorios digitales, aceptación del uso de IA y preguntas abiertas.

> **Importante:** el archivo crudo contiene la variable `Nombre completo del participante`, que constituye un dato personal identificable. No debe publicarse ni compartirse fuera del entorno autorizado.

### Entrevistas

`datos_crudos/Entrevistas/`

Contiene **16 transcripciones**, correspondientes a los participantes P01–P16.

Los archivos utilizan la fecha y el identificador del participante en su nombre:

```text
YYYY-MM-DD_Transcripcion_PXX_Entrevista.md
```

Las transcripciones constituyen material cualitativo crudo y deben revisarse para detectar posibles nombres u otros datos identificables antes de una publicación.

### Herramienta y procedimiento de transcripción (declaración de uso de IA)

Las 16 entrevistas (P01–P16) se transcribieron con **TurboScribe** (turboscribe.ai), una herramienta de transcripción automática basada en reconocimiento de voz por IA. El audio o vídeo original de cada entrevista se subió a la plataforma y se descargó la transcripción generada en formato de texto.

Sobre la salida automática de TurboScribe, el equipo aplicó los siguientes ajustes manuales antes de guardar la versión final en `02_Evidencias/Transcripciones/`:

- Etiquetado de turnos de hablante (`Entrevistador:` / `P0X:`), no incluido tal cual por la herramienta.
- Revisión ortográfica y de puntuación del texto generado automáticamente.

**Pendiente de completar por el equipo:** declarar si además se removieron muletillas, pausas, repeticiones u otras ediciones de contenido, y si se conservó una copia de la transcripción automática sin editar junto a la versión revisada (requerido por la tarea B1 del plan de mejora de datos). A la fecha de este README, **no se ha verificado que exista una copia sin editar de la salida original de TurboScribe** para cada participante — esto debe resolverse antes de dar por cumplida la tarea B1.


---

## 4. Datos procesados y resultados

### Procesamiento de la encuesta

`resultados/encuesta_procesada.csv`

Es la encuesta importada mediante `scripts/importar_datos.R`, conservando los nombres originales de las columnas.

`resultados/reporte_limpieza.md` documenta los controles realizados:

- Filas 100 % duplicadas eliminadas: **0**
- Marcas temporales duplicadas: **0**
- Columnas con valores faltantes: **ninguna**
- IDs de participantes duplicados en entrevistas: **ninguno**
- Transcripciones con menos de 300 palabras: **ninguna**

### Perfil agregado

`resultados/perfil_participantes_agregado.csv`

Contiene únicamente estadísticas agregadas del perfil de los participantes. No incluye nombres ni información destinada a reidentificar personas.

### Conteo de códigos

`resultados/conteo_codigos_categorias.csv`

Resume la codificación temática:

- **167 códigos abiertos**
- **50 códigos axiales**
- **7 categorías consolidadas**

Las categorías consolidadas son:

1. Citas y comunicación con propietarios
2. Historia clínica y gestión de pacientes
3. Usabilidad y desempeño
4. Inteligencia Artificial
5. Gestión administrativa y financiera
6. Inventario
7. Seguridad

El cálculo se realiza desde las tablas de codificación de `02_Evidencias/Codificacion_Tematica/`, no copiando cifras de reportes previos.

### Saturación temática

`resultados/curva_saturacion.csv` y `resultados/saturacion_reporte.md`

La curva de saturación se calcula siguiendo el orden P01–P16.

- Códigos axiales finales: **50**
- Códigos nuevos promedio en P14–P16: **1,33**
- Porcentaje respecto del acumulado final: **2,67 %**
- Umbral utilizado: **5 %**
- Resultado: **se sostiene el criterio de saturación**

### Tamaño de muestra

`resultados/justificacion_muestra.md`

La encuesta cuenta con:

- `n = 210`
- Confianza: **95 %**
- `Z = 1,96`
- `p = 0,5` como escenario conservador
- Margen de error aproximado: **6,8 %**

Con los mismos supuestos, se habrían requerido aproximadamente 97 respuestas para un margen de error del 10 %; la muestra obtenida (210) supera ese umbral con holgura.

---

## 5. Diccionario de datos

`diccionario_datos.csv`

Documenta las variables de la encuesta y las transcripciones, incluyendo:

- nombre de la variable;
- tipo de dato;
- unidad o escala;
- valores posibles;
- tratamiento de datos faltantes;
- procedencia;
- observaciones metodológicas.

Este archivo debe consultarse antes de interpretar o transformar una variable.

---

## 6. Scripts y reproducibilidad

Los scripts utilizan **R base**, evitando dependencias externas siempre que sea posible.

### Pipeline completo

Desde la raíz del repositorio:

```bash
Rscript 07_Datos/scripts/run_all.R
```

El pipeline ejecuta, en orden:

1. `importar_datos.R`
2. `conteo_codigos.R`
3. `curva_saturacion.R`
4. `justificacion_muestra.R`

Los resultados generados se guardan en:

```text
07_Datos/resultados/
```

### Importación

```bash
Rscript 07_Datos/scripts/importar_datos.R
```

Lee la encuesta y las 16 entrevistas desde `datos_crudos/` y genera los archivos estructurados necesarios para el análisis.

El script de importación **no modifica los datos crudos**.

### Conteo de códigos

```bash
Rscript 07_Datos/scripts/conteo_codigos.R
```

Calcula los códigos abiertos y axiales a partir de las tablas de codificación temática del proyecto.

### Curva de saturación

```bash
Rscript 07_Datos/scripts/curva_saturacion.R
```

Calcula la aparición acumulada de códigos axiales y evalúa el criterio de saturación establecido.

### Justificación de muestra

```bash
Rscript 07_Datos/scripts/justificacion_muestra.R
```

Calcula el margen de error de `n = 210` y genera el perfil agregado de participantes.

### Checksums

Después de ejecutar el pipeline:

```bash
Rscript 07_Datos/scripts/generar_checksums.R
```

Este script genera o actualiza:

- `checksums_datos.sha256`
- `registro_deposito.md`

---

## 7. Integridad de los datos

`checksums_datos.sha256` contiene hashes SHA-256 de los datos crudos y de los resultados considerados parte del depósito.

Para comprobar la integridad desde la raíz del repositorio:

```bash
sha256sum -c 07_Datos/checksums_datos.sha256
```

En Windows puede utilizarse el mismo comando desde Git Bash.

Si un archivo incluido en el checksum cambia, se debe volver a ejecutar:

```bash
Rscript 07_Datos/scripts/generar_checksums.R
```

---

## 8. Privacidad y protección de datos

Los datos crudos pueden contener información personal identificable.

Por ello:

- No publicar `Nombre completo del participante`.
- No utilizar nombres reales en tablas o resultados.
- Utilizar los identificadores P01–P16 para las entrevistas.
- Revisar las transcripciones antes de cualquier publicación para detectar nombres propios u otros datos identificables.
- Los resultados agregados deben mantenerse sin información que permita reidentificar a participantes individuales.

El archivo `perfil_participantes_agregado.csv` está diseñado para presentar resultados agrupados y no individuales.

---

## 9. Desviaciones del protocolo

Las desviaciones respecto del protocolo registrado se documentan en:

`desviaciones.md`

La principal desviación registrada corresponde al componente de **validación cuantitativa del Enfoque 3**, que estaba previsto en dos rondas con 12 participantes y finalmente no se ejecutó dentro del plazo del proyecto.

Esta ausencia debe considerarse como una limitación metodológica y no debe presentarse como si la validación cuantitativa hubiera sido realizada.

---

## 10. Trazabilidad del depósito

`registro_deposito.md` documenta el estado de los datos y resultados en el momento de generación de los checksums.

La combinación de:

- datos crudos;
- scripts;
- resultados;
- diccionario de datos;
- registro de desviaciones;
- checksums;

permite mantener una cadena básica de trazabilidad y reproducibilidad del análisis.

---

## 11. Archivos adicionales

En algunas versiones del repositorio pueden existir archivos de resultados adicionales, como:

- `encuesta_limpia.csv`
- `transcripciones_limpias.rds`

Estos archivos deben considerarse parte del depósito únicamente después de verificar que fueron generados por el pipeline vigente y, si corresponde, incorporarlos al proceso de generación de checksums.

---

## 12. Estado del conjunto de datos

**Estado:** depósito de datos para el proyecto SGCV-IA.

**Fuentes principales:** encuesta cerrada + entrevistas semiestructuradas.

**Encuesta:** `n = 210`.

**Entrevistas:** `P01–P16`.

**Códigos abiertos:** `167`.

**Códigos axiales:** `50`.

**Categorías consolidadas:** `7`.

**Saturación temática:** sostenida según el criterio documentado.

**Integridad:** verificada mediante SHA-256 para los archivos incluidos en `checksums_datos.sha256`.
