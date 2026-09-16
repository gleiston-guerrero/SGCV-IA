# 04_Trazabilidad/

## Qué contiene esta carpeta

La cadena de trazabilidad completa del proyecto: desde los objetivos estratégicos y la base legal (LOPDP), pasando por interesados, requisitos, casos de uso, historias de usuario y criterios de aceptación, hasta el componente de software y el mockup que los implementa. Es el artefacto que la Sección 9.3 de la Guía de Entrega 4 usa para comprobar que "todo requisito del componente inteligente tiene métrica, unidad, umbral y método de verificación" y que "cada requisito... aparece en la matriz de trazabilidad, vinculado al elemento de diseño que lo realiza y al caso de prueba que lo verifica".

```text
04_Trazabilidad/
├── matriz_trazabilidad.csv           — cadena completa OE→Ley→Interesado→Requisito→CU→HU→CA→Componente→Mockup
├── Mapa_de_stakeholders.csv          — poder/interés de cada stakeholder (base de Organizacional_iStar/Matriz_Poder_Interes)
└── priorizacion_moscow_kano_valor.csv — priorización de RF/RNF (MoSCoW, Kano, valor de negocio, WSJF)
```

## matriz_trazabilidad.csv

**87 filas de datos** (cumple el mínimo de 60 filas exigido por el criterio C2 de la rúbrica). Columnas:

| Columna | Contenido |
|---|---|
| `ID_Trazabilidad` | Identificador único de la fila (`TR-01`...`TR-87`) |
| `Ley` / `Articulo` | Base legal cuando aplica (LOPDP y artículo específico; `—` si no aplica) |
| `Objetivo` | Objetivo Estratégico que atiende (`OE-01`, `OE-02`, `OE-03` o `Transversal`) |
| `Interesado` | Stakeholder relacionado (debe coincidir con `Mapa_de_stakeholders.csv`) |
| `EV` | Evidencia de campo que sustenta el requisito (`EV-01`...) |
| `RF_RNF_RD` | Requisito(s) involucrados: funcional (RF-), no funcional (RNF-) o de sistema/infraestructura (RST-) |
| `CU` | Caso de uso relacionado |
| `HU` | Historia de usuario relacionada |
| `CA` | Criterio de aceptación |
| `Componente` | Módulo de software que lo implementa |
| `Mockup` | Mockup de `03_Modelado/Mockups/` que lo ilustra (o "Transversal"/"No aplica") |

**Cobertura verificada** (contando identificadores distintos, no solo apariciones): **28 RF**, **21 RNF**, **10 RST** (requisitos de sistema/infraestructura transversales), **10 CU** y **29 HU** quedan referenciados al menos una vez en la matriz.

## Mapa_de_stakeholders.csv

8 stakeholders con columnas `Stakeholder, Poder, Interés, Clasificación, Estrategia de gestión`. Esta tabla es la fuente de datos del diagrama `03_Modelado/Organizacional_iStar/Matriz_Poder_Interes` — si se actualiza un stakeholder aquí, hay que regenerar también ese diagrama para que no queden desincronizados.

## priorizacion_moscow_kano_valor.csv

49 filas: los **28 RF y 21 RNF** priorizados (no incluye los 10 RST — ver nota abajo). Columnas: `ID, MoSCoW, Kano, Valor_de_Negocio, Estado, Criticidad_temporal, Reduccion_riesgo, Tamano, WSJF, Justificacion`. Distribución MoSCoW: 36 Must, 10 Should, 3 Could (ningún Won't).

## Por confirmar

Los **10 identificadores `RST-`** que aparecen en `matriz_trazabilidad.csv` (por ejemplo `RST-01`, ligado a "Infraestructura/Backend", interesado "Equipo de desarrollo") **no están priorizados** en `priorizacion_moscow_kano_valor.csv`, que solo cubre RF y RNF. Si `RST-` corresponde a requisitos puramente técnicos/de infraestructura que el equipo decidió no pasar por MoSCoW/Kano (porque no tienen valor de negocio directo para un stakeholder externo), conviene dejarlo dicho explícitamente aquí; si fue un olvido, hay que agregarlos a la priorización.
