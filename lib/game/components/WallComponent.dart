import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';
import 'package:nina_tito_magic_book/game/components/PlayerComponent.dart';

class WallComponent extends PositionComponent
    with HasGameReference<MagicBook>, CollisionCallbacks {
  WallComponent({
    required Vector2 position,
    required Vector2 size,
  }) : super(
    position: position,
    size: size,
    anchor: Anchor.topLeft,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox(size: size, anchor: Anchor.topLeft));
  }

  @override
  bool onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is PlayerComponent) {
      return true;
    }
    return false;
  }
}