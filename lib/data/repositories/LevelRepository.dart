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
}