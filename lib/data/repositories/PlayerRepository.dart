import 'package:nina_tito_magic_book/data/datasources/DatabaseHelper.dart';
import 'package:nina_tito_magic_book/domain/entities/User.dart';
import 'package:nina_tito_magic_book/domain/repositories/PlayerRepositoryInterface.dart';
import 'package:nina_tito_magic_book/domain/repositories/UserRepositoryInterface.dart';

class PlayerRepository implements PlayerRepositoryInterface {
  final DatabaseHelper _databaseHelper;
  final UserRepositoryInterface _userRepository;

  PlayerRepository(this._databaseHelper, this._userRepository);

  @override
  Future<Map<String, dynamic>?> getPlayerByCurrentUser() async {
    final db = await _databaseHelper.database;
    final User? user = await _userRepository.getCurrentUser();

    if (user == null) return null;

    final result = await db.query(
      'players',
      where: 'user_id = ?',
      whereArgs: [user.id],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first;
    }

    return null;
  }
}
