"""
Matriz Poder/Interes de Stakeholders (Mendelow) - SGCV-IA
Reconstruido a partir del SVG/PNG publicado en:
03_Modelado/Organizacional_iStar/Matriz_Poder_Interes.(png|svg)

Requiere: matplotlib
Uso: python Matriz_Poder_Interes.py
Genera: Matriz_Poder_Interes.png y Matriz_Poder_Interes.svg
"""

import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle

TITLE_COLOR = "#1f4e3d"
GREEN = "#1f4e3d"      # Gestionar de cerca (alto poder, alto interes)
GOLD = "#8a6100"       # Mantener informado (bajo poder, bajo interes... en este caso alto poder bajo interes visualmente en cuadrante sup-izq)
BLUE = "#2b4c7e"       # Mantener satisfecho
GRAY = "#595959"       # Monitorear

fig, ax = plt.subplots(figsize=(10.5, 8.6))
ax.set_xlim(0, 10)
ax.set_ylim(0, 8.2)
ax.axis("off")

fig.suptitle("Matriz Poder/Interés de Stakeholders (Mendelow) — SGCV-IA",
             fontsize=15.5, fontweight="bold", color=TITLE_COLOR, y=0.975)

# Fondo de los 4 cuadrantes
ax.add_patch(Rectangle((0, 4.1), 5, 4.1, facecolor="#fdf3e3", edgecolor="none"))   # sup-izq: mantener informado
ax.add_patch(Rectangle((5, 4.1), 5, 4.1, facecolor="#e7f2ec", edgecolor="none"))   # sup-der: gestionar de cerca
ax.add_patch(Rectangle((0, 0), 5, 4.1, facecolor="#ffffff", edgecolor="none"))     # inf-izq: monitorear
ax.add_patch(Rectangle((5, 0), 5, 4.1, facecolor="#eef1f7", edgecolor="none"))     # inf-der: mantener satisfecho

# Marco y ejes centrales
ax.plot([0, 10], [4.1, 4.1], color="#8c8c8c", lw=1.1)
ax.plot([5, 5], [0, 8.2], color="#8c8c8c", lw=1.1)
ax.add_patch(Rectangle((0, 0), 10, 8.2, facecolor="none", edgecolor="#8c8c8c", lw=1.1))

# Etiquetas de cuadrante
ax.text(0.25, 7.75, "MANTENER INFORMADO", fontsize=13, fontweight="bold", color=GOLD, va="top")
ax.text(5.25, 7.75, "GESTIONAR DE CERCA", fontsize=13, fontweight="bold", color=GREEN, va="top")
ax.text(0.25, 0.35, "MONITOREAR (esfuerzo mínimo)", fontsize=12.5, fontweight="bold", color="#404040")
ax.text(5.25, 0.35, "MANTENER SATISFECHO", fontsize=12.5, fontweight="bold", color=BLUE)

# Ejes
ax.annotate("", xy=(-0.05, 8.2), xytext=(-0.05, 0),
            arrowprops=dict(arrowstyle="-|>", color="black", lw=1.2))
ax.text(-0.15, 4.1, "Poder", rotation=90, ha="right", va="center", fontsize=13)
ax.annotate("", xy=(10, -0.35), xytext=(0, -0.35),
            arrowprops=dict(arrowstyle="-|>", color="black", lw=1.2))
ax.text(5, -0.55, "Interés", ha="center", va="top", fontsize=13)

# Stakeholders: (nombre, x, y, color, label_offset(dx,dy), ha)
stakeholders = [
    ("Docente evaluador", 4.55, 7.1, GOLD, (0.1, 0.22), "center"),
    ("Propietario de la mascota", 3.45, 6.85, GOLD, (0, 0.22), "center"),
    ("Propietario/administrador\nde la clínica", 8.85, 7.55, GREEN, (0, 0.15), "center"),
    ("Comité de ética / protección\nde datos (LOPDP)", 6.55, 6.65, GREEN, (0, 0.28), "center"),
    ("Médico veterinario", 8.85, 6.35, GREEN, (0, 0.22), "center"),
    ("Equipo de desarrollo", 8.5, 4.85, GREEN, (0, 0.22), "center"),
    ("Personal administrativo", 8.2, 3.9, BLUE, (0, 0.22), "center"),
    ("Proveedor de servicio de\nmensajería (WhatsApp)", 3.15, 2.05, GRAY, (0, 0.28), "center"),
]

for name, x, y, color, (dx, dy), ha in stakeholders:
    ax.scatter([x], [y], s=90, color=color, zorder=5)
    ax.text(x + dx, y + dy, name, ha=ha, va="bottom", fontsize=10.5, color="#1a1a1a")

plt.tight_layout()
plt.savefig("Matriz_Poder_Interes.png", dpi=200, bbox_inches="tight")
plt.savefig("Matriz_Poder_Interes.svg", bbox_inches="tight")
print("Generado: Matriz_Poder_Interes.png / .svg")
