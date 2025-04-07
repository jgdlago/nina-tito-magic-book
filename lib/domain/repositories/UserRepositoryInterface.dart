import 'package:nina_tito_magic_book/domain/entities/User.dart';

abstract class UserRepositoryInterface {
  Future<bool> userExists();
  Future<User?> getUser();
  Future<void> createUser(User user);
}
