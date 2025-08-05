ALTER TABLE ordem_servico_table ADD COLUMN created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE ordem_servico_table ADD COLUMN possui_numeracao BIT NOT NULL DEFAULT false;
