import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame/components.dart';
import 'Scenario.dart';

class Bedroom extends Scenario {
  Bedroom(TiledComponent scene) : super(scene: scene);

  static Future<Bedroom> load() async {
    final scene = await TiledComponent.load(
      'game/tiles/bedroom/bedroom_map.tmx',
      Vector2.all(16),
    );
    return Bedroom(scene);
  }
}