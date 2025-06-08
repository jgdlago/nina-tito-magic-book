import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';
import 'package:nina_tito_magic_book/game/components/PlayerComponent.dart';
import 'package:nina_tito_magic_book/game/components/puzzle/level1/WardrobePuzzleComponent.dart';

class WardrobeComponent extends PositionComponent with HasGameReference<MagicBook>, CollisionCallbacks {
  // final Function() onInteract;
  bool _isPlayerNearby = false;

  WardrobeComponent({
    required Vector2 position,
    required Vector2 size,
    // required this.onInteract,
  }) : super(
    position: position,
    size: size,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox(
      size: size,
      anchor: Anchor.topLeft,
    ));
  }

  @override
  bool onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is PlayerComponent) {
      _isPlayerNearby = true;
      _showInteractionHint();
      return true;
    }
    return false;
  }

  void _showInteractionHint() {
    print(_isPlayerNearby);
    game.camera.viewport.add(WardrobePuzzleComponent(position: position, size: size));
  }
}