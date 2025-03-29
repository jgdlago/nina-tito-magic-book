import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nina_tito_magic_book/data/models/gender_enum.dart';
import 'package:nina_tito_magic_book/presentation/components/background_container.dart';
import 'package:nina_tito_magic_book/presentation/theme/app_colors.dart';

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
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.goldenMagic,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.mysticalBlack,
              width: 3,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Quantos anos você tem?',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              Slider(
                value: selectedAge.toDouble(),
                min: 6,
                max: 12,
                divisions: 6,
                label: selectedAge.toString(),
                activeColor: AppColors.mysticalBlack,
                inactiveColor: Colors.white,
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
                        activeColor: AppColors.enchantedBlue,
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
                        activeColor: AppColors.dreamyPink,
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
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
