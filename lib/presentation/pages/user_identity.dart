import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nina_tito_magic_book/data/models/gender_enum.dart';
import 'package:nina_tito_magic_book/presentation/components/background_container.dart';
import 'package:nina_tito_magic_book/presentation/theme/app_colors.dart';
import 'package:numberpicker/numberpicker.dart';

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
            color: AppColors.mysticalWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.mysticalBlack,
              width: 4,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Vamos nos conhecer!',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Qual sua idade?',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              NumberPicker(
                value: selectedAge,
                minValue: 4,
                maxValue: 14,
                step: 1,
                axis: Axis.horizontal,
                selectedTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                onChanged: (value) {
                  ref.read(ageProvider.notifier).state = value;
                },
              ),
              Text(
                'Você é:',
                style: Theme.of(context).textTheme.bodySmall,
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
                      Text(
                        GenderEnum.male.label,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: selectedGender == GenderEnum.male ? FontWeight.bold : FontWeight.normal,
                          color: selectedGender == GenderEnum.male ? AppColors.enchantedBlue : AppColors.mysticalBlack,
                        ),
                      ),
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
                      Text(
                        GenderEnum.female.label,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: selectedGender == GenderEnum.female ? FontWeight.bold : FontWeight.normal,
                          color: selectedGender == GenderEnum.female ? AppColors.dreamyPink : AppColors.mysticalBlack,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                'Eu sou ${selectedGender.label} e tenho $selectedAge anos!',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
