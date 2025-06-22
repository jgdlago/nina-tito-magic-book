import 'package:flutter/material.dart';
import 'package:nina_tito_magic_book/game/components/AudioManager.dart';
import 'package:nina_tito_magic_book/presentation/components/ActionButton.dart';
import 'package:nina_tito_magic_book/presentation/components/BackgroundContainer.dart';
import 'package:nina_tito_magic_book/presentation/components/InfoModal.dart';
import 'package:nina_tito_magic_book/presentation/pages/GroupConnectionScreen.dart';
import 'package:nina_tito_magic_book/presentation/theme/AppColors.dart';

class OptionsScreen extends StatefulWidget {
  const OptionsScreen({super.key});

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  bool narratorActive = AudioManager.narratorActive;
  bool musicActive = true;
  String? classCode = null;

  @override
  Widget build(BuildContext context) {
    final double buttonSize = MediaQuery.of(context).size.width * 0.15;
    final double modalWidth = MediaQuery.of(context).size.width * 0.6;

    return Scaffold(
      body: BackgroundContainer(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InfoModal(
                width: modalWidth,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Configurações',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.mysticalBlack,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Opção Narrador - SWITCH MELHORADO
                    _buildOptionRow(
                      context,
                      label: 'Narrador',
                      icon: Icons.record_voice_over,
                      isActive: narratorActive,
                      onChanged: (value) {
                        setState(() => narratorActive = value);
                        AudioManager.narratorActive = value;
                      },
                    ),
                    const Divider(height: 20, thickness: 1),
                    // Opção Música - SWITCH MELHORADO
                    _buildOptionRow(
                      context,
                      label: 'Música',
                      icon: Icons.music_note,
                      isActive: musicActive,
                      onChanged: (value) {
                        setState(() => musicActive = value);
                        AudioManager.musicActive = value;
                      },
                    ),
                    const Divider(height: 20, thickness: 1),
                    // Opção Turma - ESTILO UNIFICADO
                    _buildClassOption(context),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: buttonSize,
                child: ActionButton(
                  type: ButtonType.denial,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionRow(
      BuildContext context, {
        required String label,
        required IconData icon,
        required bool isActive,
        required ValueChanged<bool> onChanged,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.mysticalBlack),
              const SizedBox(width: 12),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          // SWITCH PERSONALIZADO
          Transform.scale(
            scale: 1.2,
            child: Switch.adaptive(
              value: isActive,
              activeColor: AppColors.confirmationGreen,
              activeTrackColor: AppColors.confirmationGreen.withOpacity(0.4),
              inactiveThumbColor: AppColors.mysticalBlack,
              inactiveTrackColor: AppColors.confirmationGreen.withOpacity(0.4),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassOption(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.group, color: AppColors.mysticalBlack),
              const SizedBox(width: 12),
              Text(
                'Turma',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          classCode != null
              ? Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: AppColors.confirmationGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.confirmationGreen,
                width: 1.5,
              ),
            ),
            child: Text(
              classCode!,
              style: TextStyle(
                color: AppColors.mysticalBlack,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          )
              : GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const GroupConnectionScreen()),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: AppColors.confirmationGreen,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Text(
                'Conectar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}