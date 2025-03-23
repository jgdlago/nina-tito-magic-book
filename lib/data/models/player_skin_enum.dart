enum PlayerSkinEnum {
  standard,
  underwear,
}

extension PlayerSkinEnumExtension on PlayerSkinEnum {
  String get label {
    switch (this) {
      case PlayerSkinEnum.standard:
        return 'Tito';
      case PlayerSkinEnum.underwear:
        return 'Nina';
    }
  }
}
