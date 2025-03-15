import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:nina_tito_magic_book/magic_book_game.dart';
import 'main_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainMenu(
        onStartGame: () {
          runApp(const MagicBookGameWidget());
        },
        onSettings: () {
          // Adicione a lógica para abrir a tela de configurações
          debugPrint('Abrir Configurações');
        },
      ),
    );
  }
}
