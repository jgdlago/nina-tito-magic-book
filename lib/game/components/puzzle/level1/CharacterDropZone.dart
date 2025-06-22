import 'package:flame/components.dart';

class CharacterDropZone extends SpriteComponent {
  final String characterName;
  final List<String> acceptedClothes;
  final Map<String, Vector2> clothingPositions;
  final Map<String, double> clothingScales;

  CharacterDropZone({
    required Sprite sprite,
    required Vector2 size,
    required Vector2 position,
    required this.characterName,
    required this.acceptedClothes,
    required this.clothingPositions,
    this.clothingScales = const {},
  }) : super(sprite: sprite, size: size, position: position, anchor: Anchor.topLeft);

  bool canAcceptCloth(String clothType) {
    return acceptedClothes.contains(clothType);
  }

  Vector2? getPositionForCloth(String clothType) {
    return clothingPositions[clothType];
  }

  double? getScaleForCloth(String clothType) {
    return clothingScales[clothType];
  }
}