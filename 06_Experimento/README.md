# SGCV-IA — Sistema de Gestión para Clínicas Veterinarias con IA

Proyecto Fin de Curso · Ingeniería de Requerimientos [ISR-401] · 4to Nivel
Universidad Técnica Estatal de Quevedo (UTEQ) — Facultad de Ciencias de la Computación
**Entrega 4 (2B / Defensa Final) — Componente empírico**

## Descripción del sistema

SGCV-IA es un sistema real de gestión para clínicas veterinarias que centraliza historiales clínicos, inventario, facturación, citas y comunicación con los dueños de mascotas. Además, incorpora un módulo de sugerencias diagnósticas asistidas por Inteligencia Artificial (RF-17, RF-18, RF-19), con revisión y aprobación obligatoria del veterinario antes de aplicar cualquier sugerencia.

## Equipo

| Integrante                        | Rol en el proyecto                                                        |
| ---------------------------------- | -------------------------------------------------------------------------- |
| Anthony Alfredo Vera Gómez        | Responsable de C8 (Prototipo funcional MVP) y C9 (Protocolo experimental) |
| Robyn Willian Amagua Sacón        | Responsable de C7 (Recolección de datos de campo)                        |
| Barrionuevo Fuentes Carlos Daniel | Responsable de criterios y actividades de la Entrega 4 (2B)              |
| Marcillo Ponce Alberto Jeanpool   | Responsable de criterios y actividades de la Entrega 4 (2B)              |
| Mesías Quijije Jhon Alexander     | Verificador                                                               |

## Identificador OSF

El registro previo del protocolo está en `osf.io/r5p8d`, consistente ahora con el manuscrito (`09_Publicacion/title_page.tex`), `07_Datos/desviaciones.md`, el `README.md` raíz, `11_Defensa/guion.md` y `06_Experimento/prompts_llm/README.md`.

> Nota: esta unificación se hizo por consistencia interna entre los documentos del repositorio (todos apuntaban a `r5p8d` salvo tres archivos que decían `wkg32`). No se verificó de forma independiente contra el sitio de OSF, ya que su contenido se renderiza por JavaScript y no es accesible por una petición simple. Si alguno de los integrantes tiene acceso directo a la cuenta de OSF, vale la pena confirmarlo una vez más antes del envío final.

## Enlaces clave

| Recurso                             | Enlace                                                        |
| ------------------------------------ | --------------------------------------------------------------- |
| Documento ERS/SRS 2B                | [`01_ERS/ERS_SRS_2B_v2.0.pdf`](../01_ERS/ERS_SRS_2B_v2.0.pdf) |
| Documento ERS/SRS 2B en LaTeX       | [`01_ERS/ERS_SRS_2B_v2.0.tex`](../01_ERS/ERS_SRS_2B_v2.0.tex) |
| Repositorio del MVP                 | [`05_MVP/`](../05_MVP/)                                       |
| Registro previo del protocolo (OSF) | https://osf.io/r5p8d                                          |
| Registro previo en el repositorio   | [`OSF_Registration.pdf`](./OSF_Registration.pdf)              |
| Resultados                          | [`resultados/`](./resultados/)                                |
| Scripts de análisis                 | [`scripts_analisis/`](./scripts_analisis/)                    |
| Conjunto de datos (Zenodo)          | DOI `10.5281/zenodo.22558095`                                 |

## Componente empírico — Enfoque 3

Este proyecto trabaja el **Enfoque 3** (elicitación y validación de requisitos de explicabilidad) sobre el módulo de sugerencias diagnósticas asistidas por IA (RF-17/RF-18/RF-19), siguiendo el marco de Chazette y Schneider (2020) y Chazette, Brunotte y Speith (2021, 2022).

El protocolo de investigación y su registro previo constituyen la base del componente empírico. El registro previo fue realizado antes de la ejecución de las rondas de validación y se encuentra disponible en OSF y en el repositorio.

El documento del protocolo utilizado en el proyecto se encuentra en [`Protocolo_SGCV-IA_2A.pdf`](./Protocolo_SGCV-IA_2A.pdf). Aunque el archivo conserva la denominación **2A** por corresponder a la versión en la que fue elaborado, el presente README y la documentación principal corresponden a la **Entrega 4 (2B)**.

## Cómo reproducir el análisis

1. Los instrumentos aplicados (guion de entrevista, encuesta y consentimiento) se encuentran en [` instrumentos/`](./ instrumentos/).
2. Los resultados generados hasta ahora se encuentran en [`resultados/`](./resultados/) (curva de saturación temática).
3. Los scripts que generan las tablas y figuras se encuentran en [`scripts_analisis/`](./scripts_analisis/). Su estado está documentado en el `README.md` de esa subcarpeta (9 de 9 scripts implementados, integrados a `07_Datos/scripts/run_all.R`).
4. [`prompts_llm/`](./prompts_llm/) no aplica a este proyecto: corresponde a los Enfoques 1 y 2 de la guía, que involucran comparación directa con salidas de un LLM. El detalle está en el `README.md` de esa carpeta.

> El paquete de datos crudos y procesados (transcripciones, respuestas de cuestionario) vive en `07_Datos/`, fuera de esta carpeta.

## Estado de la Entrega 4 (2B)

* Trabajo de campo cerrado: 16 entrevistas y 210 respuestas de cuestionario (repartidas en 4 perfiles: Dueño(a) de mascota 80, Administrador(a) de clínica veterinaria 45, Médico veterinario(a) 43, Auxiliar o técnico veterinario 42; el perfil dominante ya supera el mínimo n≥60 — ver `07_Datos/resultados/justificacion_muestra.md`).
* Codificación temática cerrada y verificada: 50 códigos axiales en 7 categorías.
* Scripts de análisis completos (9 de 9 implementados).
* Manuscrito con contenido sustantivo en `09_Publicacion/`, con pendientes puntuales antes del envío.

## Estructura del repositorio

```text
06_Experimento/
├── README.md
├── OSF_Registration.pdf
├── Protocolo_SGCV-IA_2A.pdf
├── instrumentos/
├── resultados/
├── scripts_analisis/
└── prompts_llm/
```
