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

  static GenderEnum genderFromString(String gender) {
    switch (gender) {
      case 'Menino':
        return GenderEnum.male;
      case 'Menina':
        return GenderEnum.female;
      default:
        throw Exception('Gênero desconhecido');
    }
  }

  String toApiString() {
    switch (this) {
      case GenderEnum.male:
        return 'male';
      case GenderEnum.female:
        return 'female';
    }
  }
}
