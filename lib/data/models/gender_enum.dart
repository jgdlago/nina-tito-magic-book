enum GenderEnum {
  male,
  female,
}

extension GenderEnumExtension on GenderEnum {
  String get label {
    switch (this) {
      case GenderEnum.male:
        return 'Masculino';
      case GenderEnum.female:
        return 'Feminino';
    }
  }
}
