import 'dart:ui';
import 'package:flame/components.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';

class PauseMenu extends Component with HasGameReference<MagicBook> {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    final background = RectangleComponent(
      size: game.size,
      paint: Paint()..color = const Color(0x80000000),
    )..anchor = Anchor.topLeft;
    add(background);
  }
}