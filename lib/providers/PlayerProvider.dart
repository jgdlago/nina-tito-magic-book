import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nina_tito_magic_book/data/repositories/PlayerRepository.dart';
import 'package:nina_tito_magic_book/domain/repositories/PlayerRepositoryInterface.dart';
import 'package:nina_tito_magic_book/presentation/pages/UserInfoIdentifyScreen.dart';
import 'package:nina_tito_magic_book/providers/DatabaseProvider.dart';

final playerRepositoryProvider = Provider<PlayerRepositoryInterface>((ref) {
  final db = ref.read(databaseHelperProvider);
  final userRepo = ref.read(userRepositoryProvider);
  return PlayerRepository(db, userRepo);
});
