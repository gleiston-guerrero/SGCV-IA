# Registro de depósito de datos — SGCV-IA

Generado automáticamente por `07_Datos/scripts/generar_checksums.R` el 2026-09-15 20:49:11 UTC.

Este registro documenta el estado final de los datos crudos y los resultados
del pipeline de análisis en el momento del depósito. Si cualquiera de estos
archivos cambia después, hay que volver a correr este script para actualizar
tanto este registro como `checksums_datos.sha256`.

- Archivos de datos crudos (`07_Datos/datos_crudos/`): 17
- Archivos de resultados (`07_Datos/resultados/`): 14
- Total de archivos verificados: 31

## Verificación de integridad

Para comprobar que ninguno de estos archivos cambió después del depósito,
desde la raíz del repositorio:

```bash
sha256sum -c 07_Datos/checksums_datos.sha256
```

(en Windows, con Git Bash instalado, el mismo comando funciona igual)

## Detalle de checksums

| Archivo | SHA-256 |
|---|---|
| `07_Datos/datos_crudos/encuesta_respuestas_crudas.csv` | `9f13478ba78f9c9391db410ff0f8838b5e49b8c5ce6666a3bb991e57febb75e7` |
| `07_Datos/datos_crudos/Entrevistas/2026-05-26_Transcripcion_P01_Entrevista.md` | `723337095fa3a1437626015b7585ba0c85c4a1d3efc16aea1959bf9bd6d49f6d` |
| `07_Datos/datos_crudos/Entrevistas/2026-05-26_Transcripcion_P02_Entrevista.md` | `3d25472b0434ba45a13983090d732d0a95a90a66ce352b8c2593430be956a3d1` |
| `07_Datos/datos_crudos/Entrevistas/2026-07-21_Transcripcion_P03_Entrevista.md` | `7bacaccf96c1efda80ced4693714622ca3a8a3f3378426034bc266079172004e` |
| `07_Datos/datos_crudos/Entrevistas/2026-07-25_Transcripcion_P04_Entrevista.md` | `2f1d2b0c55e5d7a1252c23dfcffc61b5a60edf4f9715913f77320ce84867d7e9` |
| `07_Datos/datos_crudos/Entrevistas/2026-07-25_Transcripcion_P05_Entrevista.md` | `ff9b4d8a7dc08629aa9eb2a2ddb5b316ec3aa5761fb13fd515f422a54b04b9b5` |
| `07_Datos/datos_crudos/Entrevistas/2026-07-27_Transcripcion_P06_Entrevista.md` | `3e238c9fa86e31adf860ef5adcbe0d04232fb4e742feb3407219ccfcc4e93a75` |
| `07_Datos/datos_crudos/Entrevistas/2026-07-27_Transcripcion_P07_Entrevista.md` | `c319e9749d6574e885e497095a15393d818e5631048d41eee4a9ecf8d78e7a51` |
| `07_Datos/datos_crudos/Entrevistas/2026-07-28_Transcripcion_P08_Entrevista.md` | `a1bb2f2f5150e2935cf9ecdde5468971f6abfe487a60c9c8e1a60f2782bf0580` |
| `07_Datos/datos_crudos/Entrevistas/2026-08-31_Transcripcion_P09_Entrevista.md` | `0a73c40cf477e975a4e1541c12f93ad89b25bb2f7cce25fc375dcfe04795c6c6` |
| `07_Datos/datos_crudos/Entrevistas/2026-08-31_Transcripcion_P10_Entrevista.md` | `0634e5e343599c678f3c933efb14c6ad3ea6b1334c0436ee6dc582b6512882d0` |
| `07_Datos/datos_crudos/Entrevistas/2026-08-31_Transcripcion_P11_Entrevista.md` | `221516d57a977809f38816f237585d10d1b30c0075db5f4f38d09cea808e64d4` |
| `07_Datos/datos_crudos/Entrevistas/2026-08-31_Transcripcion_P12_Entrevista.md` | `cd332de968b9578acb583488505c80f778a1d364d624ea6c0728637644ea97c6` |
| `07_Datos/datos_crudos/Entrevistas/2026-08-31_Transcripcion_P13_Entrevista.md` | `652cba7c708e85d908b212f661b6c94771f7b615e763ee522714d78db1ef79a8` |
| `07_Datos/datos_crudos/Entrevistas/2026-08-31_Transcripcion_P14_Entrevista.md` | `9e5ec6c1d06c7a2f68d25fc203e7b1076b09ce53f50b7cdc00c756bb11729191` |
| `07_Datos/datos_crudos/Entrevistas/2026-08-31_Transcripcion_P15_Entrevista.md` | `3b6ffbd10f869b3d247c201b5dad2265a76c225d27ec8aa754f3bf536348618d` |
| `07_Datos/datos_crudos/Entrevistas/2026-08-31_Transcripcion_P16_Entrevista.md` | `a616d82848a1c0a8419064ab91a4c1488175c34a4ea8ef61c7a72ac759fa9658` |
| `07_Datos/resultados/codificacion_tematica_SGCV-IA.csv` | `88b37b408e64b4fc05adf6a45e536b701c21012361c16ac02af76f16c1b13d22` |
| `07_Datos/resultados/conteo_codigos_categorias.csv` | `91683ef1c07d1b0ea3335a156118089e7b5e832ee5111f59c61ed0f79b4c6584` |
| `07_Datos/resultados/curva_saturacion.csv` | `f5b9522d47f1c3d5407a7e0f9626c636141ebf65939277c9050cedcee7b22aeb` |
| `07_Datos/resultados/justificacion_muestra.md` | `ed84227d4588fe5557852944c4aa5317b72b25d17b78cd3546b4b073fed1e893` |
| `07_Datos/resultados/perfil_participantes_agregado.csv` | `ce9a5c616b71ba803dbd6b01797173a000768bf70b7cebf8df018dfb942f4a0a` |
| `07_Datos/resultados/saturacion_reporte.md` | `a64be5139e5f7beb64aa5fb5efde4c91c72e80cd79ace690bc577fd76598576a` |
| `07_Datos/resultados/tabla_01_saturacion_codigos_abiertos.csv` | `7651b06e6da7f4065fb8182677f56418c5afd113b3ac28a31d8cb767b9ab13f2` |
| `07_Datos/resultados/tabla_02_descriptivos_likert.csv` | `8b5251196890c25a48fdc70a1801154add725c828f55b60b18b0131326e62d96` |
| `07_Datos/resultados/tabla_03_supuestos_shapiro.csv` | `09efb50ca2495ce48d6380f17c46b05116c578367a883e0a69c65f0a6335fbde` |
| `07_Datos/resultados/tabla_04_supuestos_levene.csv` | `ab13cc55df10f39af05b5cd7adc73f6b0661cf8e037b47dbbcd2cef0bcd185cd` |
| `07_Datos/resultados/tabla_05_pruebas_hipotesis.csv` | `9d5a28ffe693808969281ca12a7c39415443ad02c4af442f0f168b77f69fa6e6` |
| `07_Datos/resultados/tabla_06_tamano_efecto.csv` | `6cc67ae84be02a44aa58e5cbb3c77b9b7bb8fea73ca5d252c00288dd6a20116a` |
| `07_Datos/resultados/tabla1_trabajo_relacionado.csv` | `de12ca8d2bc248f96900c3879a05a8eb3fa654bf28f22b07c51f9fe2b757b520` |
| `07_Datos/resultados/tabla2_codigos_ia_frecuencias.csv` | `0dcb6741884fa5c1bbcdc89e8ab088f8b2c8b9c91e9c866610d56a94b6b47e02` |
