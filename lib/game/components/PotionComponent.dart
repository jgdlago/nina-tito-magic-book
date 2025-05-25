import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';
import 'package:nina_tito_magic_book/game/components/PlayerComponent.dart';

class PotionComponent extends PositionComponent
    with HasGameReference<MagicBook>, CollisionCallbacks {
  late final bool isVisible;
  late SpriteComponent _sprite;

  PotionComponent({
    required Vector2 position,
    required Vector2 size,
    this.isVisible = true,
  }) : super(
    position: position,
    size: size,
    anchor: Anchor.topLeft,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(RectangleHitbox(
      size: size,
      anchor: Anchor.topLeft,
    ));

    if (isVisible) {
      _sprite = SpriteComponent(
        sprite: await Sprite.load('items/potion_1.png'),
        size: size,
        anchor: Anchor.topLeft,
      );
      add(_sprite);
    }
  }

  @override
  bool onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is PlayerComponent) {
      _collectPotion();
      return true;
    }
    return false;
  }

  void _collectPotion() {
    removeFromParent();
  }

  void hide() {
    if (isVisible) {
      _sprite.opacity = 0;
    }
  }

  void show() {
    if (isVisible) {
      _sprite.opacity = 1;
    }
  }
}