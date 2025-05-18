import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';
import 'package:nina_tito_magic_book/game/ui/themes/GameTextStyles.dart';
import 'package:nina_tito_magic_book/presentation/theme/AppColors.dart';

class DialogComponent extends PositionComponent with HasGameReference<MagicBook> {
  late SpriteComponent background;
  late TextBoxComponent textBox;
  late HudButtonComponent continueButton;
  final String text;
  final Function? onContinue;
  final Vector2? dialogSize;

  DialogComponent({
    required this.text,
    this.onContinue,
    this.dialogSize,
  }) : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    final viewport = game.camera.viewport.size;
    size = dialogSize ?? Vector2(viewport.x * 0.60, viewport.y * 0.85);

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
      boxConfig: TextBoxConfig(maxWidth: size.x * 0.85),
      textRenderer: TextPaint(
        style: GameTextStyles.dialogBody,
      ),
      position: Vector2(size.x * .5, size.y * .45),
      anchor: Anchor.center,
    );
    add(textBox);

    await _addButton();

    position = viewport / 2;

    await super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position = game.camera.viewport.size / 2;
  }

  Future<void> _addButton() async {
    final buttonSprite = await game.images.load('ui/default_button.png');

    final buttonSize = Vector2(size.x * 0.3, 50);
    final buttonPosition = Vector2(size.x * 0.5, size.y * 0.85);

    continueButton = HudButtonComponent(
      button: SpriteComponent(
        sprite: Sprite(buttonSprite),
        size: buttonSize,
      ),
      anchor: Anchor.center,
      position: buttonPosition,
      size: buttonSize,
      onPressed: () {
        if (onContinue != null) {
          onContinue!();
        }
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