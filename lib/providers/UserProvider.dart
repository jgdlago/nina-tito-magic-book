import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nina_tito_magic_book/data/repositories/UserRepository.dart';
import 'package:nina_tito_magic_book/domain/repositories/UserRepositoryInterface.dart';
import 'package:nina_tito_magic_book/providers/DatabaseProvider.dart';

final userRepositoryProvider = Provider<UserRepositoryInterface>((ref) {
  final db = ref.read(databaseHelperProvider);
  return UserRepository(db);
});