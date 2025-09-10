CREATE TABLE IF NOT EXISTS via_cores_ordem_servico_table (
    id TEXT NOT NULL PRIMARY KEY UNIQUE,
    ordem_servico_id INTEGER NOT NULL,
    via_cores_id TEXT NOT NULL,
    ordem INTEGER NOT NULL DEFAULT 0,

    FOREIGN KEY (ordem_servico_id) REFERENCES ordem_servico_table(id) ON DELETE CASCADE,
    FOREIGN KEY (via_cores_id) REFERENCES via_cores_table(id) ON DELETE CASCADE
);

