import 'package:nina_tito_magic_book/data/models/gender_enum.dart';
import 'package:nina_tito_magic_book/domain/entities/user.dart';

abstract class UserRepositoryInterface {
  Future<bool> userExists();
  Future<User?> getUser();
  Future<void> createUser(String name, int age, GenderEnum gender, {int? playerId});
}
