import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nina_tito_magic_book/data/models/gender_enum.dart';
import 'package:nina_tito_magic_book/presentation/components/background_container.dart';

final ageProvider = StateProvider<int>((ref) => 9);
final genderProvider = StateProvider<GenderEnum>((ref) => GenderEnum.male);

class UserIdentity extends ConsumerWidget {
  const UserIdentity({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int selectedAge = ref.watch(ageProvider);
    final GenderEnum selectedGender = ref.watch(genderProvider);

    return Scaffold(
      body: BackgroundContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Quantos anos você tem?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            Slider(
              value: selectedAge.toDouble(),
              min: 6,
              max: 12,
              divisions: 6,
              label: selectedAge.toString(),
              onChanged: (double value) {
                ref.read(ageProvider.notifier).state = value.toInt();
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Radio<GenderEnum>(
                      value: GenderEnum.male,
                      groupValue: selectedGender,
                      onChanged: (GenderEnum? value) {
                        ref.read(genderProvider.notifier).state = value!;
                      },
                    ),
                    Text(selectedGender.label),
                  ],
                ),

                Row(
                  children: [
                    Radio<GenderEnum>(
                      value: GenderEnum.female,
                      groupValue: selectedGender,
                      onChanged: (GenderEnum? value) {
                        ref.read(genderProvider.notifier).state = value!;
                      },
                    ),
                    Text(selectedGender.label),
                  ],
                ),
              ],
            ),

            Text(
              'Eu sou ${selectedGender.label} e tenho $selectedAge anos!',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
