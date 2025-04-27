import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:nina_tito_magic_book/domain/entities/Player.dart';
import 'package:nina_tito_magic_book/domain/repositories/PlayerRepositoryInterface.dart';
import 'package:nina_tito_magic_book/game/LevelComponent.dart';
import 'package:nina_tito_magic_book/game/PlayerComponent.dart';
import 'package:nina_tito_magic_book/game/scenarios/Bedroom.dart';

class MagicBook extends FlameGame {
  late final Player playerData;
  final PlayerRepositoryInterface playerRepository;

  MagicBook({required this.playerRepository});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    playerData = await _loadPlayerData();

    final bedroomScenario = await Bedroom.load();
    final tiledComponent = bedroomScenario.scene;
    final renderableMap = tiledComponent.tileMap;

    final ObjectGroup spawnGroup = _findLayer(renderableMap);
    final TiledObject spawnObj = spawnGroup.objects.firstWhere(
          (o) => o.name == 'player',
      orElse: () => spawnGroup.objects.first,
    );
    final Vector2 spawnPos = Vector2(spawnObj.x, spawnObj.y);

    final playerComponent = PlayerComponent(
      character: playerData.character.toString(),
      position: spawnPos,
      size: Vector2(48, 48),
    );

    final levelComponent = LevelComponent(
      scene: bedroomScenario,
      player: playerComponent,
    );

    final tiledMap = renderableMap.map;
    final camera = CameraComponent.withFixedResolution(
      width: tiledMap.width * tiledMap.tileWidth.toDouble(),
      height: tiledMap.height * tiledMap.tileHeight.toDouble(),
      world: levelComponent,
    );

    addAll([camera, levelComponent]);
  }

  Future<Player> _loadPlayerData() async {
    final data = await playerRepository.getPlayerByCurrentUser();
    if (data == null) {
      throw Exception('Nenhum player encontrado para o usuário atual.');
    }
    return Player.fromMap(data);
  }

  ObjectGroup _findLayer(RenderableTiledMap map) {
    final group = map.getLayer<ObjectGroup>('SpawnPoints');
    if (group == null) {
      throw Exception('Layer "spawnPoints" não encontrado no TMX.');
    }
    return group;
  }
}
