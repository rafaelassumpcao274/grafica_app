import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:drift/drift.dart';

Future<void> master(GeneratedDatabase db) async {
  await db.customStatement(
      'CREATE TABLE IF NOT EXISTS schema_version (version INTEGER PRIMARY KEY)');

  await db.customStatement(
      'CREATE TABLE IF NOT EXISTS changelog (id TEXT PRIMARY KEY, description TEXT, applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, name TEXT)');

  final rows =
      await db.customSelect('SELECT version FROM schema_version').get();
  final existingVersions = rows.map((r) => r.read<int>('version')).toSet();

  final manifest = await rootBundle.loadString('AssetManifest.json');
  final migrationFiles = (json.decode(manifest) as Map<String, dynamic>)
      .keys
      .where((key) =>
          key.startsWith(
              'assets/migrations/change_logs/') &&
          key.endsWith('.sql'))
      .toList()
    ..sort();

  for (final path in migrationFiles) {
    final match = RegExp(r'V(\d+)__').firstMatch(path);
    if (match == null) continue;

    final version = int.parse(match.group(1)!);
    if (!existingVersions.contains(version)) {
      final script = await rootBundle.loadString(path);
      final statements =
          script.split(';').map((s) => s.trim()).where((s) => s.isNotEmpty);

      await db.transaction(() async {
        for (final stmt in statements) {
          await db.customStatement(stmt);
        }
        await db.customInsert(
          'INSERT INTO schema_version (version) VALUES (?)',
          variables: [Variable.withInt(version)],
        );
        await db.customInsert(
          'INSERT INTO changelog (id, description, name) VALUES (?, ?, ?)',
          variables: [
            Variable.withString('V$version'),
            Variable.withString('Migration V$version applied'),
            Variable.withString(path.split('/').last)
          ],
        );
        print('✅ Applied migration V$version');
      });
    }
  }
}
