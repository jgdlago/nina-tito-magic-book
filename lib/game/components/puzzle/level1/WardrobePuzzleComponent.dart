import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';
import 'package:nina_tito_magic_book/game/components/DialogComponent.dart';
import 'package:nina_tito_magic_book/game/components/puzzle/PuzzleOverlay.dart';
import 'package:nina_tito_magic_book/game/components/puzzle/level1/CharacterDropZone.dart';
import 'package:nina_tito_magic_book/game/components/puzzle/level1/DraggableClothComponent.dart';
import 'package:nina_tito_magic_book/game/ui/messages/DialogMessages.dart';

class WardrobePuzzleComponent extends PositionComponent
    with DragCallbacks, HasGameReference<MagicBook> {

  late PuzzleOverlay puzzleOverlay;
  final List<DraggableClothComponent> clothes = [];
  final List<CharacterDropZone> characters = [];

  WardrobePuzzleComponent({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    game.removeGameHUD();
    _addDialogs();
    await super.onLoad();
  }

  void _addDialogs() async {
    game.camera.viewport.add(
        DialogComponent(
            text: DialogMessages.level1WardrobePuzzleLayer1,
            onContinue: () {
              _initPuzzle();
            }
        )
    );
  }

  void _initPuzzle() async {
    puzzleOverlay = PuzzleOverlay(puzzle: this);
    game.camera.viewport.add(puzzleOverlay);
    await Future.delayed(Duration.zero);

    final double screenWidth = game.size.x;
    final double screenHeight = game.size.y;
    final double dividerX = screenWidth * 0.5;
    final double padding = 20.0;
    final double gap = 15.0;

    // Personagens (Esquerda) - agora são zonas de drop
    await _addCharacters(
      areaWidth: dividerX - padding,
      areaHeight: screenHeight,
      padding: padding,
      gap: gap,
    );

    // Roupas arrastáveis (Direita)
    await _addClothes(
      startX: dividerX + padding,
      areaWidth: screenWidth - dividerX - padding * 2,
      areaHeight: screenHeight,
      padding: padding,
      gap: gap,
    );

    _addDividerLine(dividerX, screenHeight);
  }

  Future<void> _addCharacters(
      {required double areaWidth,
        required double areaHeight,
        required double padding,
        required double gap}) async {

    final characterData = [
      {
        'path': 'main_characters/tito/idle/01.png',
        'name': 'tito',
        'clothes': ['underpants'] // Deve aceitar apenas 'underpants'
      },
      {
        'path': 'main_characters/nina/idle/Idle (1).png',
        'name': 'nina',
        'clothes': ['bikini_top', 'bikini_bottom'] // Aceita partes do biquíni
      },
    ];

    final double scaleFactor = 0.5;
    final double centerY = areaHeight / 2;

    for (var i = 0; i < characterData.length; i++) {
      final data = characterData[i];
      final img = await game.images.load(data['path'] as String);
      final sprite = Sprite(img);
      final Vector2 size = Vector2(
        img.width.toDouble(),
        img.height.toDouble(),
      ) * scaleFactor;

      final double totalWidth = characterData.length * size.x + (characterData.length - 1) * gap;
      final double startX = (areaWidth - totalWidth) / 2;

      final dropZone = CharacterDropZone(
        sprite: sprite,
        size: size,
        position: Vector2(
          startX + i * (size.x + gap),
          centerY - size.y / 2,
        ),
        characterName: data['name'] as String,
        acceptedClothes: List<String>.from(data['clothes'] as List),
      );

      characters.add(dropZone);
      puzzleOverlay.add(dropZone);
    }
  }

  Future<void> _addClothes(
      {required double startX,
        required double areaWidth,
        required double areaHeight,
        required double padding,
        required double gap}) async {

    final clothesData = [
      {'path': 'puzzles/level_1/bikini_top.png', 'type': 'bikini_top'},
      {'path': 'puzzles/level_1/bikini_bottom.png', 'type': 'bikini_bottom'},
      {'path': 'puzzles/level_1/sweater.png', 'type': 'sweater'},
      {'path': 'puzzles/level_1/pants.png', 'type': 'pants'},
      {'path': 'puzzles/level_1/underpants.png', 'type': 'underpants'},
      {'path': 'puzzles/level_1/socks.png', 'type': 'socks'},
    ];

    final double clothesScale = 0.08;
    final int itemsPerRow = 3;
    final double itemSpacing = areaWidth / itemsPerRow;

    for (var i = 0; i < clothesData.length; i++) {
      final data = clothesData[i];
      final img = await game.images.load(data['path'] as String);
      final sprite = Sprite(img);
      final Vector2 size = Vector2(
        img.width.toDouble(),
        img.height.toDouble(),
      ) * clothesScale;

      final int row = i ~/ itemsPerRow;
      final int col = i % itemsPerRow;

      final double x = startX + (col * itemSpacing) + (itemSpacing / 2) - (size.x / 2);
      final double y = padding + (row * (size.y + gap * 2)) + gap;

      final clothComponent = DraggableClothComponent(
        sprite: sprite,
        size: size,
        position: Vector2(x, y),
        clothType: data['type'] as String,
      );

      clothes.add(clothComponent);
      puzzleOverlay.add(clothComponent);
    }
  }

  void _addDividerLine(double x, double height) {
    final dividerLine = RectangleComponent(
      position: Vector2(x - 1, 0),
      size: Vector2(2, height),
      paint: Paint()..color = const Color(0x33FFFFFF),
    );
    puzzleOverlay.add(dividerLine);
  }

  // Método para resetar todas as roupas
  void resetAllClothes() {
    for (final cloth in clothes) {
      cloth.resetPosition();
    }
  }

  void closePuzzle() {
    puzzleOverlay.closePuzzle();
    game.showGameHUD();
  }
}