import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';

class PlayerComponent extends SpriteAnimationComponent
    with HasGameReference<MagicBook> {
  final String character;

  PlayerComponent({
    required this.character,
    required Vector2 position,
  }) : super(
    position: position,
    anchor: Anchor.bottomLeft,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final image = await game.images.load(
      'main_characters/tito/idle/spritesheet.png',
    );

    const frameCount = 15;
    final frameWidth = image.width.toDouble() / frameCount;
    final frameHeight = image.height.toDouble();

    final sheet = SpriteSheet(
      image: image,
      srcSize: Vector2(frameWidth, frameHeight),
    );
    animation = sheet.createAnimation(
      row: 0,
      stepTime: 0.06,
      to: frameCount,
      loop: true,
    );

    const desiredHeight = 256;
    final scale = desiredHeight / frameHeight;
    size = sheet.srcSize * scale;
  }
}
