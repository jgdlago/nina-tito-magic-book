import 'package:nina_tito_magic_book/data/datasources/DatabaseHelper.dart';
import 'package:nina_tito_magic_book/domain/entities/Level.dart';
import 'package:nina_tito_magic_book/domain/repositories/LevelRepositoryInterface.dart';

class LevelRepository implements LevelRepositoryInterface {
  final DatabaseHelper _databaseHelper;

  LevelRepository(this._databaseHelper);

  @override
  Future<Level?> getLevel(int levelOrder) async {
    final db = await _databaseHelper.database;
    final result = await db.query(
      'levels',
      where: 'level_order = ?',
      whereArgs: [levelOrder],
      limit: 1,
    );
    if (result.isEmpty) return null;
    return Level.fromMap(result.first);
  }

  @override
  Future<bool> isLevelCompleted(int levelOrder) async {
    final db = await _databaseHelper.database;
    final result = await db.rawQuery(
      '''
      SELECT COUNT(*) as completed 
      FROM levels 
      WHERE level_order = ? 
        AND finished_at IS NOT NULL
      ''',
      [levelOrder],
    );
    return (result.first['completed'] as int) > 0;
  }

  @override
  Future<void> completeLevel(int levelOrder) async {
    final db = await _databaseHelper.database;
    await db.rawUpdate(
      '''
      UPDATE levels 
      SET finished_at = CURRENT_TIMESTAMP 
      WHERE level_order = ?
      ''',
      [levelOrder],
    );
  }

  @override
  Future<Level?> getLastUnfinishedLevel() async {
    final db = await _databaseHelper.database;
    final result = await db.query(
      'levels',
      where: 'finished_at IS NULL',
      orderBy: 'level_order ASC',
      limit: 1,
    );

    if (result.isEmpty) return null;
    return Level.fromMap(result.first);
  }
}