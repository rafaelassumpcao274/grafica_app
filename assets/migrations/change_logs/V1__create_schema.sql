CREATE TABLE IF NOT EXISTS clientes_table(
  id TEXT NOT NULL PRIMARY KEY,
  nome_empresa TEXT NOT NULL,
  documento TEXT NOT NULL CHECK (length(documento) <= 14),
  email TEXT,
  contato TEXT,
  telefone TEXT CHECK (length(telefone) <= 11)
);

CREATE TABLE IF NOT EXISTS formato_table (
  id TEXT NOT NULL PRIMARY KEY,
  descricao TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS papel_table (
  id TEXT NOT NULL PRIMARY KEY,
  descricao TEXT NOT NULL,
  quantidade_papel INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS ordem_servico_table (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  cliente_id TEXT NOT NULL,
  formato_id TEXT,
  material TEXT NOT NULL,
  cor_frente TEXT NOT NULL,
  cor_verso TEXT NOT NULL,
  quantidade_folha INTEGER NOT NULL,
  numeracao_inicial INTEGER NOT NULL,
  numeracao_final INTEGER NOT NULL,
  observacao TEXT NOT NULL,
  
  FOREIGN KEY (cliente_id) REFERENCES clientes(id),
  FOREIGN KEY (formato_id) REFERENCES formato(id)
);


CREATE TABLE IF NOT EXISTS uf (
  id TEXT NOT NULL PRIMARY KEY,
  descricao TEXT NOT NULL,
  sigla TEXT NOT NULL CHECK (length(sigla) = 2)
);

CREATE TABLE IF NOT EXISTS via_cores (
  id TEXT NOT NULL PRIMARY KEY,
  descricao TEXT NOT NULL
);
