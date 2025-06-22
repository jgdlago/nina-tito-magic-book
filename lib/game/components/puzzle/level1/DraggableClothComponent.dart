import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:nina_tito_magic_book/game/components/puzzle/PuzzleOverlay.dart';

class DraggableClothComponent extends SpriteComponent with DragCallbacks {
  Vector2 originalPosition;
  bool isDragging = false;
  final String clothType;

  DraggableClothComponent({
    required Sprite sprite,
    required Vector2 size,
    required Vector2 position,
    required this.clothType,
  }) : originalPosition = position.clone(),
        super(sprite: sprite, size: size, position: position, anchor: Anchor.topLeft);

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    isDragging = true;
    priority = 10;
    scale = Vector2.all(1.1);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    if (isDragging) {
      // Atualiza a posição baseada no movimento do drag
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
            final targetPosition = character.getPositionForCloth(clothType);

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
            droppedOnValidCharacter = true;
          }
        }
      }
    }

    if (!droppedOnValidCharacter) {
      resetPosition();
    }
  }

  void resetPosition() {
    position = originalPosition.clone();
  }
}
