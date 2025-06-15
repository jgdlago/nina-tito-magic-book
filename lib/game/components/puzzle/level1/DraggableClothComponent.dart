import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:nina_tito_magic_book/game/components/puzzle/PuzzleOverlay.dart';
import 'package:nina_tito_magic_book/game/components/puzzle/level1/WardrobePuzzleComponent.dart';

class DraggableClothComponent extends SpriteComponent with DragCallbacks {
  Vector2 originalPosition;
  bool isDragging = false;
  final String clothType;

  DraggableClothComponent({
    required Sprite sprite,
    required Vector2 size,
    required Vector2 position,
    required this.clothType, // Receba o tipo no construtor
  }) : originalPosition = position.clone(),
        super(sprite: sprite, size: size, position: position, anchor: Anchor.topLeft);

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    isDragging = true;
    // Traz o componente para frente
    priority = 10;
    // animação de escala
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

    // lógica local da roupa
    _checkIfDroppedOnCharacter();
  }

  void _checkIfDroppedOnCharacter() {
    bool droppedOnValidCharacter = false;

    // Verifique se o parent é um PuzzleOverlay
    if (parent is PuzzleOverlay) {
      final overlay = parent as PuzzleOverlay;
      final puzzle = overlay.puzzle; // Acesse o puzzle do overlay

      for (final character in puzzle.characters) {
        final Rect characterRect = character.toRect();
        final Rect clothRect = toRect();
        final Offset centerPoint = clothRect.center;

        if (characterRect.contains(centerPoint)) {
          if (character.canAcceptCloth(clothType)) {
            print('$clothType solto sobre ${character.characterName} (ACEITO)');

            // Atualiza a posição para ficar sobre o personagem
            position = character.position + Vector2(
                (character.size.x - size.x) / 2,
                character.size.y * 0.7 - size.y // Ajuste vertical
            );

            droppedOnValidCharacter = true;
            break;
          } else {
            print('$clothType solto sobre ${character.characterName} (REJEITADO)');
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
