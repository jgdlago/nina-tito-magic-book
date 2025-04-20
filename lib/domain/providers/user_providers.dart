import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nina_tito_magic_book/data/datasources/DatabaseHelper.dart';
import 'package:nina_tito_magic_book/data/repositories/UserRepository.dart';
import 'package:nina_tito_magic_book/domain/repositories/UserRepositoryInterface.dart';

final userRepositoryProvider = Provider<UserRepositoryInterface>((ref) {
  return UserRepository(DatabaseHelper());
});