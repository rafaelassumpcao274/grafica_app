CREATE TABLE IF NOT EXISTS fornecedor_ordem_servico_table (
    id TEXT NOT NULL PRIMARY KEY UNIQUE,
    ordem_servico_id INTEGER NOT NULL,
    fornecedor_id TEXT NOT NULL,
    custo REAL NOT NULL,

    FOREIGN KEY (ordem_servico_id) REFERENCES ordem_servico(id) ON DELETE CASCADE,
    FOREIGN KEY (fornecedor_id) REFERENCES fornecedor(id) ON DELETE CASCADE
);