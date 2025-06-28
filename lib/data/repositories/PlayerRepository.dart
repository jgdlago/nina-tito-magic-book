import 'package:nina_tito_magic_book/data/datasources/DatabaseHelper.dart';
import 'package:nina_tito_magic_book/domain/entities/Player.dart';
import 'package:nina_tito_magic_book/domain/entities/User.dart';
import 'package:nina_tito_magic_book/domain/repositories/PlayerRepositoryInterface.dart';
import 'package:nina_tito_magic_book/domain/repositories/UserRepositoryInterface.dart';

class PlayerRepository implements PlayerRepositoryInterface {
  final DatabaseHelper _databaseHelper;
  final UserRepositoryInterface _userRepository;

  PlayerRepository(this._databaseHelper, this._userRepository);

  @override
  Future<Player?> getPlayerByCurrentUser() async {
    final db = await _databaseHelper.database;
    final User? user = await _userRepository.getCurrentUser();

    if (user == null || user.playerId == null) return null;

    final result = await db.query(
      'players',
      where: 'id = ?',
      whereArgs: [user.playerId],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return Player.fromMap(result.first);
    }

    return null;
  }

  @override
  Future<void> createPlayer(Player player, int userId) async {
    final db = await _databaseHelper.database;

    final playerId = await db.insert('players', {
      'character': player.character.toString().split('.').last,
      'equipped_skin': player.equippedSkin.toString().split('.').last,
    });

    await db.update(
      'users',
      {'player_id': playerId},
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  @override
  Future<void> updateGroupAccessCode(String code) async {
    final db = await _databaseHelper.database;
    final User? user = await _userRepository.getCurrentUser();

    if (user == null || user.playerId == null) {
      throw Exception('Usuário ou playerId não encontrado');
    }

    await db.update(
      'players',
      {'group_access_code': code},
      where: 'id = ?',
      whereArgs: [user.playerId],
    );
  }
}
