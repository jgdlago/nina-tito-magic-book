import 'dart:async';
import 'package:flame/components.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';

class PlayerComponent extends SpriteAnimationComponent
    with HasGameReference<MagicBook> {
  final String character;

  PlayerComponent({
    required this.character,
    Vector2? position,
    Vector2? size,
    Anchor anchor = Anchor.center,
  }) : super(position: position, size: size, anchor: anchor);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animation = await game.loadSpriteAnimation(
      'main_characters/tito/idle/spritesheet.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.2,
        textureSize: Vector2(48, 48),
      ),
    );
  }
}
