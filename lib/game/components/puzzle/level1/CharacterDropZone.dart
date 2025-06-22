import 'package:flame/components.dart';

class CharacterDropZone extends SpriteComponent {
  final String characterName;
  final List<String> acceptedClothes;
  final Map<String, Vector2> clothingPositions;

  CharacterDropZone({
    required Sprite sprite,
    required Vector2 size,
    required Vector2 position,
    required this.characterName,
    required this.acceptedClothes,
    required this.clothingPositions,
  }) : super(sprite: sprite, size: size, position: position, anchor: Anchor.topLeft);

  bool canAcceptCloth(String clothType) {
    return acceptedClothes.contains(clothType);
  }

  Vector2? getPositionForCloth(String clothType) {
    return clothingPositions[clothType];
  }
}