// SGCV-IA — Backend real del MVP
// Sustituye la persistencia únicamente-en-navegador (localStorage) por un
// servicio Node/Express con base de datos SQLite embebida.
//
// Endpoints:
//   POST /api/auth/login   -> valida credenciales EN EL SERVIDOR (no en el frontend)
//   GET  /api/state        -> devuelve el estado completo de la aplicación (o los datos semilla)
//   POST /api/state        -> guarda el estado completo (persistencia real, sobrevive a reinicios)
//
// El estado se guarda como un único documento JSON versionado en SQLite.
// Es una persistencia simple mono-documento (adecuada para el alcance de un MVP
// académico), pero real: los datos sobreviven a un `docker compose down && up`
// y a un refresco de página en un navegador distinto, a diferencia de
// localStorage.

const path = require("path");
const express = require("express");
const Database = require("better-sqlite3");

const DB_PATH = process.env.SGCV_DB_PATH || path.join(__dirname, "data", "sgcv.db");
require("fs").mkdirSync(path.dirname(DB_PATH), { recursive: true });

const db = new Database(DB_PATH);
db.pragma("journal_mode = WAL");

db.exec(`
  CREATE TABLE IF NOT EXISTS app_state (
    id INTEGER PRIMARY KEY CHECK (id = 1),
    data TEXT NOT NULL,
    updated_at TEXT NOT NULL
  );
  CREATE TABLE IF NOT EXISTS auth_attempts (
    email TEXT PRIMARY KEY,
    fallidos INTEGER NOT NULL DEFAULT 0,
    bloqueado_hasta TEXT
  );
`);

// Credenciales de demostración. En un sistema real estarían hasheadas
// (bcrypt) y en una tabla de usuarios; aquí se centralizan al menos en el
// servidor en vez de embebidas en el bundle del frontend.
const USERS = {
  "vet@sgcv.cl": { pass: "vet123", role: "veterinario" },
  "admin@sgcv.cl": { pass: "adm123", role: "administrativo" },
};
const MAX_INTENTOS = 5;

const app = express();
app.use(express.json({ limit: "5mb" }));

// ---------- Auth (RF-24 / RNF-05: validación en servidor) ----------
app.post("/api/auth/login", (req, res) => {
  const { email, password } = req.body || {};
  const key = String(email || "").toLowerCase();

  const row = db.prepare("SELECT * FROM auth_attempts WHERE email = ?").get(key);
  const fallidos = row ? row.fallidos : 0;

  if (fallidos >= MAX_INTENTOS) {
    return res.status(423).json({
      ok: false,
      bloqueado: true,
      message: "Cuenta bloqueada por 5 intentos fallidos. Contacte al administrador.",
    });
  }

  const user = USERS[key];
  if (user && user.pass === password) {
    db.prepare(
      "INSERT INTO auth_attempts (email, fallidos, bloqueado_hasta) VALUES (?, 0, NULL) " +
        "ON CONFLICT(email) DO UPDATE SET fallidos = 0"
    ).run(key);
    return res.json({ ok: true, role: user.role });
  }

  const nuevosFallidos = fallidos + 1;
  db.prepare(
    "INSERT INTO auth_attempts (email, fallidos) VALUES (?, ?) " +
      "ON CONFLICT(email) DO UPDATE SET fallidos = ?"
  ).run(key, nuevosFallidos, nuevosFallidos);

  return res.status(401).json({
    ok: false,
    bloqueado: nuevosFallidos >= MAX_INTENTOS,
    intentos: nuevosFallidos,
    message:
      nuevosFallidos >= MAX_INTENTOS
        ? "Cuenta bloqueada por 5 intentos fallidos. Contacte al administrador."
        : `Credenciales incorrectas. Intento ${nuevosFallidos} de 5.`,
  });
});

// ---------- Estado de la aplicación (persistencia real) ----------
app.get("/api/state", (req, res) => {
  const row = db.prepare("SELECT data FROM app_state WHERE id = 1").get();
  if (!row) return res.json(null);
  res.json(JSON.parse(row.data));
});

app.post("/api/state", (req, res) => {
  const data = JSON.stringify(req.body || {});
  db.prepare(
    "INSERT INTO app_state (id, data, updated_at) VALUES (1, ?, datetime('now')) " +
      "ON CONFLICT(id) DO UPDATE SET data = excluded.data, updated_at = excluded.updated_at"
  ).run(data);
  res.json({ ok: true });
});

app.get("/api/health", (req, res) => res.json({ ok: true }));

// ---------- Servir el frontend estático ----------
app.use(
  express.static(path.join(__dirname, ".."), {
    index: "SGCV-IA_Prototipo_Funcional.html",
  })
);

const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`SGCV-IA backend escuchando en puerto ${PORT}`);
  console.log(`Base de datos SQLite: ${DB_PATH}`);
});

