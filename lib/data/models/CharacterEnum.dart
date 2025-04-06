enum CharacterEnum {
  tito,
  nina,
}

extension CharacterEnumExtension on CharacterEnum {
  String get label {
    switch (this) {
      case CharacterEnum.tito:
        return 'Tito';
      case CharacterEnum.nina:
        return 'Nina';
    }
  }
}
