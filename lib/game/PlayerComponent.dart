import 'dart:async';
import 'package:flame/components.dart';
import 'package:nina_tito_magic_book/data/models/PlayerStateEnum.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';

class PlayerComponent extends SpriteAnimationGroupComponent<PlayerState>
    with HasGameReference<MagicBook> {
  final String character;
  final double stepTime = 0.05;

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation walkAnimation;
  // late final SpriteAnimation runningAnimation;
  // late final SpriteAnimation jumpingAnimation;
  // late final SpriteAnimation fallingAnimation;

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

    // Carrega todas as animações
    await _loadAllAnimations();

    // Ajusta o tamanho do componente com base no primeiro frame da idle
    final firstFrameSize = idleAnimation.frames.first.sprite.srcSize;
    const desiredHeight = 256.0;
    final scale = desiredHeight / firstFrameSize.y;
    size = firstFrameSize * scale;

    // Define animação inicial
    current = PlayerState.idle;
  }

  Future<void> _loadAllAnimations() async {
    idleAnimation = await _spriteAnimation('idle', 15);
    walkAnimation = await _spriteAnimation('walk', 15);
    // runningAnimation = await _spriteAnimation('run', 12);
    // jumpingAnimation = await _spriteAnimation('jump', 1);
    // fallingAnimation = await _spriteAnimation('fall', 1);

    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.walk: walkAnimation,
      // PlayerState.running: runningAnimation,
      // PlayerState.jumping: jumpingAnimation,
      // PlayerState.falling: fallingAnimation,
    };
  }

  Future<SpriteAnimation> _spriteAnimation(String state, int amount) async {
    final image = await game.images.load('main_characters/tito/$state/spritesheet.png');

    // Converte width/height para double e calcula o tamanho de cada frame
    final frameSize = Vector2(
      image.width.toDouble()  / amount,
      image.height.toDouble(),
    );

    return SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.sequenced(
        amount:      amount,
        stepTime:    stepTime,
        textureSize: frameSize,
        loop:        true,
      ),
    );
  }
}
