import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';
import 'package:nina_tito_magic_book/game/components/DialogComponent.dart';
import 'package:nina_tito_magic_book/game/components/puzzle/PuzzleOverlay.dart';
import 'package:nina_tito_magic_book/game/ui/messages/DialogMessages.dart';

class WardrobePuzzleComponent extends PositionComponent
    with DragCallbacks, HasGameReference<MagicBook> {

  late PuzzleOverlay puzzleOverlay;

  WardrobePuzzleComponent({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    game.removeGameHUD();

    _addDialogs();

    await super.onLoad();
  }

  void _addDialogs() async {
    game.camera.viewport.add(
        DialogComponent(
            text: DialogMessages.level1WardrobePuzzleLayer1,
            onContinue: () {
              _initPuzzle();
            }
        )
    );
  }

  void _initPuzzle() async {
    puzzleOverlay = PuzzleOverlay();
    game.camera.viewport.add(puzzleOverlay);

    await Future.delayed(Duration.zero);

    final double padding = 20.0;
    final double gap = 10.0;
    final double scaleFactor = 0.5;
    final double centerY = game.size.y / 2;

    final imagePaths = [
      'main_characters/tito/idle/Idle (1).png',
      'main_characters/nina/idle/Idle (1).png',
    ];

    for (var i = 0; i < imagePaths.length; i++) {
      final img = await game.images.load(imagePaths[i]);
      final sprite = Sprite(img);

      final Vector2 spriteSize = Vector2(
        img.width.toDouble(),
        img.height.toDouble(),
      ) * scaleFactor;

      final comp = SpriteComponent()
        ..sprite = sprite
        ..size = spriteSize
        ..position = Vector2(
          padding + i * (spriteSize.x + gap),
          centerY - spriteSize.y / 2,
        )
        ..anchor = Anchor.topLeft;

      puzzleOverlay.add(comp);
    }
  }

  void closePuzzle() {
    puzzleOverlay.closePuzzle();
    game.showGameHUD();
  }
}