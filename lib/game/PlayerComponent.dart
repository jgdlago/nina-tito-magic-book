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
  late final SpriteAnimation runningAnimation;
  late final SpriteAnimation jumpingAnimation;
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

    await _loadAllAnimations();

    size = _setSize(idleAnimation.frames.first.sprite.srcSize);

    current = PlayerState.walk;
  }

  Future<void> _loadAllAnimations() async {
    idleAnimation = await _spriteAnimation('idle', 15);
    walkAnimation = await _spriteAnimation('walk', 15);
    runningAnimation = await _spriteAnimation('run', 15);
    jumpingAnimation = await _spriteAnimation('jump', 15);
    // fallingAnimation = await _spriteAnimation('fall', 1);

    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.walk: walkAnimation,
      PlayerState.running: runningAnimation,
      PlayerState.jumping: jumpingAnimation,
      // PlayerState.falling: fallingAnimation,
    };
  }

  Future<SpriteAnimation> _spriteAnimation(String state, int amount) async {
    final image = await game.images.load('main_characters/tito/$state/spritesheet.png');

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

  Vector2 _setSize(Vector2 firstFrameSize) {
    const desiredHeight = 256.0;
    final scale = desiredHeight / firstFrameSize.y;
    return firstFrameSize * scale;
  }
}
