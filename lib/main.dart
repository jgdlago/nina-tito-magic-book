import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nina_tito_magic_book/presentation/pages/MainMenuScreen.dart';
import 'package:nina_tito_magic_book/presentation/theme/AppTheme.dart';
import 'package:nina_tito_magic_book/providers/DatabaseProvider.dart';

final initializationProvider = FutureProvider<void>((ref) async {
  await ref.read(databaseHelperProvider).database;
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const env = String.fromEnvironment('ENV', defaultValue: 'development');
  await dotenv.load(fileName: env == 'production' ? '.env.production' : '.env');

  try {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();

    runApp(
      const ProviderScope(
        child: AppWrapper(),
      ),
    );
  } catch (e) {
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Erro na inicialização: $e'),
          ),
        ),
      ),
    );
  }
}

class AppWrapper extends ConsumerWidget {
  const AppWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initializationState = ref.watch(initializationProvider);

    return initializationState.when(
      loading: () => const MaterialApp(),
      error: (err, stack) => MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Erro: $err')),
        ),
      ),
      data: (_) => const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'As Aventuras de Nina e Tito',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const MainMenuScreen(),
    );
  }
}