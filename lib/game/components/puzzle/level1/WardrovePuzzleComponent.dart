import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';

class PuzzleItemComponent extends PositionComponent
    with DragCallbacks, HasGameReference<MagicBook> {

  PuzzleItemComponent({
    required Vector2 position,
    required Vector2 size,
    required this.texture,
  }) : super(position: position, size: size);

  final Sprite texture;
  Vector2? _dragDeltaPosition;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(SpriteComponent(sprite: texture, size: size));
  }


}
