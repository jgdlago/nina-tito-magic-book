import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';

class PauseButtonComponent extends SpriteComponent with TapCallbacks, HasGameReference<MagicBook> {
  PauseButtonComponent({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = Sprite(game.images.fromCache('hud/pause.png'));
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (game.paused) {
      game.resumeEngine();
    } else {
      game.pauseEngine();
      _showPauseMenu();
    }
  }

  void _showPauseMenu() {
    // Menu Pause
    print("Jogo pausado - Mostrar menu de pause");
  }
}