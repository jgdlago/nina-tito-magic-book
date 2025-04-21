
import 'package:flame/components.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';
import 'package:nina_tito_magic_book/game/scenarios/Scenario.dart';

class Level extends World with HasGameRef<MagicBook> {
  final Scenario scene;

  Level({required this.scene});
}