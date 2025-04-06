import 'package:flutter/material.dart';
import 'package:nina_tito_magic_book/presentation/pages/info.dart';
import 'package:nina_tito_magic_book/presentation/pages/user_identity.dart';
import 'package:nina_tito_magic_book/presentation/components/custom_icon_button.dart';
import 'package:nina_tito_magic_book/presentation/theme/app_colors.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

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

class _BottomButtons extends StatelessWidget {
  const _BottomButtons();

  @override
  Widget build(BuildContext context) {
    final double iconButtonSize = MediaQuery.of(context).size.width * 0.075;

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
              onPressed: () => _openGameScreen(context),
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
      MaterialPageRoute(builder: (context) => const MainMenu()),
    );
  }

  void _openGameScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserIdentity()),
    );
  }

  void _openInfoScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Info()),
    );
  }
}
