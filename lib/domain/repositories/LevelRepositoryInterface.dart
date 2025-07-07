import 'package:nina_tito_magic_book/domain/entities/Level.dart';

abstract class LevelRepositoryInterface {
  Future<Level?> getLevel(int levelOrder);
  Future<bool> isLevelCompleted(int levelOrder);
  Future<void> completeLevel(int levelOrder);
  Future<Level?> getLastUnfinishedLevel();
}