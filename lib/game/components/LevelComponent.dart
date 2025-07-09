import 'dart:async';
import 'package:flame/components.dart';
import 'package:nina_tito_magic_book/domain/entities/Level.dart';
import 'package:nina_tito_magic_book/domain/repositories/LevelRepositoryInterface.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';
import 'package:nina_tito_magic_book/game/components/PlayerComponent.dart';
import 'package:nina_tito_magic_book/game/scenarios/Scenario.dart';
import 'package:nina_tito_magic_book/game/ui/themes/GameTextStyles.dart';

class LevelComponent extends World with HasGameReference<MagicBook> {
  late final Scenario scene;
  final PlayerComponent player;
  final LevelRepositoryInterface levelRepository;
  Level? _currentLevel;

  TextComponent? _nameLabel;
  TextBoxComponent? _messageLabel;

  LevelComponent({
    required this.scene,
    required this.player,
    required this.levelRepository,
    Level? level,
  }) : _currentLevel = level;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    await add(scene);
    await add(player);

    if (!game.showingIntroduction && _currentLevel != null) {
      addLevelMessage();
    }
  }

  void addLevelMessage() {
    if (_currentLevel == null || _nameLabel != null) return;

    const double padding = 5;
    final double maxMessageWidth = game.size.x * 0.3;

    final nameLabel = TextBoxComponent(
      text: _currentLevel!.name,
      boxConfig: TextBoxConfig(maxWidth: maxMessageWidth),
      textRenderer: TextPaint(style: GameTextStyles.levelMessageTitle),
      position: Vector2(
        game.size.x - padding,
        padding,
      ),
      anchor: Anchor.topRight,
    )
      ..priority = 1000;

    final messageLabel = TextBoxComponent(
      text: _currentLevel!.message,
      boxConfig: TextBoxConfig(maxWidth: maxMessageWidth),
      textRenderer: TextPaint(style: GameTextStyles.levelMessageBody),
      position: Vector2(
        game.size.x - padding,
        nameLabel.size.y,
      ),
      anchor: Anchor.topRight,
    )
      ..priority = 1000;

    _nameLabel = nameLabel;
    _messageLabel = messageLabel;

    game.camera.viewport.add(nameLabel);
    game.camera.viewport.add(messageLabel);
  }

  void removeLevelMessage() {
    _nameLabel?.removeFromParent();
    _messageLabel?.removeFromParent();
    _nameLabel = null;
    _messageLabel = null;
  }

  void updateLevel(Level newLevel) {
    if (_currentLevel?.id == newLevel.id) return;

    _currentLevel = newLevel;
    removeLevelMessage();
    addLevelMessage();
  }
}