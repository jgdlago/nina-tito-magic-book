import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nina_tito_magic_book/domain/repositories/UserRepositoryInterface.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';
import 'package:nina_tito_magic_book/presentation/pages/InfoScreen.dart';
import 'package:nina_tito_magic_book/presentation/components/CustomIconButton.dart';
import 'package:nina_tito_magic_book/presentation/pages/UserInfoIdentifyScreen.dart';
import 'package:nina_tito_magic_book/presentation/pages/UserNameIdentifyScreen.dart';
import 'package:nina_tito_magic_book/presentation/theme/AppColors.dart';

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
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Color(0x60000000),
            BlendMode.darken,
          ),
        ),
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'As aventuras de Nina e Tito',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: AppColors.mysticalWhite,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Em busca do livro mágico',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: AppColors.mysticalWhite,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _BottomButtons extends ConsumerWidget {
  const _BottomButtons();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double iconButtonSize = MediaQuery.of(context).size.width * 0.075;
    final userRepository = ref.read(userRepositoryProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: iconButtonSize,
                child: CustomIconButton(
                  type: IconType.info,
                  onPressed: () => _openInfoScreen(context),
                  color: AppColors.warningAmber,
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: iconButtonSize,
                child: CustomIconButton(
                  type: IconType.more,
                  onPressed: () => _openSettings(context),
                  color: AppColors.warningAmber,
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: CustomIconButton(
              type: IconType.play,
              onPressed: () => _openGameScreen(context, userRepository),
              color: AppColors.confirmationGreen,
            ),
          ),
        ],
      ),
    );
  }

  void _openSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MainMenuScreen()),
    );
  }

  Future<void> _openGameScreen(BuildContext context, UserRepositoryInterface userRepository) async {
    final user = await userRepository.getUser();
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GameWidget(game: MagicBook()),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserNameIdentifyScreen()),
      );
    }
  }

  void _openInfoScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InfoScreen()),
    );
  }
}