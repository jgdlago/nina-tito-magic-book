import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nina_tito_magic_book/domain/repositories/ItemRepositoryInterface.dart';
import 'package:nina_tito_magic_book/domain/repositories/LevelRepositoryInterface.dart';
import 'package:nina_tito_magic_book/domain/repositories/PlayerRepositoryInterface.dart';
import 'package:nina_tito_magic_book/domain/repositories/UserRepositoryInterface.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';
import 'package:nina_tito_magic_book/presentation/components/CustomIconButton.dart';
import 'package:nina_tito_magic_book/presentation/components/PauseMenuWidget.dart';
import 'package:nina_tito_magic_book/presentation/pages/InfoScreen.dart';
import 'package:nina_tito_magic_book/presentation/pages/UserNameIdentifyScreen.dart';
import 'package:nina_tito_magic_book/presentation/theme/AppColors.dart';
import 'package:nina_tito_magic_book/providers/ItemProvider.dart';
import 'package:nina_tito_magic_book/providers/LevelProvider.dart';
import 'package:nina_tito_magic_book/providers/PlayerProvider.dart';
import 'package:nina_tito_magic_book/providers/UserProvider.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          _Background(),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 50),
                _TitleSection(),
                Spacer(),
                _BottomButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/background.png"),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(Color(0x60000000), BlendMode.darken),
      ),
    ),
  );
}

class _TitleSection extends StatelessWidget {
  const _TitleSection();

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'As aventuras de Nina e Tito',
        style: Theme.of(context).textTheme.titleLarge!
            .copyWith(color: AppColors.mysticalWhite),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 8),
      Text(
        'Em busca do livro mágico',
        style: Theme.of(context).textTheme.titleMedium!
            .copyWith(color: AppColors.mysticalWhite),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

class _BottomButtons extends ConsumerWidget {
  const _BottomButtons();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final userRepo = ref.read(userRepositoryProvider);
    final playerRepo = ref.read(playerRepositoryProvider);
    final levelRepo = ref.read(levelRepositoryProvider);
    final itemRepo = ref.read(itemRepositoryProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: size.width * 0.075,
                child: CustomIconButton(
                  type: IconType.info,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const InfoScreen()),
                  ),
                  color: AppColors.warningAmber,
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: size.width * 0.075,
                child: CustomIconButton(
                  type: IconType.more,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MainMenuScreen()),
                  ),
                  color: AppColors.warningAmber,
                ),
              ),
            ],
          ),
          SizedBox(
            width: size.width * 0.15,
            child: CustomIconButton(
              type: IconType.play,
              onPressed: () => _handlePlay(context, userRepo, playerRepo, levelRepo, itemRepo),
              color: AppColors.confirmationGreen,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handlePlay(BuildContext context,
      UserRepositoryInterface userRepo,
      PlayerRepositoryInterface playerRepo,
      LevelRepositoryInterface levelRepo,
      ItemRepositoryInterface itemRepo) async {

    final user = await userRepo.getCurrentUser();
    final player = await playerRepo.getPlayerByCurrentUser();

    if (user == null || player == null) {
      return _goToIdentify(context);
    }

    final game = MagicBook(
      playerRepository: playerRepo,
      userRepository: userRepo,
      levelRepository: levelRepo,
      itemRepository: itemRepo,
    );

    game.overlays.addEntry('pauseMenu', (context, gameInstance) {
      final magicBook = gameInstance as MagicBook;
      return PauseMenuWidget(
        onResume: magicBook.togglePause,
        onMainMenu: () {
          magicBook.resumeEngine();
          Navigator.of(context).pop();
        },
      );
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GameWidget(
          game: game,
        ),
      ),
    );
  }

  void _goToIdentify(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const UserNameIdentifyScreen()),
    );
  }
}