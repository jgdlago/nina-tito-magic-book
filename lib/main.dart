import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:nina_tito_magic_book/data/datasources/database_helper.dart';
import 'package:nina_tito_magic_book/game/magic_book_game.dart';
import 'presentation/pages/main_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseHelper().database;
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
          debugPrint('Abrir Configurações');
        },
      ),
    );
  }
}
