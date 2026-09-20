#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
C4 - Curva de saturación temática del proyecto SGCV-IA.

Criterio declarado (equipo, 19/09/2026):
- Base: orden cronológico real de las 16 entrevistas, P01 -> P16
  (confirmado por el equipo: la numeración de participante coincide
  con el orden real de aplicación, incluida la jornada del 31/08
  donde P10..P16 se ordenan tal cual).
- Tramo: bloques de 3 entrevistas consecutivas (16 / 3 = 5 tramos completos
  + 1 entrevista suelta al final: P01-P03, P04-P06, P07-P09, P10-P12,
  P13-P15, P16).
- Métrica: códigos axiales NUEVOS que aparecen por primera vez dentro
  de cada tramo, sumados (no promediados), sobre el total de 50
  códigos axiales del proyecto.
- Umbral de saturación: un tramo satura cuando aporta <= 5% de
  códigos nuevos sobre el total (<= 2.5, es decir <= 2 códigos
  nuevos de 50).

Fuente única de datos: C1_mapeo_codigo_abierto_axial_SGCV-IA.csv
(ya corregido con las participantes verificadas en C3).
"""
import argparse
import csv
from collections import defaultdict

ORDEN = [f"P{n:02d}" for n in range(1, 17)]  # P01..P16, orden cronológico confirmado


def cargar_primer_participante_por_codigo(ruta_mapeo, nivel="Codigo_axial"):
    participantes_por_codigo = defaultdict(set)
    with open(ruta_mapeo, newline="", encoding="utf-8") as f:
        lector = csv.DictReader(f)
        for fila in lector:
            participantes_por_codigo[fila[nivel]].add(fila["Participante"])

    orden_idx = {p: i for i, p in enumerate(ORDEN)}
    primer_participante = {}
    for codigo, participantes in participantes_por_codigo.items():
        primero = min(participantes, key=lambda p: orden_idx.get(p, 999))
        primer_participante[codigo] = primero
    return primer_participante


def construir_tramos(orden, tamano):
    """Bloques de tamaño fijo; el resto (si el total no es múltiplo exacto)
    se une al último tramo en vez de quedar como un tramo más pequeño que
    `tamano` — comparar un tramo incompleto contra un umbral pensado para
    tramos completos sesga la conclusión hacia una saturación falsa."""
    n = len(orden)
    n_tramos_completos = n // tamano
    if n % tamano == 0:
        return [orden[i:i + tamano] for i in range(0, n, tamano)]
    tramos = [orden[i:i + tamano] for i in range(0, (n_tramos_completos - 1) * tamano, tamano)]
    tramos.append(orden[(n_tramos_completos - 1) * tamano:])
    return tramos


def calcular_curva(primer_participante, tramos, total_codigos, tamano_tramo, umbral_tipo, umbral_valor):
    orden_idx = {p: i for i, p in enumerate(ORDEN)}
    filas = []
    acumulado = 0
    for n_tramo, participantes_tramo in enumerate(tramos, start=1):
        idx_min = orden_idx[participantes_tramo[0]]
        idx_max = orden_idx[participantes_tramo[-1]]
        nuevos = [c for c, p in primer_participante.items()
                  if idx_min <= orden_idx[p] <= idx_max]
        n_nuevos = len(nuevos)
        acumulado += n_nuevos
        pct_tramo = round(100 * n_nuevos / total_codigos, 1)
        pct_acumulado = round(100 * acumulado / total_codigos, 1)
        if umbral_tipo == "porcentaje":
            satura = "SI" if pct_tramo <= umbral_valor else "NO"
        else:
            satura = "SI" if n_nuevos <= umbral_valor else "NO"
        nota = "" if len(participantes_tramo) == tamano_tramo else f"tramo incompleto ({len(participantes_tramo)} entrevista(s), no {tamano_tramo})"
        filas.append({
            "Tramo": n_tramo,
            "Participantes_del_tramo": ",".join(participantes_tramo),
            "Codigos_nuevos_en_tramo": n_nuevos,
            "Codigos_nuevos_pct_sobre_total": pct_tramo,
            "Codigos_acumulados": acumulado,
            "Codigos_acumulados_pct": pct_acumulado,
            "Satura_bajo_umbral": satura,
            "Codigos_nuevos_lista": "; ".join(sorted(nuevos)),
            "Nota": nota,
        })
    return filas


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--mapeo", required=True)
    ap.add_argument("--total-codigos", type=int, default=50)
    ap.add_argument("--tamano-tramo", type=int, default=4)
    ap.add_argument("--nivel", choices=["Codigo_axial", "Categoria_axial"], default="Codigo_axial",
                     help="Granularidad de la curva: código axial fino (50) o categoría amplia (7)")
    ap.add_argument("--umbral-tipo", choices=["porcentaje", "absoluto"], default="porcentaje")
    ap.add_argument("--umbral-valor", type=float, default=5.0,
                     help="Si --umbral-tipo=porcentaje: % máximo de códigos nuevos. Si =absoluto: N máximo de códigos nuevos.")
    ap.add_argument("--salida", required=True)
    args = ap.parse_args()

    primer_participante = cargar_primer_participante_por_codigo(args.mapeo, args.nivel)
    n_codigos_reales = len(primer_participante)
    total_codigos = args.total_codigos if args.nivel == "Codigo_axial" else n_codigos_reales
    if args.nivel == "Codigo_axial" and n_codigos_reales != args.total_codigos:
        print(f"AVISO: el mapeo tiene {n_codigos_reales} códigos axiales distintos, "
              f"no {args.total_codigos}. Se usa {n_codigos_reales} como base real, "
              f"pero se reporta también el % sobre {args.total_codigos} si se pide.")

    tramos = construir_tramos(ORDEN, args.tamano_tramo)
    filas = calcular_curva(primer_participante, tramos, total_codigos, args.tamano_tramo,
                            args.umbral_tipo, args.umbral_valor)

    with open(args.salida, "w", newline="", encoding="utf-8") as f:
        cols = ["Tramo", "Participantes_del_tramo", "Codigos_nuevos_en_tramo",
                "Codigos_nuevos_pct_sobre_total", "Codigos_acumulados",
                "Codigos_acumulados_pct", "Satura_bajo_umbral",
                "Codigos_nuevos_lista", "Nota"]
        w = csv.DictWriter(f, fieldnames=cols)
        w.writeheader()
        w.writerows(filas)

    unidad = "%" if args.umbral_tipo == "porcentaje" else "códigos nuevos absolutos"
    print(f"Nivel: {args.nivel}. Criterio: base=orden cronológico P01-P16, tramo={args.tamano_tramo} entrevistas, "
          f"umbral<= {args.umbral_valor} {unidad} (sobre {total_codigos} {'códigos' if args.nivel=='Codigo_axial' else 'categorías'} en total).")
    for fila in filas:
        print(f"  Tramo {fila['Tramo']} ({fila['Participantes_del_tramo']}): "
              f"{fila['Codigos_nuevos_en_tramo']} nuevos "
              f"({fila['Codigos_nuevos_pct_sobre_total']}%) -> "
              f"satura={fila['Satura_bajo_umbral']}")
    print(f"\nResultado: {args.salida}")

    # También: códigos axiales con un solo participante en todo el corpus
    from collections import defaultdict as dd
    with open(args.mapeo, newline="", encoding="utf-8") as f:
        lector = csv.DictReader(f)
        pc = dd(set)
        for fila in lector:
            pc[fila["Codigo_axial"]].add(fila["Participante"])
    un_solo = [c for c, ps in pc.items() if len(ps) == 1]
    print(f"\nCódigos axiales con un solo participante: {len(un_solo)} de {len(pc)}")


if __name__ == "__main__":
    main()
