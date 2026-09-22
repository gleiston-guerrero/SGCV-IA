# 02_Evidencias/00_Restringido

Esta carpeta contiene la evidencia identificable (zona restringida [R]) del proyecto SGCV-IA,
cifrada con AES-256 según la Sección 3 de la Guía de Entrega 4 (2B). El contenido de esta
carpeta **no se licencia, no se redistribuye y no forma parte del depósito abierto**.

## Contenido

| Archivo(s) | Contenido | Participantes |
|---|---|---|
| `evidencias_P03aP16.7z.001-017` | Videos originales de entrevista (sin anonimizar) | P03-P16 (14) |
| `evidencias_audio_P01aP16.7z.001-002` | Audios originales de entrevista (sin anonimizar) | P01-P16 (16) |
| `evidencias_consentimientos_P01aP16.7z` | Consentimientos firmados originales (cédula y firma visibles) | P01-P16 (16) |
| `evidencias_restringidas.7z.001-007` | Pendiente de documentar por el resto del equipo |
| `evidencias_walkthrough.7z.001-004` | **Obsoleto** — versión inicial del material de las 6 sesiones de walkthrough. Los nombres internos de archivo quedaron mal fechados (todos como `2026-07-20`), contradiciendo las actas y los metadatos de los propios videos. Reemplazado por `evidencias_video_walkthrough_nuevo.7z`; se conserva solo por trazabilidad histórica. | — |
| `evidencias_walkthrough_videos.7z.001-003` | **Obsoleto** — mismo motivo que la fila anterior; reemplazado por `evidencias_video_walkthrough_nuevo.7z`. | — |
| `evidencias_video_walkthrough_nuevo.7z.001-004` | **Vigente** — videos de las 6 sesiones de walkthrough (W01-W06) con nombre de archivo y fecha correctos por sesión. Es el paquete que debe usarse para verificar evidencia de walkthrough. | — |
| `checksums_P03aP16.sha256` | Hashes SHA-256 de los videos, calculados antes de cifrar |
| `checksums_audio_P01aP16.sha256` | Hashes SHA-256 de los audios, calculados antes de cifrar |
| `checksums_consentimientos_P01aP16.sha256` | Hashes SHA-256 de los consentimientos, calculados antes de cifrar |
| `checksums_walkthrough .sha256` | **Obsoleto** — hashes del paquete `evidencias_walkthrough.7z` (ver nota arriba) |
| `checksums_walkthrough_nuevos.sha256` | **Vigente** — hashes SHA-256 de los 6 videos de walkthrough (W01-W06), calculados antes de cifrar. Verificado el 22/09/2026: coincide exactamente con el contenido descifrado de `evidencias_video_walkthrough_nuevo.7z`. |
| `evidencias_walkthrough_videos.7z.sha256` | **Obsoleto** — hash del volumen cifrado `evidencias_walkthrough_videos.7z` (ver nota arriba) |

## Notas importantes

- Los videos de P01 y P02 no existen: el protocolo de grabación en video se incorporó
  después de esas dos entrevistas, que solo quedaron registradas en audio.
- La contraseña de los contenedores `.7z` se entrega únicamente al docente por el SGA,
  nunca dentro de este repositorio.
- Los archivos `checksums_*.sha256` de esta carpeta listan los **nombres originales**
  de los videos, audios y consentimientos (por ejemplo, `2026-05-26_P01_Entrevista.mp4`),
  no los nombres de los volúmenes `.7z` cifrados. Si se audita este repositorio
  comparando esas rutas contra el árbol de git, las 57 entradas combinadas de estos
  cinco manifiestos **no van a resolver** — no es evidencia faltante, es evidencia
  empaquetada dentro de los `.7z` de esta misma carpeta. Los hashes sirven para
  verificar cada archivo individual únicamente **después** de descifrar el contenedor
  correspondiente con la contraseña que tiene el docente.
- Cada hash en los archivos `checksums_*.sha256` corresponde al archivo **original sin
  cifrar**; sirve para verificar la integridad de cada archivo tras descifrar el contenedor.
- **Duración total de video de walkthrough:** medición directa de los 6 videos vigentes
  (`evidencias_video_walkthrough_nuevo.7z`, verificada el 22/09/2026) da un total de
  **~46 minutos** (W01 10:04, W02 6:11, W03 6:39, W04 5:27, W05 9:37, W06 8:14), muy por
  debajo del mínimo de 240 min exigido por la guía. La cifra "~202 min" indicada
  previamente en esta nota no corresponde a ninguno de los dos paquetes de video
  disponibles en este repositorio (ni el obsoleto ni el vigente) y debe tratarse como
  desactualizada o errónea. **Pendiente de revisión por el equipo**: confirmar si faltan
  grabaciones por subir o si el mínimo debe cubrirse combinando walkthrough con otra
  evidencia admitida por la guía.
