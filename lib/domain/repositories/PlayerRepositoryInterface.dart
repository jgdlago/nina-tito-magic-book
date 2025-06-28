import 'package:nina_tito_magic_book/domain/entities/Player.dart';

abstract class PlayerRepositoryInterface {
  Future<void> createPlayer(Player player, int userId);
  Future<Player?> getPlayerByCurrentUser();
  Future<void> updateGroupAccessCode(String code);
}