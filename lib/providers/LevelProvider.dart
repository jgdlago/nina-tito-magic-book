import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nina_tito_magic_book/data/repositories/LevelRepository.dart';
import 'package:nina_tito_magic_book/domain/repositories/LevelRepositoryInterface.dart';
import 'package:nina_tito_magic_book/providers/DatabaseProvider.dart';

final levelRepositoryProvider = Provider<LevelRepositoryInterface>((ref) {
  final db = ref.read(databaseHelperProvider);
  return LevelRepository(db);
});