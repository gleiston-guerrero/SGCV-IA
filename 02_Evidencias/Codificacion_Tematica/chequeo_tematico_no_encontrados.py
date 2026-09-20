#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Chequeo secundario (cualitativo, no reemplaza a C3) sobre los fragmentos
marcados NO_ENCONTRADO: ¿aparece el ASPECTO/TEMA del código abierto en algún
lugar de la transcripción propia del participante, aunque el texto exacto
del "Fragmento" no sea literal?

No decide literalidad (eso ya lo hizo verificar_fragmentos.py). Solo indica
si el tema tiene apoyo textual disperso en la transcripción real.
"""
import csv, re, unicodedata, glob, os
from collections import Counter

STOPWORDS = set("""
de la que el en y a los las un una por con no se su para es al lo como
mas pero sus le ya o este sí porque esta entre cuando muy sin sobre
también me hasta hay donde quien desde todo nos durante todos uno les
ni contra otros ese eso ante ellos e esto mí antes algunos qué unos yo
otro otras otra él tanto esa estos mucho quienes nada muchos cual poco
ella estar estas algunas algo nosotros mi mis tú te ti tu tus ellas
nosotras vosotros vosotras os mío mía míos mías tuyo tuya tuyos tuyas
suyo suya suyos suyas nuestro nuestra nuestros nuestras vuestro vuestra
vuestros vuestras esos esas del al su sus
""".split())

def normalizar(txt):
    txt = unicodedata.normalize("NFKD", txt)
    txt = "".join(c for c in txt if not unicodedata.combining(c))
    txt = txt.lower()
    txt = re.sub(r"[^a-z0-9\s]", " ", txt)
    return re.sub(r"\s+", " ", txt).strip()

def palabras_clave(texto_codigo):
    palabras = normalizar(texto_codigo).split()
    return [p for p in palabras if p not in STOPWORDS and len(p) > 3]

def cargar_transcripciones():
    datos = {}
    for path in glob.glob(os.path.join("/home/claude/c3", "*Transcripcion_P*_Entrevista.md")):
        m = re.search(r"P(\d\d)", path)
        pid = f"P{m.group(1)}"
        with open(path, encoding="utf-8") as f:
            contenido = f.read()
        datos[pid] = normalizar(contenido)
    return datos

def main():
    datos = cargar_transcripciones()
    with open("/home/claude/c3/C3_verificacion_fragmentos_SGCV-IA.csv", newline="", encoding="utf-8") as f:
        c3 = list(csv.DictReader(f))
    with open("/home/claude/codificacion_tematica_SGCV-IA.csv", newline="", encoding="utf-8") as f:
        tematica = list(csv.DictReader(f))

    salida = []
    for i, (c3row, t) in enumerate(zip(c3, tematica), start=1):
        if c3row["Estado"] != "NO_ENCONTRADO":
            continue
        pid = c3row["Participante_declarado"]
        codigo = t["Codigo"]
        claves = palabras_clave(codigo)
        texto = datos.get(pid, "")
        presentes = [k for k in claves if k in texto]
        pct = round(100 * len(presentes) / len(claves), 0) if claves else 0
        salida.append({
            "Fila": i,
            "Participante": pid,
            "Codigo_abierto": codigo,
            "Palabras_clave": ", ".join(claves),
            "Palabras_presentes_en_transcripcion": ", ".join(presentes),
            "Pct_palabras_clave_presentes": pct,
            "Aspecto_con_apoyo_textual": "SI" if pct >= 60 else "NO",
        })

    with open("/home/claude/c3/chequeo_tematico_no_encontrados.csv", "w", newline="", encoding="utf-8") as f:
        cols = ["Fila","Participante","Codigo_abierto","Palabras_clave",
                "Palabras_presentes_en_transcripcion","Pct_palabras_clave_presentes",
                "Aspecto_con_apoyo_textual"]
        w = csv.DictWriter(f, fieldnames=cols)
        w.writeheader()
        w.writerows(salida)

    si = sum(1 for r in salida if r["Aspecto_con_apoyo_textual"] == "SI")
    print(f"De los {len(salida)} fragmentos NO_ENCONTRADO:")
    print(f"  {si} tienen el aspecto/tema con apoyo textual disperso (>=60% de palabras clave presentes)")
    print(f"  {len(salida)-si} no tienen ni siquiera eso")

if __name__ == "__main__":
    main()
