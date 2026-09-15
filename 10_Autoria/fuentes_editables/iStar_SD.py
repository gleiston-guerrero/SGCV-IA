"""
Diagrama de Dependencia Estrategica (i* SD) - SGCV-IA
Reconstruido a partir del SVG/PNG publicado en:
03_Modelado/Organizacional_iStar/iStar_SD.(png|svg)

Requiere: matplotlib
Uso: python iStar_SD.py
Genera: iStar_SD.png y iStar_SD.svg
"""

import matplotlib.pyplot as plt
from matplotlib.patches import Circle, Ellipse

TITLE_COLOR = "#1f4e3d"
ACTOR = dict(facecolor="#dbe4f5", edgecolor="#2b4c7e", lw=1.6)
GOAL = dict(facecolor="#fdf1cf", edgecolor="#b8860b", lw=1.4)     # meta
TASK = dict(facecolor="#e3f0e7", edgecolor="#2f6b4f", lw=1.4)     # tarea
RES = dict(facecolor="#f7e9f7", edgecolor="#7a3f96", lw=1.4)      # recurso/softgoal
LINE_COLOR = "#666666"

fig, ax = plt.subplots(figsize=(13, 9))
ax.set_xlim(0, 13)
ax.set_ylim(0, 9)
ax.set_aspect("equal")
ax.axis("off")

fig.suptitle("Diagrama de Dependencia Estratégica (i* SD) — SGCV-IA",
             fontsize=15.5, fontweight="bold", color=TITLE_COLOR, y=0.975)


def draw_actor(center, r, text):
    ax.add_patch(Circle(center, r, **ACTOR, zorder=3))
    ax.text(center[0], center[1], text, ha="center", va="center",
            fontsize=10.5, fontweight="bold", color="#1f3864", zorder=4)


def draw_dep(center, w, h, text, style, fontsize=9.5):
    ax.add_patch(Ellipse(center, w, h, **style, zorder=3))
    ax.text(center[0], center[1], text, ha="center", va="center",
            fontsize=fontsize, color="#1a1a1a", zorder=4)


def line(p1, p2, arrow=False):
    if arrow:
        ax.annotate("", xy=p2, xytext=p1,
                     arrowprops=dict(arrowstyle="-|>", color=LINE_COLOR, lw=1.3))
    else:
        ax.plot([p1[0], p2[0]], [p1[1], p2[1]], color=LINE_COLOR, lw=1.3, zorder=2)


# ---------------------------------------------------------------------------
# Actores (círculos)
# ---------------------------------------------------------------------------
vet = (2.0, 6.5)
propietario = (6.6, 7.7)
admin = (11.3, 6.5)
personal = (2.0, 1.8)
motor_ia = (11.3, 1.8)
sistema = (6.6, 4.1)

draw_actor(vet, 1.0, "Médico\nveterinario")
draw_actor(propietario, 1.0, "Propietario de\nla mascota")
draw_actor(admin, 1.0, "Administrador\ndel sistema")
draw_actor(personal, 1.0, "Personal\nadministrativo")
draw_actor(motor_ia, 1.0, "Motor de IA\n(componente externo)")
draw_actor(sistema, 1.1, "SGCV-IA\n(sistema)")

# ---------------------------------------------------------------------------
# Dependencias (elipses)
# ---------------------------------------------------------------------------
confidencialidad = (5.8, 7.0)
seguimiento = (6.6, 6.2)
sugerencia_dx = (4.0, 5.5)
historial = (3.7, 4.8)
gestionar_usuarios = (9.2, 5.0)
registrar_cita = (4.0, 2.9)
datos_anon = (9.2, 2.6)
sugerencia_gen = (8.65, 1.95)

draw_dep(confidencialidad, 2.3, 0.7, "Confidencialidad\nde los datos (softgoal)", RES, fontsize=9)
draw_dep(seguimiento, 2.6, 0.7, "Recibir seguimiento\noportuno de su mascota", GOAL)
draw_dep(sugerencia_dx, 2.3, 0.7, "Obtener sugerencia\ndiagnóstica", TASK)
draw_dep(historial, 2.3, 0.7, "Historial clínico\nactualizado", RES)
draw_dep(gestionar_usuarios, 2.3, 0.7, "Gestionar usuarios\ny permisos", TASK)
draw_dep(registrar_cita, 2.3, 0.7, "Registrar cita /\nfacturar", TASK)
draw_dep(datos_anon, 2.3, 0.7, "Datos clínicos\nanonimizados", RES, fontsize=9)
draw_dep(sugerencia_gen, 2.3, 0.7, "Sugerencia\ndiagnóstica generada", RES, fontsize=9)

# ---------------------------------------------------------------------------
# Conexiones
# ---------------------------------------------------------------------------
line(propietario, confidencialidad)
line(confidencialidad, seguimiento)
line(seguimiento, sistema, arrow=True)

line(vet, sugerencia_dx)
line(sugerencia_dx, sistema, arrow=True)
line(vet, historial)
line(historial, sistema, arrow=True)

line(sistema, gestionar_usuarios)
line(gestionar_usuarios, admin, arrow=True)

line(personal, registrar_cita)
line(registrar_cita, sistema, arrow=True)

line(sistema, datos_anon)
line(datos_anon, motor_ia, arrow=True)
line(sistema, sugerencia_gen)
line(sugerencia_gen, motor_ia, arrow=True)

# ---------------------------------------------------------------------------
# Leyenda
# ---------------------------------------------------------------------------
ax.text(0.2, 0.55, "Notación i*:", fontsize=11.5, fontweight="bold", va="center")
draw_dep((2.1, 0.55), 1.0, 0.35, "Meta", GOAL, fontsize=8.5)
draw_dep((3.6, 0.55), 1.0, 0.35, "Tarea", TASK, fontsize=8.5)
draw_dep((5.35, 0.55), 1.3, 0.4, "Recurso /\nSoftgoal", RES, fontsize=7.5)

plt.tight_layout()
plt.savefig("iStar_SD.png", dpi=200, bbox_inches="tight")
plt.savefig("iStar_SD.svg", bbox_inches="tight")
print("Generado: iStar_SD.png / .svg")
