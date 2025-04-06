import 'package:nina_tito_magic_book/data/models/CharacterEnum.dart';
import 'package:nina_tito_magic_book/data/models/PlayerSkinEnum.dart';

class Player {
  final int? id;
  final CharacterEnum character;
  final PlayerSkinEnum equippedSkin;

  Player({
    this.id,
    required this.character,
    required this.equippedSkin,
  });

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      id: map['id'],
      character: CharacterEnum.values.firstWhere((e) => e.toString() == 'CharacterEnum.${map['character']}'),
      equippedSkin: PlayerSkinEnum.values.firstWhere((e) => e.toString() == 'PlayerSkinEnum.${map['equipped_skin']}'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'character': character.toString().split('.').last,
      'equipped_skin': equippedSkin.toString().split('.').last,
    };
  }
}
