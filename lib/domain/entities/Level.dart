
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
      id: map['id'],
      order: map['level_order'],
      name: map['name'],
      message: map['message'],
      scenario: map['scenario'],
      finishedAt: map['finished_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'level_order': order,
      'name': name,
      'message': message,
      'scenario': scenario,
      'finished_at': finishedAt,
    };
  }
}
