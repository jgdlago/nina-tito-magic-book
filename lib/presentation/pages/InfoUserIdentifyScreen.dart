import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nina_tito_magic_book/data/models/gender_enum.dart';
import 'package:nina_tito_magic_book/presentation/components/background_container.dart';
import 'package:nina_tito_magic_book/presentation/components/action_button.dart';
import 'package:nina_tito_magic_book/presentation/components/info_modal.dart';
import 'package:nina_tito_magic_book/presentation/pages/CharacterSelectionScreen.dart';
import 'package:nina_tito_magic_book/presentation/pages/MainMenuScreen.dart';
import 'package:nina_tito_magic_book/presentation/theme/AppColors.dart';
import 'package:numberpicker/numberpicker.dart';

final ageProvider = StateProvider<int>((ref) => 9);
final genderProvider = StateProvider<GenderEnum>((ref) => GenderEnum.male);

class InfoUserIdentifyScreen extends ConsumerWidget {
  const InfoUserIdentifyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int selectedAge = ref.watch(ageProvider);
    final GenderEnum selectedGender = ref.watch(genderProvider);
    final double buttonSize = MediaQuery.of(context).size.width * 0.15;
    final double modalWidth = MediaQuery.of(context).size.width * 0.6;

    return Scaffold(
      body: BackgroundContainer(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: buttonSize,
                  child: ActionButton(
                    type: ButtonType.denial,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainMenuScreen()),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                InfoModal(
                  width: modalWidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Vamos nos conhecer!',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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
                              selectedTextStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
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
                                  children: <Widget>[
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
                    ],
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
                        MaterialPageRoute(builder: (context) => CharacterSelectionScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
