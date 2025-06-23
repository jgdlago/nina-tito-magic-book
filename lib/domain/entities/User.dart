import 'package:nina_tito_magic_book/data/models/GenderEnum.dart';

class User {
  final int? id;
  final String? name;
  final int age;
  final GenderEnum gender;
  final int? playerId;
  final DateTime? termsAcceptedAt;

  User({
    this.id,
    this.name,
    required this.age,
    required this.gender,
    this.playerId,
    this.termsAcceptedAt,
  });

  String get displayName => name ?? gender.label;

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      gender: GenderEnum.values.firstWhere(
            (e) => e.label == map['gender'],
      ),
      playerId: map['player_id'],
      termsAcceptedAt: map['terms_accepted_at'] != null
          ? DateTime.parse(map['terms_accepted_at'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name ?? gender.label,
      'age': age,
      'gender': gender.label,
      'player_id': playerId,
      'terms_accepted_at': termsAcceptedAt?.toIso8601String(),
    };
  }
}
