import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nina_tito_magic_book/data/models/character_enum.dart';
import 'package:nina_tito_magic_book/presentation/components/background_container.dart';
import 'package:nina_tito_magic_book/presentation/components/info_modal.dart';
import 'package:nina_tito_magic_book/presentation/components/action_button.dart';
import 'package:nina_tito_magic_book/presentation/pages/main_menu.dart';
import 'package:nina_tito_magic_book/presentation/theme/app_colors.dart';

final characterProvider = StateProvider<CharacterEnum>((ref) => CharacterEnum.tito);

class CharacterSelection extends ConsumerWidget {
  const CharacterSelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CharacterEnum selectedCharacter = ref.watch(characterProvider);
    final double buttonSize = MediaQuery.of(context).size.width * 0.15;

    return Scaffold(
      body: BackgroundContainer(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCharacterCard(context, ref, CharacterEnum.nina, selectedCharacter),
                    _buildCharacterCard(context, ref, CharacterEnum.tito, selectedCharacter),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: buttonSize,
                    child: ActionButton(
                      type: ButtonType.denial,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: buttonSize,
                    child: ActionButton(
                      type: ButtonType.confirmation,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainMenu()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterCard(
      BuildContext context,
      WidgetRef ref,
      CharacterEnum character,
      CharacterEnum selectedCharacter,
      ) {
    bool isSelected = character == selectedCharacter;
    final String imagePath = character == CharacterEnum.nina
        ? 'assets/game/main_characters/nina/Idle (1).png'
        : 'assets/game/main_characters/tito/Idle (1).png';

    return GestureDetector(
      onTap: () => ref.read(characterProvider.notifier).state = character,
      child: InfoModal(
        width: MediaQuery.of(context).size.width * 0.35,
        height: 250,
        padding: const EdgeInsets.all(10),
        borderColor: isSelected ? AppColors.confirmationGreen : AppColors.mysticalBlack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 12),
              Text(
                character == CharacterEnum.nina ? "Nina" : "Tito",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? AppColors.confirmationGreen : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

