import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';
import 'package:nina_tito_magic_book/game/components/DialogComponent.dart';
import 'package:nina_tito_magic_book/game/components/PlayerComponent.dart';
import 'package:nina_tito_magic_book/game/ui/messages/DialogMessages.dart';
import 'package:nina_tito_magic_book/domain/entities/Item.dart';

class ItemComponent extends PositionComponent
    with HasGameReference<MagicBook>, CollisionCallbacks {
  late final bool isVisible;
  late SpriteComponent _sprite;
  late final String image;
  final String itemName;
  final String itemDescription;

  ItemComponent({
    required Vector2 position,
    required Vector2 size,
    this.isVisible = true,
    required this.image,
    required this.itemName,
    required this.itemDescription,
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
        sprite: await Sprite.load(image),
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
      _collectItem();
      return true;
    }
    return false;
  }

  void _collectItem() async {
    await _saveItemToDatabase();

    removeFromParent();
    game.removeGameHUD();
    game.camera.viewport.add(
        DialogComponent(
            text: DialogMessages.potionCollected1,
            audioPath: 'audio/narration/item_01.mp3',
            dialogImage: await game.images.load('items/potion_1.png'),
            onContinue: () {
              game.showGameHUD();
            }
        )
    );
  }

  Future<void> _saveItemToDatabase() async {
    final item = Item(
      name: itemName,
      description: itemDescription,
      collected_at: DateTime.now().toIso8601String(),
    );

    await game.itemRepository.createItem(item);
    print('Item $itemName salvo no banco de dados');
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