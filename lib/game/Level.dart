import 'dart:async';

import 'package:flame/components.dart';
import 'package:nina_tito_magic_book/domain/entities/Player.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';
import 'package:nina_tito_magic_book/game/scenarios/Scenario.dart';

class Level extends World with HasGameRef<MagicBook> {
  final Scenario scene;
  final Player player;

  Level({
    required this.scene,
    required this.player,
  });

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    await add(scene);
  }
}
