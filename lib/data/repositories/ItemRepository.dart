import 'package:nina_tito_magic_book/data/datasources/DatabaseHelper.dart';
import 'package:nina_tito_magic_book/domain/entities/Item.dart';
import 'package:nina_tito_magic_book/domain/repositories/ItemRepositoryInterface.dart';

class ItemRepository implements ItemRepositoryInterface {
  final DatabaseHelper _databaseHelper;

  ItemRepository(this._databaseHelper);

  @override
  Future<void> createItem(Item item) async {
    final db = await _databaseHelper.database;

    await db.insert('items', {
      'name': item.name,
      'description': item.description,
      'collected_at': item.collected_at
    });
  }
}