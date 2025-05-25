import 'package:flame/camera.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:nina_tito_magic_book/domain/entities/Player.dart';
import 'package:nina_tito_magic_book/domain/repositories/ItemRepositoryInterface.dart';
import 'package:nina_tito_magic_book/domain/repositories/LevelRepositoryInterface.dart';
import 'package:nina_tito_magic_book/domain/repositories/PlayerRepositoryInterface.dart';
import 'package:nina_tito_magic_book/domain/repositories/UserRepositoryInterface.dart';
import 'package:nina_tito_magic_book/game/components/DialogComponent.dart';
import 'package:nina_tito_magic_book/game/components/LevelComponent.dart';
import 'package:nina_tito_magic_book/game/components/PlayerComponent.dart';
import 'package:nina_tito_magic_book/game/components/JumpButtonComponent.dart';
import 'package:nina_tito_magic_book/game/scenarios/Bedroom.dart';
import 'package:flutter/widgets.dart';
import 'package:nina_tito_magic_book/game/ui/messages/DialogMessages.dart';

class MagicBook extends FlameGame with DragCallbacks, HasCollisionDetection {
  late final Player playerData;
  final PlayerRepositoryInterface playerRepository;
  final UserRepositoryInterface userRepository;
  final LevelRepositoryInterface levelRepository;
  final ItemRepositoryInterface itemRepository;
  late final LevelComponent levelComponent;
  late final JoystickComponent joystick;
  late final JumpButtonComponent jumpButton;
  late final PlayerComponent playerComponent;
  bool showingIntroduction = false;

  MagicBook({
    required this.playerRepository,
    required this.userRepository,
    required this.levelRepository,
    required this.itemRepository,
  }) {
    debugMode = true;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await images.loadAll([
      'general/magic_book.png',
      'hud/Knob.png',
      'hud/Joystick.png',
      'hud/jump.png',
      'ui/dialog_torn_paper.png',
      'ui/default_button.png',
      'items/items_example.png'
    ]);

    joystick = _createJoystick();

    playerData = await _loadPlayerData();

    final bedroomScenario = await Bedroom.load();
    final tiledComponent = bedroomScenario.scene;
    final renderableMap = tiledComponent.tileMap;
    final tiledMap = renderableMap.map;

    final ObjectGroup spawnGroup = renderableMap
        .getLayer<ObjectGroup>('SpawnPoints')
        ?? (throw Exception('Layer "SpawnPoints" não encontrado'));

    final TiledObject spawnObj = spawnGroup.objects
        .firstWhere((o) => o.name == 'player', orElse: () => spawnGroup.objects.first);

    final spawnPos = Vector2(
      spawnObj.x + spawnObj.width / 2,
      spawnObj.y + spawnObj.height,
    );

    playerComponent = PlayerComponent(
      character: playerData.character.toString(),
      position: spawnPos,
      joystick: joystick,
    );

    jumpButton = _createJumpButton();

    levelComponent = LevelComponent(
      scene: bedroomScenario,
      player: playerComponent,
      levelRepository: levelRepository,
    );
    add(levelComponent);

    final worldWidth = tiledMap.width * tiledMap.tileWidth.toDouble();
    final worldHeight = tiledMap.height * tiledMap.tileHeight.toDouble();

    camera = CameraComponent(
      world: levelComponent,
      viewport: FixedSizeViewport(size.x, size.y),
    )
      ..follow(playerComponent, snap: false, maxSpeed: 400)
      ..setBounds(
        Rectangle.fromLTWH(
            0,
            0,
            worldWidth,
            worldHeight
        ),
        considerViewport: true,
      );

    add(camera);

    final userProgress = await userRepository.getUserProgress();
    if (userProgress == null) {
      showingIntroduction = true;
      removeGameHUD();
      await _loadIntroduction();
    } else {
      showGameHUD();
    }

    await Future.delayed(Duration.zero);
  }

  void showGameHUD() {
    camera.viewport.add(joystick);
    camera.viewport.add(jumpButton);
    levelComponent.addLevelMessage();
    playerComponent.enableMovement();
  }

  void removeGameHUD() {
    joystick.removeFromParent();
    jumpButton.removeFromParent();
    levelComponent.removeLevelMessage();
    playerComponent.disableMovement();
  }

  Future<Player> _loadPlayerData() async {
    final data = await playerRepository.getPlayerByCurrentUser();
    if (data == null) {
      throw Exception('Nenhum player encontrado para o usuário atual.');
    }
    return Player.fromMap(data);
  }

  JoystickComponent _createJoystick() {
    return JoystickComponent(
        knob: SpriteComponent(
          sprite: Sprite(images.fromCache('hud/Knob.png')
          ),
        ),
        background: SpriteComponent(
          sprite: Sprite(images.fromCache('hud/Joystick.png')
          ),
        ),
        margin: const EdgeInsets.only(left: 100, bottom: 50)
    )..priority = 100;
  }

  JumpButtonComponent _createJumpButton() {
    return JumpButtonComponent(
      onJump: () => playerComponent.requestJump(),
      position: Vector2(
        size.x - 100,
        size.y - 100,
      ),
    );
  }

  Future<void> _loadIntroduction() async {
    await camera.viewport.add(
        DialogComponent(
          text: DialogMessages.introductionLevel1,
          onContinue: () {
            _showSecondDialog();
          },
        )
    );
  }

  void _showSecondDialog() async {
    await camera.viewport.add(
        DialogComponent(
            text: DialogMessages.introductionLevel1layer2,
            dialogImage: images.fromCache('general/magic_book.png'),
            onContinue: () {
              _showThirdDialog();
            }
        )
    );
  }

  void _showThirdDialog() async {
    await camera.viewport.add(
        DialogComponent(
            text: DialogMessages.introductionLevel1layer3,
            dialogImage: images.fromCache('items/items_example.png'),
            onContinue: () {
              showGameHUD();
              showingIntroduction = false;
            }
        )
    );
  }
}