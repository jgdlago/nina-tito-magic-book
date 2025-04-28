import 'package:flame/experimental.dart';
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

  MagicBook({required this.playerRepository}) {
    debugMode = true;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    playerData = await _loadPlayerData();

    final bedroomScenario = await Bedroom.load();
    final tiledComponent  = bedroomScenario.scene;
    final renderableMap   = tiledComponent.tileMap;
    final tiledMap        = renderableMap.map;

    final ObjectGroup spawnGroup = renderableMap
        .getLayer<ObjectGroup>('SpawnPoints')
        ?? (throw Exception('Layer "SpawnPoints" não encontrado'));

    final TiledObject spawnObj = spawnGroup.objects.firstWhere(
          (o) => o.name == 'player',
      orElse: () => spawnGroup.objects.first,
    );

    final Vector2 spawnPos = Vector2(spawnObj.x, spawnObj.y);

    final playerComponent = PlayerComponent(
      character: playerData.character.toString(),
      position: spawnPos,
      size: Vector2(48, 48),
      anchor: Anchor.topLeft,
    );

    final levelComponent = LevelComponent(
      scene: bedroomScenario,
      player: playerComponent,
    );
    add(levelComponent);

    final worldWidth  = tiledMap.width  * tiledMap.tileWidth.toDouble();
    final worldHeight = tiledMap.height * tiledMap.tileHeight.toDouble();

    camera = CameraComponent(world: levelComponent)
      ..follow(playerComponent, snap: false, maxSpeed: 400)
      ..setBounds(Rectangle.fromLTWH(0, 0, worldWidth, worldHeight));

    add(camera);
    await Future.delayed(Duration.zero);

    camera.viewfinder.zoom = size.y / worldHeight;
  }

  Future<Player> _loadPlayerData() async {
    final data = await playerRepository.getPlayerByCurrentUser();
    if (data == null) {
      throw Exception('Nenhum player encontrado para o usuário atual.');
    }
    return Player.fromMap(data);
  }
}