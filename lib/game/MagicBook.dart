import 'package:flame/game.dart';
import 'package:flame/components.dart';
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

    final data = await playerRepository.getPlayerByCurrentUser();
    if (data == null) {
      throw Exception('Nenhum player encontrado para o usuário atual.');
    }

    playerData = Player.fromMap(data);

    final playerComponent = PlayerComponent(
      character: playerData.character.toString(),
      position: Vector2(100, 100),
      size: Vector2(48, 48),
    );

    final bedroom = await Bedroom.load();
    final levelComponent = LevelComponent(
      scene: bedroom,
      player: playerComponent,
    );

    // Configura câmera
    final tileMap = levelComponent.scene.scene.tileMap.map;
    final camera = CameraComponent.withFixedResolution(
      width: tileMap.width * tileMap.tileWidth.toDouble(),
      height: tileMap.height * tileMap.tileHeight.toDouble(),
      world: levelComponent,
    );

    // Adiciona tudo ao jogo
    addAll([levelComponent, playerComponent, camera]);
  }
}
