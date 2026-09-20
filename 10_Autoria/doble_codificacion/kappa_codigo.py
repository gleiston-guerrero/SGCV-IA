#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
C5 - Doble codificación a nivel de CÓDIGO AXIAL (no de categoría amplia),
sobre P02, P07, P13, P16 (25% del corpus).

Metodología: en vez de forzar un alineamiento fragmento a fragmento (que el
propio equipo descartó por ser subjetivo, ver resultado_doble_codificacion.md),
se clasifica cada fragmento de CADA codificador contra el mismo codebook de
50 códigos axiales (el mismo usado en C1), y se compara presencia/ausencia
de cada código axial, por participante. Esto es la unidad "más fina posible
sin alineamiento subjetivo" que además cumple el criterio de C5 ("a nivel de
código, no de presencia de categorías"): 50 códigos posibles, no 7.

Solo se incluyen en la comparación los códigos axiales que al menos uno de
los dos codificadores marcó como presente para al menos uno de los 4
participantes (evita inflar el acuerdo con decenas de 0-0 triviales sobre
códigos que ninguno de los dos mencionó, p. ej. códigos exclusivos de P08/P09).
"""
import csv
import math
from collections import defaultdict

PARTS = ["P02", "P07", "P13", "P16"]

# Clasificación de los 43 fragmentos de Marcillo (recuperada de C1: mismo
# codebook, mismo criterio de contenido) -> {participante: set(codigo_axial)}
MARCILLO = {
    "P02": {
        "Registro clínico no digitalizado o disperso (físico, Word, ofimática, plataformas básicas)",
        "Búsqueda lenta o poco confiable del historial",
        "Validación de datos y automatización de la facturación (incl. integración SRI)",
        "Impacto de inasistencias y pérdida de seguimiento",
        "Registro de inventario en herramientas no integradas (plataforma externa/Excel)",
        "Registro histórico de peso y estado nutricional",
        "Rechazo al diagnóstico automatizado sin evaluación física",
        "Automatización de recordatorios de citas",
        "Protección de datos del paciente/propietario",
        "Preferencia de acceso multiplataforma/móvil (celular, laptop, tablet)",
    },
    "P07": {
        "Registro clínico no digitalizado o disperso (físico, Word, ofimática, plataformas básicas)",
        "Captura de datos del propietario/paciente incompleta o progresiva",
        "Ficha clínica estructurada con campos estándar y registro detallado de tratamientos",
        "Rechazo al diagnóstico automatizado sin evaluación física",  # reclasificado por contenido (ver nota metodológica)
        "Bajo cumplimiento de indicaciones médicas y seguimiento post-alta",
        "Recordatorios de tareas médicas y vacunación",
        "Estabilidad y confiabilidad operativa del sistema",
        "Preferencia de acceso multiplataforma/móvil (celular, laptop, tablet)",
    },
    "P13": {
        "Registro clínico no digitalizado o disperso (físico, Word, ofimática, plataformas básicas)",
        "Búsqueda lenta o poco confiable del historial",
        "Errores y demoras de facturación por procesos manuales",
        "Ausencia de control de inventario formal (manual/inexistente)",
        "Ausencia de agenda formal de citas",
        "Falta de estandarización y roles indefinidos en la comunicación (auxiliar vs. veterinario)",
        "Aceptación variable de IA diagnóstica (de moderada a alta)",
        "Condiciones de confianza en IA (literatura validada, revisión, actualizaciones, protección de datos)",
        "Preferencia de acceso multiplataforma/móvil (celular, laptop, tablet)",
        "Frecuencia variable de cortes de conectividad en la clínica",
        "Registro fotográfico de evolución clínica vinculado a la ficha",
    },
    "P16": {
        "Registro clínico no digitalizado o disperso (físico, Word, ofimática, plataformas básicas)",
        "Duplicación manual de datos ya existentes en fichas anteriores",
        "Errores y demoras de facturación por procesos manuales",
        "Falta de alertas automáticas de vencimiento/revisión oportuna",
        "Impacto de inasistencias y pérdida de seguimiento",
        "Canales informales de comunicación con propietarios (WhatsApp/teléfono)",
        "Desconfianza en fuentes de internet no validadas usadas por propietarios",
        "Rechazo al diagnóstico automatizado sin evaluación física",  # reclasificado por contenido
        "Aceptación variable de IA diagnóstica (de moderada a alta)",
        "Condiciones de confianza en IA (literatura validada, revisión, actualizaciones, protección de datos)",
        "Preferencia de acceso multiplataforma/móvil (celular, laptop, tablet)",
        "Control y recordatorio de vacunación",
    },
}

# Clasificación de los 77 fragmentos de Mesías contra el mismo codebook.
# Fragmentos sin código axial claro (contenido nuevo que el codebook actual
# no cubre, o hallazgos "negativos" -ausencia de un problema- que el codebook
# solo registra en sentido positivo) se excluyen explícitamente y se listan
# aparte como hallazgo cualitativo.
MESIAS = {
    "P02": {
        "Registro clínico no digitalizado o disperso (físico, Word, ofimática, plataformas básicas)",
        "Búsqueda lenta o poco confiable del historial",
        "Validación de datos y automatización de la facturación (incl. integración SRI)",
        "Impacto de inasistencias y pérdida de seguimiento",
        "Canales informales de comunicación con propietarios (WhatsApp/teléfono)",
        "Falta de alertas automáticas de vencimiento/revisión oportuna",
        "Registro histórico de peso y estado nutricional",
        "Bajo cumplimiento de indicaciones médicas y seguimiento post-alta",
        "Rechazo al diagnóstico automatizado sin evaluación física",
        "Sobrecarga administrativa/operativa sin personal de apoyo",
        "Validación/revisión obligatoria del veterinario sobre sugerencias de IA",
        "Protección de datos del paciente/propietario",
        "Automatización de recordatorios de citas",
        "Preferencia de acceso multiplataforma/móvil (celular, laptop, tablet)",
    },
    "P07": {
        "Registro clínico no digitalizado o disperso (físico, Word, ofimática, plataformas básicas)",
        "Captura de datos del propietario/paciente incompleta o progresiva",
        "Validación de datos y automatización de la facturación (incl. integración SRI)",
        "Canales informales de comunicación con propietarios (WhatsApp/teléfono)",
        "Ficha clínica estructurada con campos estándar y registro detallado de tratamientos",
        "Bajo cumplimiento de indicaciones médicas y seguimiento post-alta",
        "Rechazo al diagnóstico automatizado sin evaluación física",
        "Aceptación variable de IA diagnóstica (de moderada a alta)",
        "Sobrecarga administrativa/operativa sin personal de apoyo",
        "Validación/revisión obligatoria del veterinario sobre sugerencias de IA",
        "Recordatorios de tareas médicas y vacunación",
        "Estabilidad y confiabilidad operativa del sistema",
        "Preferencia de acceso multiplataforma/móvil (celular, laptop, tablet)",
    },
    "P13": {
        "Registro clínico no digitalizado o disperso (físico, Word, ofimática, plataformas básicas)",
        "Búsqueda lenta o poco confiable del historial",
        "Errores y demoras de facturación por procesos manuales",
        "Ausencia de control de inventario formal (manual/inexistente)",
        "Ausencia de agenda formal de citas",
        "Falta de estandarización y roles indefinidos en la comunicación (auxiliar vs. veterinario)",
        "Registro histórico de peso y estado nutricional",
        "Bajo cumplimiento de indicaciones médicas y seguimiento post-alta",
        "Rechazo al diagnóstico automatizado sin evaluación física",
        "Aceptación variable de IA diagnóstica (de moderada a alta)",
        "Condiciones de confianza en IA (literatura validada, revisión, actualizaciones, protección de datos)",
        "Priorización de un sistema centralizado de historial y seguimiento de citas",
        "Facilidad de uso sin experiencia digital y bajo costo",
        "Preferencia de acceso multiplataforma/móvil (celular, laptop, tablet)",
        "Frecuencia variable de cortes de conectividad en la clínica",
        "Registro fotográfico de evolución clínica vinculado a la ficha",
    },
    "P16": {
        "Registro clínico no digitalizado o disperso (físico, Word, ofimática, plataformas básicas)",
        "Captura de datos del propietario/paciente incompleta o progresiva",
        "Errores y demoras de facturación por procesos manuales",
        "Falta de alertas automáticas de vencimiento/revisión oportuna",
        "Impacto de inasistencias y pérdida de seguimiento",
        "Canales informales de comunicación con propietarios (WhatsApp/teléfono)",
        "Registro histórico de peso y estado nutricional",
        "Desconfianza en fuentes de internet no validadas usadas por propietarios",
        "Bajo cumplimiento de indicaciones médicas y seguimiento post-alta",
        "Rechazo al diagnóstico automatizado sin evaluación física",
        "Duplicación manual de datos ya existentes en fichas anteriores",
        "Validación/revisión obligatoria del veterinario sobre sugerencias de IA",
        "Aceptación variable de IA diagnóstica (de moderada a alta)",
        "Protección de datos del paciente/propietario",
        "Búsqueda lenta o poco confiable del historial",
        "Preferencia de acceso multiplataforma/móvil (celular, laptop, tablet)",
        "Frecuencia variable de cortes de conectividad en la clínica",
        "Control y recordatorio de vacunación",
    },
}

def main():
    universo = set()
    for p in PARTS:
        universo |= MARCILLO[p]
        universo |= MESIAS[p]
    universo = sorted(universo)

    rows, r1, r2 = [], [], []
    for p in PARTS:
        for c in universo:
            a = 1 if c in MARCILLO[p] else 0
            b = 1 if c in MESIAS[p] else 0
            r1.append(a); r2.append(b)
            rows.append((p, c, a, b))

    n = len(r1)
    po = sum(1 for a, b in zip(r1, r2) if a == b) / n
    p1y = sum(r1) / n
    p2y = sum(r2) / n
    pe = p1y * p2y + (1 - p1y) * (1 - p2y)
    kappa = (po - pe) / (1 - pe)
    se = math.sqrt(po * (1 - po) / (n * (1 - pe) ** 2))
    z = 1.96
    ci_low, ci_high = kappa - z * se, kappa + z * se

    with open("resultado_kappa_codigo.csv", "w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["Participante", "Codigo_axial", "Marcillo", "Mesias"])
        for r in rows:
            if r[2] == 1 or r[3] == 1:  # solo filas donde al menos uno marcó presencia (las 0-0 no se listan, serían ruido visual)
                w.writerow(r)
        w.writerow([])
        w.writerow(["N_observaciones_(4_participantes_x_%d_codigos_del_universo)" % len(universo), n])
        w.writerow(["Codigos_axiales_en_el_universo", len(universo)])
        w.writerow(["Acuerdo_observado_po", round(po, 4)])
        w.writerow(["Acuerdo_esperado_azar_pe", round(pe, 4)])
        w.writerow(["Kappa_Cohen", round(kappa, 4)])
        w.writerow(["IC_95_inferior", round(ci_low, 4)])
        w.writerow(["IC_95_superior", round(ci_high, 4)])

    print(f"Universo de códigos comparados: {len(universo)}")
    print(f"N={n}  po={po:.4f}  pe={pe:.4f}  kappa={kappa:.4f}  IC95=[{ci_low:.4f}, {ci_high:.4f}]")

    desacuerdos = [r for r in rows if r[2] != r[3]]
    print(f"\nDesacuerdos ({len(desacuerdos)} de {n}):")
    for p, c, a, b in desacuerdos:
        print(f"  {p} | {c} | Marcillo={a} Mesias={b}")

if __name__ == "__main__":
    main()
