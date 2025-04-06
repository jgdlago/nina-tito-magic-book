enum GenderEnum {
  male,
  female,
}

extension GenderEnumExtension on GenderEnum {
  String get label {
    switch (this) {
      case GenderEnum.male:
        return 'Menino';
      case GenderEnum.female:
        return 'Menina';
    }
  }
}
