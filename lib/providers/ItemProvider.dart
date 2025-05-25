import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nina_tito_magic_book/data/datasources/DatabaseHelper.dart';
import 'package:nina_tito_magic_book/data/repositories/ItemRepository.dart';
import 'package:nina_tito_magic_book/domain/repositories/ItemRepositoryInterface.dart';

final databaseHelperProvider = Provider<DatabaseHelper>((ref) {
  return DatabaseHelper();
});

final itemRepositoryProvider = Provider<ItemRepositoryInterface>((ref) {
  final databaseHelper = ref.watch(databaseHelperProvider);
  return ItemRepository(databaseHelper);
});