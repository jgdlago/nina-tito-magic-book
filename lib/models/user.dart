import 'package:nina_tito_magic_book/enums/gender_enum.dart';

class User {
  final int id;
  final String name;
  final int age;
  final Gender gender;
  final int? playerId;

  User({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    this.playerId,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      gender: Gender.values.firstWhere((e) => e.toString() == 'Gender.${map['gender']}'),
      playerId: map['player_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender.toString().split('.').last,
      'player_id': playerId,
    };
  }
}
