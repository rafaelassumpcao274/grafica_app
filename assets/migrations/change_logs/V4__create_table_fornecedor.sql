CREATE TABLE IF NOT EXISTS fornecedor_table (
  id TEXT NOT NULL PRIMARY KEY,
  nome TEXT NOT NULL,
  contato TEXT,
  email TEXT,
  telefone TEXT,
  observacao TEXT,
  tipo_servico TEXT
);
