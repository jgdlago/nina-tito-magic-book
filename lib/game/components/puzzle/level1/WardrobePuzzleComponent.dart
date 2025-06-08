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

    final boySprite = SpriteComponent()
      ..sprite = Sprite(await game.images.load('main_characters/tito/idle/Idle (1).png'))
      ..scale = Vector2.all(0.5)
      ..position = Vector2(game.size.x / 2 - 120, game.size.y / 2 - 75)
      ..anchor = Anchor.center;

    final girlSprite = SpriteComponent()
      ..sprite = Sprite(await game.images.load('main_characters/nina/idle/Idle (1).png'))
      ..scale = Vector2.all(0.5)
      ..position = Vector2(game.size.x / 2 - 120, game.size.y / 2 - 75)
      ..anchor = Anchor.center;

    puzzleOverlay.add(boySprite);
    puzzleOverlay.add(girlSprite);

  }

  void closePuzzle() {
    puzzleOverlay.closePuzzle();
    game.showGameHUD();
  }
}