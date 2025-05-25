import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';
import 'package:flutter/material.dart';

class JumpButtonComponent extends SpriteComponent with HasGameReference<MagicBook>, TapCallbacks {
  late Function() onJump;
  bool _isPressed = false;

  JumpButtonComponent({
    required this.onJump,
    Vector2? position,
  }) : super(
    position: position ?? Vector2.zero(),
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = Sprite(game.images.fromCache('hud/jump.png'));

    size = Vector2(70, 70);
    priority = 100;
  }

  @override
  bool onTapDown(TapDownEvent event) {
    _isPressed = true;
    onJump();
    return true;
  }

  @override
  bool onTapUp(TapUpEvent event) {
    _isPressed = false;
    return true;
  }

  @override
  bool onTapCancel(TapCancelEvent event) {
    _isPressed = false;
    return true;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (sprite != null) {
      final paint = Paint()
        ..color = _isPressed
            ? Colors.white.withOpacity(1.0)
            : Colors.white.withOpacity(0.7);

      canvas.save();
      canvas.translate(size.x / 2, size.y / 2);
      canvas.scale(scale.x, scale.y);
      canvas.translate(-size.x / 2, -size.y / 2);

      sprite!.render(canvas, size: size, overridePaint: paint);
      canvas.restore();
    }
  }
}