import 'package:flame/game.dart';
import 'package:nina_tito_magic_book/domain/entities/Player.dart';
import 'package:nina_tito_magic_book/game/Level.dart';
import 'package:nina_tito_magic_book/game/scenarios/Bedroom.dart';
import 'package:nina_tito_magic_book/providers/PlayerProvider.dart';
import '../main.dart';

class MagicBook extends FlameGame {
  late final Player player;

  MagicBook();

  @override
  Future<void> onLoad() async {
    final repo = globalContainer.read(playerRepositoryProvider);

    final data = await repo.getPlayerByCurrentUser();
    if (data == null) {
      throw Exception('Nenhum player encontrado para o usuário atual.');
    }
    player = Player.fromMap(data);

    final bedroom = await Bedroom.load();
    final world = Level(scene: bedroom, player: player);
    add(world);
  }
}
