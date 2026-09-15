"""
Diagrama de Razon Estrategica (i* SR) - Actor SGCV-IA
Reconstruido a partir del SVG/PNG publicado en:
03_Modelado/Organizacional_iStar/iStar_SR.(png|svg)

Requiere: matplotlib
Uso: python iStar_SR.py
Genera: iStar_SR.png y iStar_SR.svg
"""

import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch, Ellipse, Circle, Rectangle

TITLE_COLOR = "#1f4e3d"
GOAL = dict(facecolor="#fdf1cf", edgecolor="#b8860b", lw=1.4)
TASK = dict(facecolor="#e3f0e7", edgecolor="#2f6b4f", lw=1.4)
RES = dict(facecolor="#f2e3f5", edgecolor="#7a3f96", lw=1.4)
SOFTGOAL = dict(facecolor="#fbe1de", edgecolor="#b23a2e", lw=1.4, linestyle=(0, (4, 3)))
ACTOR_EXT = dict(facecolor="#dbe4f5", edgecolor="#2b4c7e", lw=1.6)
BOUNDARY = dict(facecolor="#eef6f1", edgecolor="#1f4e3d", lw=1.6, linestyle=(0, (6, 4)))
LINE_COLOR = "#333333"
DOT_RED = "#b23a2e"

fig, ax = plt.subplots(figsize=(13, 9))
ax.set_xlim(0, 13)
ax.set_ylim(0, 9)
ax.set_aspect("equal")
ax.axis("off")

fig.suptitle("Diagrama de Razón Estratégica (i* SR) — Actor SGCV-IA",
             fontsize=15.5, fontweight="bold", color=TITLE_COLOR, y=0.975)

# ---------------------------------------------------------------------------
# Boundary (frontera del actor)
# ---------------------------------------------------------------------------
boundary = FancyBboxPatch((2.55, 1.0), 8.2, 6.9,
                           boxstyle="round,pad=0,rounding_size=0.05",
                           **BOUNDARY)
ax.add_patch(boundary)
ax.text(6.65, 8.05, "Actor: SGCV-IA", ha="center", fontsize=13.5,
        fontweight="bold", color=TITLE_COLOR)


def rect(center, w, h, text, style, fontsize=9.5):
    x, y = center[0] - w / 2, center[1] - h / 2
    ax.add_patch(Rectangle((x, y), w, h, **style, zorder=3))
    ax.text(center[0], center[1], text, ha="center", va="center",
            fontsize=fontsize, color="#1a1a1a", zorder=4)


def ellipse(center, w, h, text, style, fontsize=9.5):
    ax.add_patch(Ellipse(center, w, h, **style, zorder=3))
    ax.text(center[0], center[1], text, ha="center", va="center",
            fontsize=fontsize, color="#1a1a1a", zorder=4)


def line(p1, p2, arrow=False, color=LINE_COLOR, style="-", lw=1.3):
    if arrow:
        ax.annotate("", xy=p2, xytext=p1,
                     arrowprops=dict(arrowstyle="-|>", color=color, lw=lw, linestyle=style))
    else:
        ax.plot([p1[0], p2[0]], [p1[1], p2[1]], color=color, lw=lw,
                linestyle=style, zorder=2)


# ---------------------------------------------------------------------------
# Meta raiz
# ---------------------------------------------------------------------------
goal = (6.55, 7.15)
ellipse(goal, 2.3, 0.8, "Apoyar la gestión\nintegral de la clínica", GOAL)

# ---------------------------------------------------------------------------
# Tareas de primer nivel
# ---------------------------------------------------------------------------
task1 = (4.00, 5.82)
task2 = (6.55, 5.82)
task3 = (9.18, 5.82)
rect(task1, 2.35, 0.9, "Gestionar historiales\nclínicos", TASK)
rect(task2, 2.35, 0.9, "Generar apoyo\ndiagnóstico con IA", TASK)
rect(task3, 2.35, 0.9, "Gestionar citas,\ninventario y facturación", TASK)

line(goal, task1)
line(goal, task2)
line(goal, task3)

# ---------------------------------------------------------------------------
# Recursos / subtarea intermedia
# ---------------------------------------------------------------------------
res1 = (2.95, 4.48)
res2 = (5.08, 4.48)
task_inline = (6.75, 4.48)
res3 = (8.55, 4.48)
res4 = (10.35, 4.48)

rect(res1, 1.85, 0.7, "Historial clínico\ndel paciente", RES, fontsize=9)
rect(res2, 1.85, 0.7, "Datos clínicos\nanonimizados", RES, fontsize=9)
rect(task_inline, 2.35, 0.9, "Procesar\nsolicitud en\nel motor de IA", TASK, fontsize=9)
rect(res3, 1.85, 0.7, "Sugerencia\ndiagnóstica", RES, fontsize=9)
rect(res4, 2.0, 0.7, "Registro de\ninventario/factura", RES, fontsize=8.5)

line(task1, res1)
line(task2, res2)
line(task2, task_inline)
line(task_inline, res3)
line(task3, res4)

# ---------------------------------------------------------------------------
# Actor externo: Motor de IA
# ---------------------------------------------------------------------------
motor_ia = (11.85, 4.48)
ax.add_patch(Circle(motor_ia, 0.95, **ACTOR_EXT, zorder=3))
ax.text(motor_ia[0], motor_ia[1], "Motor de IA\n(externo)", ha="center", va="center",
        fontsize=10, fontweight="bold", color="#1f3864", zorder=4)

line(res2, motor_ia, arrow=True)
line(res3, motor_ia, arrow=True)

# ---------------------------------------------------------------------------
# Softgoals (calidad) unidos con lineas punteadas rojas
# ---------------------------------------------------------------------------
soft1 = (4.00, 3.15)
soft2 = (6.55, 3.15)
soft3 = (9.18, 3.15)

ellipse(soft1, 2.35, 0.9, "[Disponibilidad] del\nhistorial clínico", SOFTGOAL, fontsize=9.5)
ellipse(soft2, 2.35, 0.9, "[Confiabilidad] de la\nsugerencia diagnóstica", SOFTGOAL, fontsize=9.5)
ellipse(soft3, 2.35, 0.9, "[Eficiencia] en el\nregistro administrativo", SOFTGOAL, fontsize=9.5)

line((res1[0], res1[1] - 0.35), (soft1[0], soft1[1] + 0.45), color=DOT_RED, style=(0, (2, 3)))
line((task_inline[0], task_inline[1] - 0.45), (soft2[0], soft2[1] + 0.45), color=DOT_RED, style=(0, (2, 3)))
line((res4[0], res4[1] - 0.35), (soft3[0], soft3[1] + 0.45), color=DOT_RED, style=(0, (2, 3)))

# ---------------------------------------------------------------------------
# Leyenda
# ---------------------------------------------------------------------------
ax.text(0.15, 0.55, "Notación i*:", fontsize=11.5, fontweight="bold", va="center")
ellipse((1.85, 0.55), 0.95, 0.35, "Meta", GOAL, fontsize=8)
rect((3.35, 0.55), 0.95, 0.35, "Tarea", TASK, fontsize=8)
rect((4.85, 0.55), 1.0, 0.35, "Recurso", RES, fontsize=8)
ellipse((6.55, 0.55), 1.1, 0.4, "Softgoal", SOFTGOAL, fontsize=8)

plt.tight_layout()
plt.savefig("iStar_SR.png", dpi=200, bbox_inches="tight")
plt.savefig("iStar_SR.svg", bbox_inches="tight")
print("Generado: iStar_SR.png / .svg")
