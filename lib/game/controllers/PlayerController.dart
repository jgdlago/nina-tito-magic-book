import 'package:nina_tito_magic_book/data/models/MoveCommandEnum.dart';

class PlayerController {
  MoveCommandEnum _command = MoveCommandEnum.stop;
  MoveCommandEnum get command => _command;

  void moveLeft() => _command = MoveCommandEnum.left;
  void moveRight() => _command = MoveCommandEnum.right;
  void stop() => _command = MoveCommandEnum.stop;
  void jump() => _command = MoveCommandEnum.jump;
}
