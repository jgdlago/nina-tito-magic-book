import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:nina_tito_magic_book/domain/entities/Player.dart';
import 'package:nina_tito_magic_book/game/LevelComponent.dart';
import 'package:nina_tito_magic_book/game/scenarios/Bedroom.dart';
import 'package:nina_tito_magic_book/providers/PlayerProvider.dart';
import '../main.dart';

class MagicBook extends FlameGame {
  late final Player player;

  MagicBook();

  @override
  Future<void> onLoad() async {
    final repo = globalContainer.read(playerRepositoryProvider);

    final data = await repo.getPlayerByCurrentUser();
    if (data == null) {
      throw Exception('Nenhum player encontrado para o usuário atual.');
    }
    player = Player.fromMap(data);

    final bedroom = await Bedroom.load();
    final levelWorld = LevelComponent(scene: bedroom, player: player);

    final camera = CameraComponent.withFixedResolution(
      width: levelWorld.scene.scene.tileMap.map.width * levelWorld.scene.scene.tileMap.map.tileWidth.toDouble(),
      height: levelWorld.scene.scene.tileMap.map.height * levelWorld.scene.scene.tileMap.map.tileHeight.toDouble(),
      world: levelWorld,
    );

    addAll([camera, levelWorld]);
  }
}
