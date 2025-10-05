# 📘 Drift Database — Padrão de Migração e Versionamento

Este documento explica **como manter o banco de dados do Drift atualizado**, gerenciar **migrações incrementais**, e **gerar histórico de schema** de forma padronizada.

---

## 🧱 Estrutura do Banco

Arquivo principal:
lib/database/app_database.dart


O banco usa:
- `schemaVersion` → controla a versão atual;
- `MigrationStrategy` → define as ações para `onCreate` e `onUpgrade`;
- `drift_dev` → gera dumps de schema (histórico);
- `build_runner` → gera os arquivos `.g.dart`.

---

## ⚙️ Comandos Essenciais

### 🔹 1. Gerar código do Drift
Sempre que adicionar/alterar tabelas, execute:

```bash
dart run build_runner build --delete-conflicting-outputs
```
🔹 2. Atualizar dump do schema

Após rodar o build, gere um snapshot do schema atual:

dart run drift_dev schema dump lib/database/app_database.dart drift_schemas/


📂 Isso cria/atualiza a pasta:

drift_schemas/
 ├─ 001.json
 ├─ 002.json
 └─ 003.json

🔹 3. Comparar mudanças entre versões

Para verificar o que mudou entre os schemas:

dart run drift_dev schema steps drift_schemas/


✅ O comando lista tabelas criadas, colunas adicionadas, removidas ou renomeadas.

🧩 Como atualizar o schema
1️⃣ Altere o modelo

Exemplo: adicionar uma coluna ou tabela nova no app_database.dart.

2️⃣ Atualize a versão

No AppDatabase, incremente o número:

@override
int get schemaVersion => 3; // Nova versão

3️⃣ Crie a migração incremental

Implemente o método correspondente dentro de onUpgrade:

onUpgrade: (Migrator m, from, to) async {
  for (var version = from; version < to; version++) {
    switch (version) {
      case 2:
        await _migrateFromV2ToV3(m);
        break;
    }
  }
}


Exemplo de migração:

Future<void> _migrateFromV2ToV3(Migrator m) async {
  await m.addColumn(formatoTable, formatoTable.descricao);
  print('✅ Migrated schema from V2 → V3');
}

🧠 Dica: Rodar o app com banco limpo (debug)

Se quiser forçar o Drift a criar o banco do zero (útil em dev):

Localize o arquivo db.sqlite no dispositivo.

Apague-o manualmente ou use um código de limpeza temporário:

final dbFolder = await getApplicationDocumentsDirectory();
final file = File(p.join(dbFolder.path, 'db.sqlite'));
if (await file.exists()) await file.delete();

🪄 Fluxo Completo — Quando fizer mudanças no banco

🧩 Alterar tabelas (adicionar, remover ou renomear campos)

🔢 Aumentar o schemaVersion

🧰 Adicionar migração incremental (_migrateFromVxToVy)

⚙️ Rodar:

dart run build_runner build --delete-conflicting-outputs


📜 Gerar dump do schema:

dart run drift_dev schema dump lib/database/app_database.dart drift_schemas/


✅ Testar no app (veja se onUpgrade roda sem erros)

📦 Dependências necessárias (dev)

Certifique-se de ter no pubspec.yaml:

dev_dependencies:
  build_runner: ^2.4.6
  drift_dev: ^2.16.0

🧾 Histórico de versões
Versão	Alterações principais	Data
1	Estrutura inicial das tabelas principais	2025-10-05
2	Ajuste em tabelas de vínculo	—
3	Exemplo de migração incremental adicionando nova coluna	—
📍 Observação

Não é necessário usar scripts .sql — o Drift gerencia tudo via código.

As migrações incrementais devem ser idempotentes (ou seja, não falhar se já existirem).

Use sempre await m.createAll() no onCreate() para criar tudo do zero.

✍️ Autor: Rafael
📅 Última atualização: 05/10/2025
🧩 Banco: SQLite via Drift ORM