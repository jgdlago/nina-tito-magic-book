import 'package:flame/camera.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:nina_tito_magic_book/domain/entities/Level.dart';
import 'package:nina_tito_magic_book/domain/entities/Player.dart';
import 'package:nina_tito_magic_book/domain/repositories/ItemRepositoryInterface.dart';
import 'package:nina_tito_magic_book/domain/repositories/LevelRepositoryInterface.dart';
import 'package:nina_tito_magic_book/domain/repositories/PlayerRepositoryInterface.dart';
import 'package:nina_tito_magic_book/domain/repositories/UserRepositoryInterface.dart';
import 'package:nina_tito_magic_book/game/components/AudioManager.dart';
import 'package:nina_tito_magic_book/game/components/DialogComponent.dart';
import 'package:nina_tito_magic_book/game/components/LevelComponent.dart';
import 'package:nina_tito_magic_book/game/components/PauseButtonComponent.dart';
import 'package:nina_tito_magic_book/game/components/PlayerComponent.dart';
import 'package:nina_tito_magic_book/game/components/JumpButtonComponent.dart';
import 'package:nina_tito_magic_book/game/scenarios/Bedroom.dart';
import 'package:nina_tito_magic_book/game/scenarios/Scenario.dart';
import 'package:flutter/widgets.dart';
import 'package:nina_tito_magic_book/game/scenarios/School.dart';
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
  Level? currentLevel;

  MagicBook({
    required this.playerRepository,
    required this.userRepository,
    required this.levelRepository,
    required this.itemRepository,
  }) {
    // debugMode = true;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    AudioManager.playBGM('audio/soundtrack/ambient_music.mp3');

    await images.loadAll([
      'general/magic_book.png',
      'hud/Knob.png',
      'hud/Joystick.png',
      'hud/jump.png',
      'hud/pause.png',
      'hud/play.png',
      'ui/dialog_torn_paper.png',
      'ui/default_button.png',
      'items/items_example.png',
    ]);

    await FlameAudio.audioCache.loadAll([
      'narration/introduction_01.mp3',
      'narration/introduction_02.mp3',
      'narration/introduction_03.mp3',
    ]);

    joystick = _createJoystick();

    playerData = await _loadPlayerData();

    final scenario = await _loadScenarioFromLastUnfinishedLevel();
    final tiledComponent = scenario.scene;
    final renderableMap = tiledComponent.tileMap;
    final tiledMap = renderableMap.map;

    final ObjectGroup spawnGroup =
        renderableMap.getLayer<ObjectGroup>('SpawnPoints') ??
            (throw Exception('Layer "SpawnPoints" não encontrado'));

    final TiledObject spawnObj = spawnGroup.objects.firstWhere(
        (o) => o.name == 'player',
        orElse: () => spawnGroup.objects.first);

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
        scene: scenario,
        player: playerComponent,
        levelRepository: levelRepository,
        level: currentLevel);
    add(levelComponent);

    final worldWidth = tiledMap.width * tiledMap.tileWidth.toDouble();
    final worldHeight = tiledMap.height * tiledMap.tileHeight.toDouble();

    camera = CameraComponent(
      world: levelComponent,
      viewport: FixedSizeViewport(size.x, size.y),
    )
      ..follow(playerComponent, snap: false, maxSpeed: 400)
      ..setBounds(
        Rectangle.fromLTWH(0, 0, worldWidth, worldHeight),
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
    addPauseButton();
    levelComponent.addLevelMessage();
    playerComponent.enableMovement();
  }

  void removeGameHUD() {
    joystick.removeFromParent();
    jumpButton.removeFromParent();
    levelComponent.removeLevelMessage();
    playerComponent.disableMovement();
    removePauseButton();
  }

  void addPauseButton() {
    final buttonSize = Vector2(50, 50);
    final pauseButton = PauseButtonComponent(
      position: Vector2(20 + buttonSize.x / 2, 20 + buttonSize.y / 2),
      size: buttonSize,
    );
    camera.viewport.add(pauseButton);
  }

  void removePauseButton() {
    camera.viewport.children.whereType<PauseButtonComponent>().forEach((btn) {
      btn.removeFromParent();
    });
  }

  Future<Player> _loadPlayerData() async {
    final player = await playerRepository.getPlayerByCurrentUser();
    if (player == null) {
      throw Exception('Nenhum player encontrado para o usuário atual.');
    }
    return player;
  }

  Future<Scenario> _loadScenarioFromLastUnfinishedLevel() async {
    currentLevel = await levelRepository.getLastUnfinishedLevel();

    if (currentLevel == null) {
      return await Bedroom.load();
    }

    switch (currentLevel!.scenario.toLowerCase()) {
      case 'bedroom':
        return await Bedroom.load();
      case 'school':
        return await School.load();
      default:
        return await Bedroom.load();
    }
  }

  JoystickComponent _createJoystick() {
    return JoystickComponent(
        knob: SpriteComponent(
          sprite: Sprite(images.fromCache('hud/Knob.png')),
        ),
        background: SpriteComponent(
          sprite: Sprite(images.fromCache('hud/Joystick.png')),
        ),
        margin: const EdgeInsets.only(left: 100, bottom: 50))
      ..priority = 100;
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
    if (currentLevel != null) {
      switch (currentLevel!.scenario.toLowerCase()) {
        case 'bedroom':
          await _loadBedroomIntroduction();
          break;
        case 'school':
          await _loadSchoolIntroduction();
          break;
        default:
          await _loadBedroomIntroduction();
          break;
      }
    } else {
      await _loadBedroomIntroduction();
    }
  }

  Future<void> _loadBedroomIntroduction() async {
    await camera.viewport.add(DialogComponent(
      text: DialogMessages.introductionLevel1,
      audioPath: 'audio/narration/introduction_01.mp3',
      onContinue: () {
        _showBedroomSecondDialog();
      },
    ));
  }

  void _showBedroomSecondDialog() async {
    await camera.viewport.add(DialogComponent(
        text: DialogMessages.introductionLevel1layer2,
        dialogImage: images.fromCache('general/magic_book.png'),
        audioPath: 'audio/narration/introduction_02.mp3',
        onContinue: () {
          _showBedroomThirdDialog();
        }));
  }

  void _showBedroomThirdDialog() async {
    await camera.viewport.add(DialogComponent(
        text: DialogMessages.introductionLevel1layer3,
        dialogImage: images.fromCache('items/items_example.png'),
        audioPath: 'audio/narration/introduction_03.mp3',
        onContinue: () {
          showGameHUD();
          showingIntroduction = false;
        }));
  }

  Future<void> _loadSchoolIntroduction() async {
    await camera.viewport.add(DialogComponent(
      text: DialogMessages.introductionLevel2,
      audioPath: 'audio/narration/introduction_04.mp3',
      onContinue: () {
        showGameHUD();
        showingIntroduction = false;
      },
    ));
  }

  void togglePause() {
    if (paused) {
      resumeEngine();
      overlays.remove('pauseMenu');
    } else {
      pauseEngine();
      overlays.add('pauseMenu');
      AudioManager.pauseBGM();
      AudioManager.stopAllNarrations();
    }
  }

  @override
  void onRemove() {
    AudioManager.stopAllNarrations();
    super.onRemove();
  }

  Future<void> loadLevel(Level newLevel) async {
    String? previousScenario = currentLevel?.scenario;

    currentLevel = newLevel;

    Scenario newScenario;
    if (newLevel.scenario != previousScenario) {
      newScenario = await _loadScenarioForLevel(newLevel);
    } else {
      newScenario = levelComponent.scene;
    }

    final spawnPos = await _getSpawnPosition(newScenario);

    playerComponent.position = spawnPos;

    levelComponent.updateScene(newScenario, newLevel);

    _recreateCamera(newScenario);

    if (newLevel.scenario != previousScenario) {
      showingIntroduction = true;
      removeGameHUD();
      await _loadIntroduction();
    } else {
      showGameHUD();
    }
  }

  Future<Vector2> _getSpawnPosition(Scenario scenario) async {
    final tiledComponent = scenario.scene;
    final renderableMap = tiledComponent.tileMap;

    final ObjectGroup spawnGroup = renderableMap.getLayer<ObjectGroup>('SpawnPoints') ??
        (throw Exception('Layer "SpawnPoints" não encontrado'));

    final TiledObject spawnObj = spawnGroup.objects.firstWhere(
          (o) => o.name == 'player',
      orElse: () => spawnGroup.objects.first,
    );

    return Vector2(
      spawnObj.x + spawnObj.width / 2,
      spawnObj.y + spawnObj.height,
    );
  }

  void _recreateCamera(Scenario scenario) {
    final tiledComponent = scenario.scene;
    final tiledMap = tiledComponent.tileMap.map;

    final worldWidth = tiledMap.width * tiledMap.tileWidth.toDouble();
    final worldHeight = tiledMap.height * tiledMap.tileHeight.toDouble();

    remove(camera);

    camera = CameraComponent(
      world: levelComponent,
      viewport: FixedSizeViewport(size.x, size.y),
    )
      ..follow(playerComponent, snap: false, maxSpeed: 400)
      ..setBounds(
        Rectangle.fromLTWH(0, 0, worldWidth, worldHeight),
        considerViewport: true,
      );

    add(camera);
  }

  Future<Scenario> _loadScenarioForLevel(Level level) async {
    switch (level.scenario.toLowerCase()) {
      case 'bedroom':
        return await Bedroom.load();
      case 'school':
        return await School.load();
      default:
        return await Bedroom.load();
    }
  }
}
