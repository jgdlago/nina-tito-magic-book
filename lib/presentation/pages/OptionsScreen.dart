import 'package:flutter/material.dart';
import 'package:nina_tito_magic_book/game/components/AudioManager.dart';
import 'package:nina_tito_magic_book/presentation/components/ActionButton.dart';
import 'package:nina_tito_magic_book/presentation/components/BackgroundContainer.dart';
import 'package:nina_tito_magic_book/presentation/components/InfoModal.dart';
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
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 20),
                    // Opção Narrador
                    _buildOptionRow(
                      context,
                      label: 'Narrador',
                      status: narratorActive ? 'ativado' : 'desativado',
                      isActive: narratorActive,
                      onChanged: (value) {
                        setState(() => narratorActive = value);
                        AudioManager.narratorActive = value;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Opção Música
                    _buildOptionRow(
                      context,
                      label: 'Música',
                      status: musicActive ? 'ativado' : 'desativado',
                      isActive: musicActive,
                      onChanged: (value) {
                        setState(() => musicActive = value);
                        AudioManager.musicActive = value;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Opção Turma
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Turma',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          classCode != null
                              ? Text(
                            'conectado $classCode',
                            style: TextStyle(
                              color: AppColors.mysticalBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                              : Container(
                            decoration: BoxDecoration(
                              color: AppColors.mysticalBlack,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            child: const Text(
                              'Conectar turma',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: buttonSize,
                child: ActionButton(
                  type: ButtonType.denial,
                  onPressed: () {
                    Navigator.pop(context);
                  },
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
        required String status,
        required bool isActive,
        required ValueChanged<bool> onChanged,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Row(
            children: [
              Text(
                status,
                style: TextStyle(
                  color: isActive ? AppColors.mysticalBlack : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 12),
              Switch(
                value: isActive,
                activeColor: AppColors.fantasyGreen,
                onChanged: onChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }
}