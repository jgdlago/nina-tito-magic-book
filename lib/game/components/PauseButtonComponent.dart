import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';

class PauseButtonComponent extends SpriteComponent with TapCallbacks, HasGameReference<MagicBook> {
  late final Sprite pauseSprite;
  late final Sprite playSprite;
  bool isPaused = false;

  PauseButtonComponent({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    pauseSprite = Sprite(game.images.fromCache('hud/pause.png'));
    playSprite = Sprite(game.images.fromCache('hud/play.png'));
    sprite = pauseSprite;
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.togglePause();
  }

  @override
  void update(double dt) {
    super.update(dt);
    sprite = game.paused ? playSprite : pauseSprite;
  }
}