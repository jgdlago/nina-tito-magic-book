import 'package:nina_tito_magic_book/domain/entities/Item.dart';

abstract class ItemRepositoryInterface {
  Future<void> createItem(Item item);
}