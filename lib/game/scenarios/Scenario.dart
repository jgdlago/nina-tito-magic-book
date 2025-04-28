import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

abstract class Scenario extends Component {
  final TiledComponent scene;
  Scenario({ required this.scene });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(scene);
  }
}
