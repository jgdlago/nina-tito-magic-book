import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:nina_tito_magic_book/game/components/puzzle/PuzzleOverlay.dart';
import 'package:nina_tito_magic_book/game/components/puzzle/level1/CharacterDropZone.dart';

class DraggableClothComponent extends SpriteComponent with DragCallbacks {
  Vector2 originalPosition;
  Vector2 originalSize;
  bool isDragging = false;
  bool isPlaced = false;
  final String clothType;
  CharacterDropZone? placedCharacter;
  VoidCallback? onStateChanged;

  DraggableClothComponent({
    required Sprite sprite,
    required Vector2 size,
    required Vector2 position,
    required this.clothType,
  }) : originalPosition = position.clone(),
        originalSize = size.clone(),
        super(sprite: sprite, size: size, position: position, anchor: Anchor.topLeft);

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    isDragging = true;
    priority = 10;
    scale = Vector2.all(1.1);

    if (isPlaced) {
      size = originalSize.clone();
      isPlaced = false;
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    if (isDragging) {
      position += event.localDelta;
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    isDragging = false;
    priority = 0;
    scale = Vector2.all(1.0);
    _checkIfDroppedOnCharacter();
  }

  void _checkIfDroppedOnCharacter() {
    bool droppedOnValidCharacter = false;

    if (parent is PuzzleOverlay) {
      final overlay = parent as PuzzleOverlay;
      final puzzle = overlay.puzzle;

      for (final character in puzzle.characters) {
        final Rect characterRect = character.toRect();
        final Rect clothRect = toRect();
        final Offset centerPoint = clothRect.center;

        if (characterRect.contains(centerPoint)) {
          if (character.canAcceptCloth(clothType)) {
            _placeOnCharacter(character);
            droppedOnValidCharacter = true;
            break;
          }
        }
      }
    }

    if (!droppedOnValidCharacter) {
      resetPosition();
    }
  }

  void _placeOnCharacter(CharacterDropZone character) {
    final targetPosition = character.getPositionForCloth(clothType);
    final clothingScale = character.getScaleForCloth(clothType);

    isPlaced = true;

    if (clothingScale != null) {
      size = originalSize * clothingScale;
    } else {
      final defaultScale = _getDefaultScale(character);
      size = originalSize * defaultScale;
    }

    if (targetPosition != null) {
      position = character.position + Vector2(
          character.size.x * targetPosition.x - size.x / 2,
          character.size.y * targetPosition.y - size.y / 2
      );
    } else {
      position = character.position + Vector2(
          (character.size.x - size.x) / 2,
          character.size.y * 0.7 - size.y
      );
    }

    placedCharacter = character;
    character.addCloth(clothType);
    onStateChanged?.call();
  }

  double _getDefaultScale(CharacterDropZone character) {
    switch (clothType) {
      case 'bikini_top':
        return 0.6;
      case 'bikini_bottom':
        return 0.8;
      case 'underpants':
        return 0.9;
      case 'sweater':
        return 1.2;
      case 'pants':
        return 1.1;
      case 'socks':
        return 0.4;
      default:
        return 1.0;
    }
  }

  void resetPosition() {
    if (placedCharacter != null) {
      placedCharacter!.removeCloth(clothType);
      placedCharacter = null;
    }

    position = originalPosition.clone();
    size = originalSize.clone();
    isPlaced = false;
    onStateChanged?.call();
  }
}