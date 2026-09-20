#!/usr/bin/env python3
"""
C2 - Recuento de frecuencias axiales del proyecto SGCV-IA.

Lee el mapeo código abierto -> código axial (salida de C1) y genera,
por cada código axial, el conjunto de participantes distintos que lo
mencionan y su frecuencia sobre el total de participantes del corpus.

Regla del plan de mejora: "Toda cifra de un documento sale de un
script, nunca se escribe a mano." Este script es esa fuente única.

Uso:
    python3 calcular_frecuencias_axiales.py \
        --mapeo C1_mapeo_codigo_abierto_axial_SGCV-IA.csv \
        --n-total 16 \
        --salida C2_frecuencias_axiales_SGCV-IA.csv

Nota: --mapeo debe apuntar siempre al C1 vigente (el que incorpora las
correcciones de participante verificadas en C3), no a una copia paralela
con sufijo "_corregido" ni a versiones preliminares.
"""
import argparse
import csv
from collections import defaultdict


def calcular_frecuencias(ruta_mapeo: str, n_total: int):
    participantes_por_codigo = defaultdict(set)
    categoria_por_codigo = {}

    with open(ruta_mapeo, newline="", encoding="utf-8") as f:
        lector = csv.DictReader(f)
        campos_requeridos = {"Participante", "Codigo_axial", "Categoria_axial"}
        if not campos_requeridos.issubset(lector.fieldnames or []):
            faltan = campos_requeridos - set(lector.fieldnames or [])
            raise ValueError(f"Al mapeo le faltan columnas: {faltan}")

        for fila in lector:
            codigo = fila["Codigo_axial"].strip()
            participante = fila["Participante"].strip()
            participantes_por_codigo[codigo].add(participante)
            categoria_por_codigo[codigo] = fila["Categoria_axial"].strip()

    filas_salida = []
    for codigo, participantes in participantes_por_codigo.items():
        n = len(participantes)
        filas_salida.append({
            "Categoria_axial": categoria_por_codigo[codigo],
            "Codigo_axial": codigo,
            "N_participantes": n,
            "N_total_corpus": n_total,
            "Frecuencia": f"{n}/{n_total}",
            "Porcentaje": round(100 * n / n_total, 1),
            "Participantes": ",".join(sorted(participantes)),
        })

    # Orden descendente por N_participantes, luego alfabético por código
    filas_salida.sort(key=lambda r: (-r["N_participantes"], r["Codigo_axial"]))
    return filas_salida


def escribir_csv(filas, ruta_salida: str):
    columnas = [
        "Categoria_axial", "Codigo_axial", "N_participantes",
        "N_total_corpus", "Frecuencia", "Porcentaje", "Participantes",
    ]
    with open(ruta_salida, "w", newline="", encoding="utf-8") as f:
        escritor = csv.DictWriter(f, fieldnames=columnas)
        escritor.writeheader()
        escritor.writerows(filas)


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--mapeo", required=True, help="CSV de mapeo código abierto -> código axial (salida de C1)")
    ap.add_argument("--n-total", type=int, required=True, help="Número total de participantes del corpus (denominador)")
    ap.add_argument("--salida", required=True, help="Ruta del CSV de frecuencias a generar")
    args = ap.parse_args()

    filas = calcular_frecuencias(args.mapeo, args.n_total)
    escribir_csv(filas, args.salida)

    print(f"{len(filas)} códigos axiales procesados.")
    print(f"Total de participantes citados en el mapeo: "
          f"{len({p for fila in filas for p in fila['Participantes'].split(',')})}")
    print(f"Resultado escrito en: {args.salida}")


if __name__ == "__main__":
    main()
