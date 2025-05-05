import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';

class GroundComponent extends PositionComponent
    with HasGameReference<MagicBook>, CollisionCallbacks {
  final bool isVisible;

  GroundComponent({
    required Vector2 position,
    required Vector2 size,
    this.isVisible = false,
  }) : super(
    position: position,
    size: size,
    anchor: Anchor.topLeft,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox(size: size, anchor: Anchor.topLeft));

    if (isVisible) {
      add(
        RectangleComponent(
          size: size,
          paint: Paint()
            ..color = const Color(0x99FF0000)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5,
        ),
      );
    }
  }
}
