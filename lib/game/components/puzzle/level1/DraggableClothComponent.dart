import 'package:flame/components.dart';
import 'package:flame/events.dart';

class DraggableClothComponent extends SpriteComponent with DragCallbacks {
  Vector2 originalPosition;
  bool isDragging = false;

  DraggableClothComponent({
    required Sprite sprite,
    required Vector2 size,
    required Vector2 position,
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
    // Implementar lógica para verificar se foi solta sobre um personagem
    print('Roupa solta na posição: ${position.x}, ${position.y}');
  }

  void resetPosition() {
    position = originalPosition.clone();
  }
}
