import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nina_tito_magic_book/presentation/theme/AppColors.dart';
import 'package:nina_tito_magic_book/game/components/AudioManager.dart';
import 'package:nina_tito_magic_book/providers/SettingsProvider.dart';

class OptionsScreen extends ConsumerWidget {
  const OptionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Opções'),
        backgroundColor: AppColors.goldenMagic,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Som'),
            _buildVolumeSlider(
              label: 'Volume da Música',
              value: settings.musicVolume,
              onChanged: (value) {
                settingsNotifier.setMusicVolume(value);
                AudioManager.setMusicVolume(value);
              },
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.confirmationGreen,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text('Voltar', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.mysticalWhite,
        ),
      ),
    );
  }

  Widget _buildVolumeSlider({
    required String label,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.mysticalWhite,
            ),
          ),
          Row(
            children: [
              const Icon(Icons.volume_mute, color: AppColors.mysticalWhite),
              Expanded(
                child: Slider(
                  value: value,
                  onChanged: onChanged,
                  min: 0,
                  max: 1,
                  divisions: 10,
                  activeColor: AppColors.confirmationGreen,
                  inactiveColor: AppColors.mysticalWhite,
                ),
              ),
              const Icon(Icons.volume_up, color: AppColors.mysticalWhite),
            ],
          ),
        ],
      ),
    );
  }
}