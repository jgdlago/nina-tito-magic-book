import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';

class DialogComponent extends PositionComponent with HasGameReference<MagicBook> {
  late SpriteComponent background;
  late TextBoxComponent textBox;
  final String text;
  final Vector2? dialogSize;

  DialogComponent({
    required this.text,
    this.dialogSize,
  }) : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    final viewport = game.camera.viewport.size;
    size = dialogSize ??
        Vector2(viewport.x * 0.60, viewport.y * 0.85);

    final image = await game.images.load('ui/dialog_torn_paper.png');
    background = SpriteComponent(
      sprite: Sprite(image),
      size: size,
      position: Vector2.zero(),
      anchor: Anchor.topLeft,
    );
    add(background);

    textBox = TextBoxComponent(
      text: text,
      boxConfig: TextBoxConfig(
        maxWidth: size.x * 0.85,    // 85% da largura do diálogo
        timePerChar: 0,
      ),
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      position: Vector2(size.x * 0.5, size.y * 0.5),
      anchor: Anchor.center,
    );
    add(textBox);

    position = viewport / 2;

    await super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position = game.camera.viewport.size / 2;
  }
}
