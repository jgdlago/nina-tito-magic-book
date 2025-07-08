import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame/components.dart';
import 'Scenario.dart';

class School extends Scenario {
  School(TiledComponent scene) : super(scene: scene);

  static Future<School> load() async {
    final scene = await TiledComponent.load(
      'schoolMap.tmx',
      Vector2.all(64),
    );
    return School(scene);
  }
}