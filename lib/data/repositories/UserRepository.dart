import 'package:nina_tito_magic_book/data/datasources/DatabaseHelper.dart';
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
  Future<User?> getCurrentUser() async {
    final db = await _databaseHelper.database;
    final result = await db.query('users', limit: 1);

    if (result.isNotEmpty) {
      final userMap = result.first;
      return User.fromMap(userMap);
    }

    return null;
  }

  @override
  Future<User> createUser(User user) async {
    final db = await _databaseHelper.database;
    final id = await db.insert('users', user.toMap());

    return User(
      id: id,
      name: user.name,
      age: user.age,
      gender: user.gender,
    );
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
