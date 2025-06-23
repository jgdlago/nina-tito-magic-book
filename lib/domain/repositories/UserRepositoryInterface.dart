import 'package:nina_tito_magic_book/domain/entities/User.dart';

abstract class UserRepositoryInterface {
  Future<bool> userExists();
  Future<User?> getCurrentUser();
  Future<User> createUser(User user);
  Future<Map<String, dynamic>?> getUserProgress();
  Future<void> updateTermsAcceptance(int userId, DateTime acceptedAt);
}
