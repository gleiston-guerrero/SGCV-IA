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
| `evidencias_walkthrough.7z.001-004` | Actas y material original de las 6 sesiones de walkthrough | — |
| `evidencias_walkthrough_videos.7z.001-003` | Videos originales de las sesiones de walkthrough | — |
| `checksums_P03aP16.sha256` | Hashes SHA-256 de los videos, calculados antes de cifrar |
| `checksums_audio_P01aP16.sha256` | Hashes SHA-256 de los audios, calculados antes de cifrar |
| `checksums_consentimientos_P01aP16.sha256` | Hashes SHA-256 de los consentimientos, calculados antes de cifrar |
| `checksums_walkthrough .sha256` | Hashes SHA-256 de los videos de walkthrough, calculados antes de cifrar |
| `evidencias_walkthrough_videos.7z.sha256` | Hash SHA-256 del volumen cifrado de videos de walkthrough |

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
- La duración total de video (~202 min) está actualmente por debajo del mínimo de 240 min
  exigido por la guía, pendiente de revisión por el equipo.
