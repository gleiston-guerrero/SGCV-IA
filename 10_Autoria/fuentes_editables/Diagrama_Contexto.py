"""
Diagrama de Contexto del Sistema - SGCV-IA
Reconstruido a partir del SVG/PNG publicado en:
03_Modelado/Organizacional_iStar/Diagrama_Contexto.(png|svg)

Requiere: matplotlib
Uso: python Diagrama_Contexto.py
Genera: Diagrama_Contexto.png y Diagrama_Contexto.svg en el directorio actual.
"""

import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch
from matplotlib.patches import Rectangle

# ---------------------------------------------------------------------------
# Estilos
# ---------------------------------------------------------------------------
COLOR_ACTOR_HUMANO = dict(facecolor="#e9eef7", edgecolor="#2b4c7e", linewidth=1.4)
COLOR_COMPONENTE_EXT = dict(facecolor="#fdeecb", edgecolor="#8a6100", linewidth=1.4)
COLOR_SISTEMA = dict(facecolor="#e7f2ec", edgecolor="#1f4e3d", linewidth=1.8)
TITLE_COLOR = "#1f4e3d"
LABEL_COLOR_ACTOR = "#1f3864"
LABEL_COLOR_COMP = "#7a5900"
ARROW_COLOR = "#595959"

fig, ax = plt.subplots(figsize=(10.9, 7.12))
ax.set_xlim(0, 10.9)
ax.set_ylim(0, 7.12)
ax.axis("off")

fig.suptitle("Diagrama de Contexto del Sistema — SGCV-IA",
             fontsize=16, fontweight="bold", color=TITLE_COLOR, y=0.97)


def rounded_box(ax, xy, w, h, style, pad=0.02):
    x, y = xy
    box = FancyBboxPatch(
        (x, y), w, h,
        boxstyle=f"round,pad={pad},rounding_size=0.08",
        linewidth=style["linewidth"],
        edgecolor=style["edgecolor"],
        facecolor=style["facecolor"],
    )
    ax.add_patch(box)
    return box


def add_arrow(ax, start, end):
    ax.annotate(
        "", xy=end, xytext=start,
        arrowprops=dict(arrowstyle="-|>", color=ARROW_COLOR,
                         lw=1.4, shrinkA=0, shrinkB=0),
    )


# ---------------------------------------------------------------------------
# Caja central: SGCV-IA
# ---------------------------------------------------------------------------
center_x, center_y, center_w, center_h = 3.55, 2.55, 3.8, 1.7
rounded_box(ax, (center_x, center_y), center_w, center_h, COLOR_SISTEMA)
cx_mid = center_x + center_w / 2
cy_mid = center_y + center_h / 2
ax.text(cx_mid, cy_mid + 0.35, "SGCV-IA", ha="center", va="center",
        fontsize=16, fontweight="bold", color=TITLE_COLOR)
ax.text(cx_mid, cy_mid - 0.15,
        "Sistema de Gestión para Clínicas\nVeterinarias con Inteligencia Artificial",
        ha="center", va="center", fontsize=10.5, color="#333333")

# ---------------------------------------------------------------------------
# Actores / componentes periféricos: (nombre, xy, tamaño, estilo, etiqueta_flujo, nota_inferior)
# ---------------------------------------------------------------------------
boxes = [
    dict(name="Médico\nveterinario", xy=(0.35, 5.1), w=2.2, h=1.05,
         style=COLOR_ACTOR_HUMANO, flujo="datos clínicos",
         nota="Historiales, diagnósticos,\ntratamientos, IA", side="top-left"),
    dict(name="Propietario de\nla mascota", xy=(4.3, 5.9), w=2.2, h=1.05,
         style=COLOR_ACTOR_HUMANO, flujo="notificaciones",
         nota="Notificaciones y\nseguimiento", side="top-center"),
    dict(name="Administrador\ndel sistema", xy=(8.2, 5.1), w=2.2, h=1.05,
         style=COLOR_ACTOR_HUMANO, flujo="config. accesos",
         nota="Usuarios, roles\ny permisos", side="top-right"),
    dict(name="Personal\nadministrativo", xy=(0.35, 0.75), w=2.2, h=1.05,
         style=COLOR_ACTOR_HUMANO, flujo="citas / facturación",
         nota="Citas, inventario,\nfacturación, reportes", side="bottom-left"),
    dict(name="Motor de\nInteligencia Artificial", xy=(4.3, 0.2), w=2.2, h=1.05,
         style=COLOR_COMPONENTE_EXT, flujo="consulta IA",
         nota="Sugerencias\ndiagnósticas", side="bottom-center"),
    dict(name="Servicio de\nmensajería (WhatsApp)", xy=(8.2, 0.75), w=2.2, h=1.05,
         style=COLOR_COMPONENTE_EXT, flujo="mensajes",
         nota="Recordatorios y\nnotificaciones", side="bottom-right"),
]

for b in boxes:
    rounded_box(ax, b["xy"], b["w"], b["h"], b["style"])
    bx, by = b["xy"]
    bcx, bcy = bx + b["w"] / 2, by + b["h"] / 2
    color = LABEL_COLOR_ACTOR if b["style"] is COLOR_ACTOR_HUMANO else LABEL_COLOR_COMP
    ax.text(bcx, bcy, b["name"], ha="center", va="center",
            fontsize=11, fontweight="bold", color=color)

    # Nota debajo/encima de la caja
    if "top" in b["side"]:
        ax.text(bcx, by - 0.18, b["nota"], ha="center", va="top", fontsize=8.5)
    else:
        ax.text(bcx, by + b["h"] + 0.18, b["nota"], ha="center", va="bottom", fontsize=8.5)

    # Punto de conexión hacia el centro
    if by > center_y:
        start = (bcx, by)
        end = (cx_mid + (bcx - cx_mid) * 0.15, center_y + center_h)
    else:
        start = (bcx, by + b["h"])
        end = (cx_mid + (bcx - cx_mid) * 0.15, center_y)
    add_arrow(ax, start, end)

    # Etiqueta de flujo (texto itálico) a medio camino
    mx, my = (start[0] + end[0]) / 2, (start[1] + end[1]) / 2
    ax.text(mx + 0.15, my, b["flujo"], ha="left", va="center",
            fontsize=8.5, style="italic", color="#333333")

# ---------------------------------------------------------------------------
# Leyenda
# ---------------------------------------------------------------------------
leg_y = -0.35
ax.add_patch(Rectangle((1.4, leg_y), 0.4, 0.22, **COLOR_ACTOR_HUMANO))
ax.text(1.9, leg_y + 0.11, "Actor humano (interno al negocio)", va="center", fontsize=9.5)
ax.add_patch(Rectangle((5.6, leg_y), 0.4, 0.22, **COLOR_COMPONENTE_EXT))
ax.text(6.1, leg_y + 0.11, "Componente / servicio externo", va="center", fontsize=9.5)

ax.set_ylim(-0.7, 7.3)

plt.tight_layout()
plt.savefig("Diagrama_Contexto.png", dpi=200, bbox_inches="tight")
plt.savefig("Diagrama_Contexto.svg", bbox_inches="tight")
print("Generado: Diagrama_Contexto.png / .svg")
