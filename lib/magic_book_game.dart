import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MagicBookGameWidget extends StatelessWidget {
  const MagicBookGameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: MagicBookGame(),
    );
  }
}

class MagicBookGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    // Inicialize o game aqui
    debugPrint('Jogo iniciado!');
  }
}
