import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nina_tito_magic_book/presentation/pages/user_identity.dart';
import 'package:nina_tito_magic_book/presentation/components/custom_icon_button.dart';
import 'package:nina_tito_magic_book/presentation/theme/app_colors.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final double buttonSize = MediaQuery.of(context).size.width * 0.15;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Color(0x60000000),
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'As aventuras de Nina e Tito',
                      style: GoogleFonts.cinzel(
                        fontSize: 44,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Em busca do livro mágico',
                      style: GoogleFonts.cinzel(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 50.0, bottom: 50.0),
                child: SizedBox(
                  width: buttonSize,
                  child: CustomIconButton(
                    type: IconType.more,
                    onPressed: getSettingsScreen,
                    color: AppColors.warningAmber,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 50.0, bottom: 50.0),
                child: SizedBox(
                  width: buttonSize,
                  child: CustomIconButton(
                    type: IconType.play,
                    onPressed: getGameScreen,
                    color: AppColors.confirmationGreen,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSettingsScreen() {
    return MainMenu();
  }

  Widget getGameScreen() {
    return UserIdentity();
  }
}
