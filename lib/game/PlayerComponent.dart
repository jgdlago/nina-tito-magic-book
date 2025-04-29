import 'dart:async';
import 'package:flame/components.dart';
import 'package:nina_tito_magic_book/data/models/PlayerStateEnum.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';

class PlayerComponent extends SpriteAnimationGroupComponent<PlayerState>
    with HasGameReference<MagicBook> {
  final String character;

  PlayerComponent({
    required this.character,
    required Vector2 position,
  }) : super(
    position: position,
    anchor: Anchor.bottomCenter,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // 1) Carrega o spritesheet de idle
    final image = await game.images.load(
      'main_characters/tito/idle/spritesheet.png',
    );

    // 2) Calcula dimensões de cada frame
    const frameCount = 15;
    final frameW = image.width.toDouble() / frameCount;
    final frameH = image.height.toDouble();

    // 3) Cria a animação de idle
    final idleAnimation = SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.sequenced(
        amount: frameCount,
        stepTime: 0.06,
        textureSize: Vector2(frameW, frameH),
      ),
    );

    // 4) Popula o mapa de animações com apenas 'idle'
    animations = {
      PlayerState.idle: idleAnimation,
    };

    // 5) Define a animação inicial
    current = PlayerState.idle;

    // 6) Ajusta o tamanho do componente (altura fixa de 128 px)
    const desiredHeight = 256;
    final scale = desiredHeight / frameH;
    size = Vector2(frameW, frameH) * scale;
  }
}
