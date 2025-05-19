import 'package:nina_tito_magic_book/domain/entities/Level.dart';

abstract class LevelRepositoryInterface {
  Future<Level?> getLevel(int levelOrder);
}