import 'package:flutter/material.dart';
import '../theme/AppColors.dart';

class PauseMenuWidget extends StatelessWidget {
  final VoidCallback onResume;
  final VoidCallback onMainMenu;

  const PauseMenuWidget({
    super.key,
    required this.onResume,
    required this.onMainMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.goldenMagic.withOpacity(0.9),
            AppColors.goldenMagic.withOpacity(0.9),
          ],
        ),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 15),
                  Text(
                    "Jogo Pausado",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.mysticalBlack
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Botão de Continuar
              _buildMagicButton(
                context,
                icon: Icons.play_arrow,
                text: "Continuar",
                color: AppColors.confirmationGreen,
                onPressed: onResume,
              ),
              const SizedBox(height: 20),

              // Botão de Menu Principal
              _buildMagicButton(
                context,
                icon: Icons.home,
                text: "Menu",
                color: AppColors.warningAmber,
                onPressed: onMainMenu,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMagicButton(
      BuildContext context, {
        required IconData icon,
        required String text,
        required Color color,
        required VoidCallback onPressed,
      }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
        shadowColor: AppColors.mysticalBlack.withOpacity(0.4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 30,
            color: AppColors.mysticalWhite,
          ),
          const SizedBox(width: 15),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.mysticalWhite
            ),
          ),
        ],
      ),
    );
  }
}