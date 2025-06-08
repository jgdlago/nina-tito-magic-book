import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';
import 'package:nina_tito_magic_book/game/components/DialogComponent.dart';
import 'package:nina_tito_magic_book/game/components/puzzle/PuzzleOverlay.dart';
import 'package:nina_tito_magic_book/game/ui/messages/DialogMessages.dart';

class WardrobePuzzleComponent extends PositionComponent
    with DragCallbacks, HasGameReference<MagicBook> {

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
          game.camera.viewport.add(PuzzleOverlay());
        }
      )
    );
  }
}
