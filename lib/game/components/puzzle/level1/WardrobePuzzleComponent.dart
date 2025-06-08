import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';
import 'package:nina_tito_magic_book/game/components/DialogComponent.dart';
import 'package:nina_tito_magic_book/game/components/puzzle/PuzzleOverlay.dart';
import 'package:nina_tito_magic_book/game/ui/messages/DialogMessages.dart';

class WardrobePuzzleComponent extends PositionComponent
    with DragCallbacks, HasGameReference<MagicBook> {

  late PuzzleOverlay puzzleOverlay;

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
    puzzleOverlay = PuzzleOverlay();
    game.camera.viewport.add(puzzleOverlay);
    await Future.delayed(Duration.zero);

    final double screenWidth = game.size.x;
    final double screenHeight = game.size.y;
    final double dividerX = screenWidth * 0.5; // Divide a tela no meio
    final double padding = 20.0;
    final double gap = 15.0;

    // Personagens (Esquerda)
    await _addCharacters(
      areaWidth: dividerX - padding,
      areaHeight: screenHeight,
      padding: padding,
      gap: gap,
    );

    // Roupas (Direita)
    await _addClothes(
      startX: dividerX + padding,
      areaWidth: screenWidth - dividerX - padding * 2,
      areaHeight: screenHeight,
      padding: padding,
      gap: gap,
    );

    // Adiciona linha divisória visual
    _addDividerLine(dividerX, screenHeight);
  }

  Future<void> _addCharacters(
      {required double areaWidth,
        required double areaHeight,
        required double padding,
        required double gap}) async {

    final characterPaths = [
      'main_characters/tito/idle/Idle (1).png',
      'main_characters/nina/idle/Idle (1).png',
    ];

    final double scaleFactor = 0.5;
    final double centerY = areaHeight / 2;

    for (var i = 0; i < characterPaths.length; i++) {
      final img = await game.images.load(characterPaths[i]);
      final sprite = Sprite(img);
      final Vector2 size = Vector2(
        img.width.toDouble(),
        img.height.toDouble(),
      ) * scaleFactor;

      final double totalWidth = characterPaths.length * size.x + (characterPaths.length - 1) * gap;
      final double startX = (areaWidth - totalWidth) / 2;

      final comp = SpriteComponent()
        ..sprite = sprite
        ..size = size
        ..position = Vector2(
          startX + i * (size.x + gap), // Posiciona horizontalmente
          centerY - size.y / 2, // Centraliza verticalmente
        )
        ..anchor = Anchor.topLeft;

      puzzleOverlay.add(comp);
    }
  }

  Future<void> _addClothes(
      {required double startX,
        required double areaWidth,
        required double areaHeight,
        required double padding,
        required double gap}) async {

    final clothesPaths = [
      'puzzles/level_1/bikini_top.png',
      'puzzles/level_1/bikini_bottom.png',
      'puzzles/level_1/sweater.png',
      'puzzles/level_1/pants.png',
      'puzzles/level_1/underpants.png',
      'puzzles/level_1/socks.png',
    ];

    final double clothesScale = 0.08;
    final int itemsPerRow = 3; // Organiza as roupas em 3 colunas
    final double itemSpacing = areaWidth / itemsPerRow;

    for (var i = 0; i < clothesPaths.length; i++) {
      final img = await game.images.load(clothesPaths[i]);
      final sprite = Sprite(img);
      final Vector2 size = Vector2(
        img.width.toDouble(),
        img.height.toDouble(),
      ) * clothesScale;

      // Calcula posição em grade
      final int row = i ~/ itemsPerRow;
      final int col = i % itemsPerRow;

      final double x = startX + (col * itemSpacing) + (itemSpacing / 2) - (size.x / 2);
      final double y = padding + (row * (size.y + gap * 2)) + gap;

      final comp = SpriteComponent()
        ..sprite = sprite
        ..size = size
        ..position = Vector2(x, y)
        ..anchor = Anchor.topLeft;

      puzzleOverlay.add(comp);
    }
  }

  void _addDividerLine(double x, double height) {
    // Cria uma linha para dividir as telas
    final dividerLine = RectangleComponent(
      position: Vector2(x - 1, 0),
      size: Vector2(2, height),
      paint: Paint()..color = const Color(0x33FFFFFF),
    );
    puzzleOverlay.add(dividerLine);
  }

  void closePuzzle() {
    puzzleOverlay.closePuzzle();
    game.showGameHUD();
  }
}