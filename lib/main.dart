import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nina_tito_magic_book/presentation/pages/MainMenuScreen.dart';
import 'package:nina_tito_magic_book/presentation/theme/AppTheme.dart';
import 'package:nina_tito_magic_book/providers/DatabaseProvider.dart';

final globalContainer = ProviderContainer();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  await globalContainer.read(databaseHelperProvider).database;

  runApp(
    UncontrolledProviderScope(
      container: globalContainer,
      child: const App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'As Aventuras de Nina e Tito',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const MainMenuScreen(),
    );
  }
}
