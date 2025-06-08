import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';
import 'package:nina_tito_magic_book/game/components/puzzle/PuzzleOverlay.dart';

class WardrobePuzzleComponent extends PositionComponent
    with DragCallbacks, HasGameReference<MagicBook> {

  WardrobePuzzleComponent({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    game.removeGameHUD();
    game.camera.viewport.add(PuzzleOverlay());
    await super.onLoad();
  }
}
