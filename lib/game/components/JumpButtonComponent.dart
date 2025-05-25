import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';

class JumpButtonComponent extends SpriteComponent with HasGameReference<MagicBook>, TapCallbacks {
  late Function() onJump;

  JumpButtonComponent({
    required this.onJump,
    Vector2? position,
  }) : super(
    position: position ?? Vector2.zero(),
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = Sprite(game.images.fromCache('ui/jump.png'));
    size = Vector2(80, 80);
    priority = 100;
  }

  @override
  bool onTapDown(TapDownEvent event) {
    onJump();
    return true;
  }
}