class Item {
  final int? id;
  final String name;
  final String? description;
  final String collected_at;

  Item({
    this.id,
    required this.name,
    this.description,
    required this.collected_at
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      collected_at: map['collected_at']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'collected_at': collected_at
    };
  }
}