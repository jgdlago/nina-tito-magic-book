import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';
import 'package:nina_tito_magic_book/game/ui/themes/GameTextStyles.dart';
import 'package:nina_tito_magic_book/presentation/theme/AppColors.dart';

class DialogComponent extends PositionComponent with HasGameReference<MagicBook> {
  late SpriteComponent background;
  late TextBoxComponent textBox;
  late HudButtonComponent continueButton;
  SpriteComponent? imageComponent;
  final String text;
  final Function? onContinue;
  final Vector2? dialogSize;
  final Image? dialogImage;
  // Espaçamento entre o texto e a imagem, em pixels
  final double imageSpacing = 10;

  DialogComponent({
    required this.text,
    this.onContinue,
    this.dialogImage,
    this.dialogSize,
  }) : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    final viewport = game.camera.viewport.size;
    size = dialogSize ?? Vector2(viewport.x * 0.60, viewport.y * 0.85);

    // Background
    final image = await game.images.load('ui/dialog_torn_paper.png');
    background = SpriteComponent(
      sprite: Sprite(image),
      size: size,
      position: Vector2.zero(),
      anchor: Anchor.topLeft,
    );
    add(background);

    // Text
    textBox = TextBoxComponent(
      text: text,
      boxConfig: TextBoxConfig(maxWidth: size.x * 0.85),
      textRenderer: TextPaint(style: GameTextStyles.dialogBody),
      position: Vector2(size.x * 0.5, 0),
      anchor: Anchor.topCenter,
    );
    add(textBox);

    // Button
    await _addButton();

    // Image
    if (dialogImage != null) {
      imageComponent = SpriteComponent(
        sprite: Sprite(dialogImage!),
        size: Vector2(size.x * 0.4, size.y * 0.5),
        position: Vector2(size.x * 0.5, 0),
        anchor: Anchor.topCenter,
      );
      add(imageComponent!);
    }

    position = viewport / 2;

    await super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    position = game.camera.viewport.size / 2;

    if (textBox.size.y > 0) {
      textBox.position.y = (size.y - textBox.size.y - (imageComponent != null
          ? imageComponent!.size.y + imageSpacing
          : 0) - continueButton.size.y - 16) * 0.20
          ;

      if (imageComponent != null) {
        imageComponent!.position.y = textBox.position.y +
            textBox.size.y +
            imageSpacing;
      }

      continueButton.position.y =
          size.y - continueButton.size.y * 0.75;
    }
  }

  Future<void> _addButton() async {
    final buttonSprite = await game.images.load('ui/default_button.png');
    final buttonSize = Vector2(size.x * 0.3, 50);

    continueButton = HudButtonComponent(
      button: SpriteComponent(
        sprite: Sprite(buttonSprite),
        size: buttonSize,
      ),
      anchor: Anchor.center,
      position: Vector2(size.x * 0.5, size.y * 0.85),
      size: buttonSize,
      onPressed: () {
        onContinue?.call();
        removeFromParent();
      },
    );

    continueButton.add(
      TextComponent(
        text: 'Continuar',
        position: continueButton.size / 2,
        textRenderer: TextPaint(
          style: GameTextStyles.dialogBody.copyWith(
            color: AppColors.mysticalBlack,
          ),
        ),
        anchor: Anchor.center,
        priority: 1000,
      ),
    );

    add(continueButton);
  }
}