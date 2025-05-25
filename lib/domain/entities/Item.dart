class Item {
  final int? id;
  final String name;
  final String? description;
  final int level_id;

  Item({
    this.id,
    required this.name,
    this.description,
    required this.level_id,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      level_id: map['level_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'level_id': level_id,
    };
  }
}