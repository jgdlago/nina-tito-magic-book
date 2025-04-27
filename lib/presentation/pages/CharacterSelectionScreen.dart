import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nina_tito_magic_book/data/models/CharacterEnum.dart';
import 'package:nina_tito_magic_book/domain/entities/Player.dart';
import 'package:nina_tito_magic_book/domain/entities/User.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';
import 'package:nina_tito_magic_book/presentation/components/BackgroundContainer.dart';
import 'package:nina_tito_magic_book/presentation/components/InfoModal.dart';
import 'package:nina_tito_magic_book/presentation/components/ActionButton.dart';
import 'package:nina_tito_magic_book/presentation/pages/UserInfoIdentifyScreen.dart';
import 'package:nina_tito_magic_book/presentation/theme/AppColors.dart';
import 'package:nina_tito_magic_book/providers/PlayerProvider.dart';
import 'package:nina_tito_magic_book/providers/UserProvider.dart';

final characterProvider = StateProvider<CharacterEnum>((ref) => CharacterEnum.tito);

class CharacterSelectionScreen extends ConsumerWidget {
  const CharacterSelectionScreen({super.key});

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
                      onPressed: () => _saveAndContinue(context, ref, selectedCharacter)
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

  void _saveAndContinue(BuildContext context, WidgetRef ref, CharacterEnum selectedCharacter) async {
    final userRepository = ref.read(userRepositoryProvider);
    final playerRepository = ref.read(playerRepositoryProvider);

    final user = User(
      name: ref.read(nameProvider),
      age: ref.read(ageProvider),
      gender: ref.read(genderProvider),
    );

    final createdUser = await userRepository.createUser(user);

    final player = Player(character: selectedCharacter);
    await playerRepository.createPlayer(player, createdUser.id!);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GameWidget(game: MagicBook()),
      ),
    );
  }
}

