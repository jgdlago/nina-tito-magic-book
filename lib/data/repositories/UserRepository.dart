import 'package:nina_tito_magic_book/data/datasources/DatabaseHelper.dart';
import 'package:nina_tito_magic_book/data/models/GenderEnum.dart';
import 'package:nina_tito_magic_book/domain/entities/User.dart';
import 'package:nina_tito_magic_book/domain/repositories/UserRepositoryInterface.dart';

class UserRepository implements UserRepositoryInterface {
  final DatabaseHelper _databaseHelper;

  UserRepository(this._databaseHelper);

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
        gender: GenderEnumExtension.genderFromString(user['gender'] as String),
      );
    }
    return null;
  }

  @override
  Future<void> createUser(User user) async {
    final db = await _databaseHelper.database;
    await db.insert('users', {
      'name': user.name,
      'age': user.age,
      'gender': user.gender.label
    });
  }

  @override
  Future<Map<String, dynamic>?> getUserProgress() async {
    final db = await _databaseHelper.database;
    final result = await db.query(
      'user_progress',
      orderBy: 'updated_at DESC',
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first;
    }

    return null;
  }
}
