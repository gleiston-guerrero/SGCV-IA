#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
C3 - Verificación literal de los 167 fragmentos de codificacion_tematica_SGCV-IA.csv
contra las transcripciones revisadas de P01-P16.
"""
import csv, glob, re, unicodedata, difflib, os

TRANS_DIR = os.path.dirname(os.path.abspath(__file__))

def normalizar(txt):
    txt = txt.replace("\u2026", "...")
    txt = re.sub(r"\(\d{1,2}:\d{2}\)", " ", txt)  # quitar marcas de tiempo incrustadas
    txt = unicodedata.normalize("NFKD", txt)
    txt = "".join(c for c in txt if not unicodedata.combining(c))
    txt = txt.lower()
    txt = re.sub(r"[^a-z0-9\s]", " ", txt)
    txt = re.sub(r"\s+", " ", txt).strip()
    return txt

def cargar_transcripciones():
    datos = {}
    for path in glob.glob(os.path.join(TRANS_DIR, "*Transcripcion_P*_Entrevista.md")):
        m = re.search(r"P(\d\d)", path)
        pid = f"P{m.group(1)}"
        with open(path, encoding="utf-8") as f:
            contenido = f.read()
        partes = contenido.split("## Transcripción automática")
        revisada = partes[0]
        automatica = partes[1] if len(partes) > 1 else ""
        # quitar cabecera de metadatos, quedarnos desde "## Transcripción"
        revisada = revisada.split("## Transcripción", 1)[-1]
        datos[pid] = {
            "revisada_raw": revisada,
            "automatica_raw": automatica,
            "revisada_norm": normalizar(revisada),
            "automatica_norm": normalizar(automatica),
        }
    return datos

def mejor_ventana(frag_norm, texto_norm):
    """Devuelve (ratio, fragmento_texto_aproximado) de la mejor ventana en texto_norm."""
    if not texto_norm:
        return 0.0, ""
    n = len(frag_norm.split())
    palabras = texto_norm.split()
    mejor = (0.0, "")
    paso = max(1, n // 4)
    for i in range(0, max(1, len(palabras) - n + 1), paso):
        ventana = " ".join(palabras[i:i+n+4])
        r = difflib.SequenceMatcher(None, frag_norm, ventana).ratio()
        if r > mejor[0]:
            mejor = (r, ventana)
    return mejor

def buscar_con_elipsis(frag, texto_norm):
    partes = [p.strip() for p in re.split(r"\.\.\.", frag) if p.strip()]
    if len(partes) < 2:
        return False
    partes_norm = [normalizar(p) for p in partes]
    pos = 0
    for p in partes_norm:
        idx = texto_norm.find(p, pos)
        if idx == -1:
            return False
        pos = idx + len(p)
    return True

def coincide_literal(fragmento, frag_norm, texto_norm):
    """True si el fragmento (tal cual, o partido por elipsis) aparece en orden en texto_norm."""
    if not texto_norm:
        return False
    if frag_norm in texto_norm:
        return True
    if "..." in fragmento or "\u2026" in fragmento:
        return buscar_con_elipsis(fragmento, texto_norm)
    return False

def clasificar(fragmento, pid, datos):
    frag_norm = normalizar(fragmento)
    propio = datos.get(pid, {"revisada_norm": "", "automatica_norm": ""})

    # 1) literal (exacto o con elipsis en orden) en revisada propia
    if coincide_literal(fragmento, frag_norm, propio["revisada_norm"]):
        tag = "LITERAL_CON_ELIPSIS" if ("..." in fragmento and frag_norm not in propio["revisada_norm"]) else "LITERAL"
        return tag, pid, 1.0, ""
    # 2) literal (exacto o con elipsis) en automática propia (no en revisada)
    if coincide_literal(fragmento, frag_norm, propio["automatica_norm"]):
        return "LITERAL_SOLO_EN_AUTOMATICA", pid, 1.0, "No aparece en la revisada; sí en la transcripción automática sin editar"
    # 3) buscar en TODOS los demás participantes, exacto o con elipsis (posible mala atribución)
    for otro_pid, otro in datos.items():
        if otro_pid == pid:
            continue
        if coincide_literal(fragmento, frag_norm, otro["revisada_norm"]):
            return "ATRIBUIDO_A_OTRO_PARTICIPANTE", otro_pid, 1.0, f"Aparece literal en la transcripción revisada de {otro_pid}, no en la de {pid}"
        if coincide_literal(fragmento, frag_norm, otro["automatica_norm"]):
            return "ATRIBUIDO_A_OTRO_PARTICIPANTE", otro_pid, 1.0, f"Aparece literal en la transcripción AUTOMÁTICA de {otro_pid}, no en ninguna de {pid}"
    # 4) no hay coincidencia exacta en ningún lado: medir similitud aproximada en la propia
    ratio, ventana = mejor_ventana(frag_norm, propio["revisada_norm"])
    if ratio >= 0.75:
        return "PARAFRASEADO", pid, round(ratio, 2), ventana
    elif ratio > 0:
        return "NO_ENCONTRADO", pid, round(ratio, 2), ventana
    else:
        return "NO_ENCONTRADO", pid, 0.0, ""

def main():
    datos = cargar_transcripciones()
    print("Transcripciones cargadas:", sorted(datos.keys()))

    with open(os.path.join(TRANS_DIR, "..", "codificacion_tematica_SGCV-IA.csv"), newline="", encoding="utf-8") as f:
        filas = list(csv.DictReader(f))

    salida = []
    for i, row in enumerate(filas, start=1):
        pid = row["ID_evidencia"].strip()
        frag = row["Fragmento"].strip()
        estado, pid_encontrado, score, evidencia = clasificar(frag, pid, datos)
        salida.append({
            "Fila": i,
            "Participante_declarado": pid,
            "Fragmento": frag,
            "Estado": estado,
            "Participante_real_si_difiere": pid_encontrado if pid_encontrado != pid else "",
            "Similitud": score,
            "Evidencia_o_ventana_aproximada": evidencia,
        })

    out = os.path.join(TRANS_DIR, "C3_verificacion_fragmentos_SGCV-IA.csv")
    with open(out, "w", newline="", encoding="utf-8") as f:
        cols = ["Fila","Participante_declarado","Fragmento","Estado",
                "Participante_real_si_difiere","Similitud","Evidencia_o_ventana_aproximada"]
        w = csv.DictWriter(f, fieldnames=cols)
        w.writeheader()
        w.writerows(salida)

    from collections import Counter
    c = Counter(r["Estado"] for r in salida)
    print("\nResumen:")
    for k, v in c.most_common():
        print(f"  {k}: {v}")
    print("\nTotal:", len(salida))
    print("No literales (todo menos LITERAL/LITERAL_CON_ELIPSIS):",
          sum(v for k, v in c.items() if k not in ("LITERAL","LITERAL_CON_ELIPSIS")))

if __name__ == "__main__":
    main()
