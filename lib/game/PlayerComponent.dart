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

    final image = await game.images.load('main_characters/tito/idle/spritesheet.png');

    animation = SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.sequenced(
        amount: 15,
        stepTime: 0.05,
        textureSize: Vector2.all(64),
      ),
    );
  }
}
