import 'package:flame/components.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';
import 'package:flutter/material.dart';

class DialogComponent extends PositionComponent with HasGameReference<MagicBook> {
  late SpriteComponent background;
  late TextComponent textBox;
  final String text;
  final Vector2? dialogSize;

  DialogComponent({
    required this.text,
    this.dialogSize,
  }) :
        super(
        anchor: Anchor.center,
      );

  @override
  Future<void> onLoad() async {
    final viewportSize = game.camera.viewport.size;
    size = dialogSize ?? Vector2(
      viewportSize.x * 0.60,  // 60% da largura da tela
      viewportSize.y * 0.85,  // 85% da altura da tela
    );

    final image = await game.images.load('ui/dialog_torn_paper.png');
    background = SpriteComponent(
      sprite: Sprite(image),
      size: size,
      position: Vector2.zero(),
      anchor: Anchor.topLeft,
    );
    add(background);

    textBox = TextComponent(
      text: text,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      anchor: Anchor.center,
      position: size / 2,
    );
    add(textBox);

    position = Vector2(
      viewportSize.x / 2,
      viewportSize.y / 2,
    );

    await super.onLoad();
  }

  @override
  void update(double dt) {
    final viewportSize = game.camera.viewport.size;
    position = Vector2(
      viewportSize.x / 2,
      viewportSize.y / 2,
    );

    super.update(dt);
  }
}