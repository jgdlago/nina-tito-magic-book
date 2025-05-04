import 'dart:async';

import 'package:flame/components.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';
import 'package:nina_tito_magic_book/game/components/PlayerComponent.dart';
import 'package:nina_tito_magic_book/game/scenarios/Scenario.dart';

class LevelComponent extends World with HasGameReference<MagicBook> {
  final Scenario scene;
  final PlayerComponent player;

  LevelComponent({
    required this.scene,
    required this.player,
  });

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    await add(scene);
    await add(player);
  }
}
