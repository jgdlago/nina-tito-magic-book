import 'package:nina_tito_magic_book/data/datasources/database_helper.dart';
import 'package:nina_tito_magic_book/data/models/gender_enum.dart';
import 'package:nina_tito_magic_book/domain/entities/user.dart';
import 'package:nina_tito_magic_book/domain/repositories/user_repository_interface.dart';

class UserRepositoryImplements implements UserRepositoryInterface {
  final DatabaseHelper _databaseHelper;

  UserRepositoryImplements(this._databaseHelper);

  @override
  Future<bool> userExists() async {
    final db = await _databaseHelper.database;
    final result = await db.query('users');
    return result.isNotEmpty;
  }

  @override
  Future<User?> getUser() async {
    final db = await _databaseHelper.database;
    final result = await db.query('users', limit: 1);

    if (result.isNotEmpty) {
      final user = result.first;
      return User(
        id: user['id'] as int,
        name: user['name'] as String,
        age: user['age'] as int,
        gender: user['gender'] as GenderEnum,
      );
    }
    return null;
  }

  @override
  Future<void> createUser(String name, int age, GenderEnum gender, {int? playerId}) async {
    final db = await _databaseHelper.database;
    await db.insert('users', {
      'name': name,
      'age': age,
      'gender': gender.toString().split('.').last,
      if (playerId != null) 'player_id': playerId,
    });
  }
}
