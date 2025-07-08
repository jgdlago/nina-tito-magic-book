
class Level {
  final int? id;
  final int order;
  final String name;
  final String message;
  final String scenario;
  final DateTime? finishedAt;

  Level({
    this.id,
    required this.order,
    required this.name,
    required this.message,
    required this.scenario,
    this.finishedAt,
  });

  factory Level.fromMap(Map<String, dynamic> map) {
    return Level(
      id: map['id'] as int?,
      order: map['level_order'] as int,
      name: map['name'] as String,
      message: map['message'] as String,
      scenario: map['scenario'] as String,
      finishedAt: map['finished_at'] != null
          ? DateTime.tryParse(map['finished_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'level_order': order,
      'name': name,
      'message': message,
      'scenario': scenario,
      'finished_at': finishedAt?.toIso8601String(),
    };
  }
}
