import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nina_tito_magic_book/presentation/components/BackgroundContainer.dart';
import 'package:nina_tito_magic_book/presentation/components/ActionButton.dart';
import 'package:nina_tito_magic_book/presentation/components/InfoModal.dart';
import 'package:nina_tito_magic_book/presentation/pages/UserInfoIdentifyScreen.dart';
import 'package:nina_tito_magic_book/presentation/pages/MainMenuScreen.dart';

class UserNameIdentifyScreen extends ConsumerStatefulWidget {
  const UserNameIdentifyScreen({super.key});

  @override
  ConsumerState<UserNameIdentifyScreen> createState() =>
      _UserNameIdentifyScreenState();
}

class _UserNameIdentifyScreenState extends ConsumerState<UserNameIdentifyScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _isNameEmpty = true;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {
        _isNameEmpty = _nameController.text.trim().isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onContinue() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserInfoIdentifyScreen(name: _nameController.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                // Botão de voltar
                SizedBox(
                  width: buttonSize,
                  child: ActionButton(
                    type: ButtonType.denial,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainMenuScreen(),
                        ),
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
                      Text(
                        'Qual seu nome?',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'Digite seu nome',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: buttonSize,
                  child: ActionButton(
                    type: _isNameEmpty ? ButtonType.skip : ButtonType.confirmation,
                    onPressed: _onContinue,
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
