# Fotos_Aplicacion — Nota sobre metadatos EXIF

Las 13 imágenes de esta carpeta son **capturas de pantalla (screenshots)** de la
aplicación/formulario del cuestionario, no fotografías tomadas con la cámara de un
dispositivo. Esta distinción explica por qué ninguna conserva metadatos EXIF de
captura (`DateTimeOriginal`, `Model`):

- Un archivo EXIF con fecha de captura y modelo de dispositivo lo genera el
  **sensor de la cámara** al tomar una fotografía. Una captura de pantalla no pasa
  por ese sensor: es una copia directa de lo que se muestra en la pantalla en ese
  momento, generada por el sistema operativo.
- Por diseño, **ningún sistema operativo (Android, iOS, Windows) escribe EXIF de
  cámara en un screenshot**, porque no hay cámara involucrada en el proceso. Esto
  no es una pérdida de datos ni un descuido del equipo: es una característica
  estructural de este tipo de archivo, presente incluso en el mismo instante en
  que se generó la captura, no algo que se haya eliminado después.
- Por esta razón, verificar estos 13 archivos con `exiftool -DateTimeOriginal
  -Model` no debe interpretarse como evidencia faltante, sino como el resultado
  esperado para una captura de pantalla.

Esta situación está documentada por archivo en
[`10_Autoria/exif_inventario.csv`](../../../10_Autoria/exif_inventario.csv), donde
cada una de estas 13 imágenes aparece con `fecha_captura` y `dispositivo` marcados
como `SIN_EXIF`, junto a su hash SHA-256 para verificación de integridad.

**No existe evidencia fotográfica de la aplicación del cuestionario** con
metadatos de cámara verificables. Las 13 imágenes de esta carpeta documentan el
contenido del instrumento (los resúmenes del formulario), no el momento ni el
contexto en que se aplicó.

## Evidencia alternativa de autenticidad

Dado que el EXIF de cámara no aplica a este tipo de archivo, la trazabilidad y
fecha de estas capturas se sostiene por otras vías:

- El hash SHA-256 de cada archivo, registrado en `exif_inventario.csv`, permite
  verificar que el contenido no fue alterado después de su captura.
- La fecha del commit de Git en que cada imagen fue depositada en el repositorio
  ofrece una cota superior verificable de cuándo, a más tardar, existía la
  captura.
