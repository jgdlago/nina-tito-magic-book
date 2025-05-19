
class Level {
  final int? id;
  final int order;
  final String name;
  final String message;
  final DateTime? finishedAt;

  Level({
    this.id,
    required this.order,
    required this.name,
    required this.message,
    this.finishedAt,
  });

  factory Level.fromMap(Map<String, dynamic> map) {
    return Level(
      id: map['id'],
      order: map['level_order'],
      name: map['name'],
      message: map['message'],
      finishedAt: map['finished_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'level_order': order,
      'name': name,
      'message': message,
      'finished_at': finishedAt,
    };
  }
}