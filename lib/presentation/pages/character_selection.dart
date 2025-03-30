import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nina_tito_magic_book/data/models/character_enum.dart';
import 'package:nina_tito_magic_book/presentation/components/background_container.dart';

final characterProvider = StateProvider<CharacterEnum>((ref) => CharacterEnum.tito);

class CharacterSelection extends ConsumerWidget {
  const CharacterSelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CharacterEnum selectedCharacter = ref.watch(characterProvider);

    return Scaffold(
      body: BackgroundContainer(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCharacterCard(context, ref, CharacterEnum.nina, selectedCharacter),
                _buildCharacterCard(context, ref, CharacterEnum.tito, selectedCharacter),
              ],
            ),
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

    return GestureDetector(
      onTap: () => ref.read(characterProvider.notifier).state = character,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: MediaQuery.of(context).size.width * 0.35,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.amber : Colors.white,
            width: isSelected ? 4 : 2,
          ),
          color: Colors.black.withOpacity(0.3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 80, color: isSelected ? Colors.amber : Colors.white),
            const SizedBox(height: 12),
            Text(
              character == CharacterEnum.nina ? "Nina" : "Tito",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.amber : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
