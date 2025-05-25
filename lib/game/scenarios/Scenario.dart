import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:nina_tito_magic_book/game/components/GroundComponent.dart';
import 'package:nina_tito_magic_book/game/components/PotionComponent.dart';

abstract class Scenario extends Component {
  final TiledComponent scene;

  Scenario({required this.scene});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(scene);

    _addCollisions();
  }

  void _addCollisions() {
    final collisionsLayer = scene.tileMap.getLayer<ObjectGroup>('Collisions');

    if (collisionsLayer != null) {
      for (var collision in collisionsLayer.objects) {
        switch (collision.class_) {
          case 'ground':
            final ground = GroundComponent(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
            );
            add(ground);
            break;

          case 'potion':
            final potion = PotionComponent(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
              isVisible: true,
            );
            add(potion);
            break;

          default:
            print('Objeto desconhecido: ${collision.class_}');
            break;
        }
      }
    }
  }
}