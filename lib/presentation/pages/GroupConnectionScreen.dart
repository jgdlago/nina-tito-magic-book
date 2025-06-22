import 'package:flutter/material.dart';
import 'package:nina_tito_magic_book/presentation/components/ActionButton.dart';
import 'package:nina_tito_magic_book/presentation/components/BackgroundContainer.dart';
import 'package:nina_tito_magic_book/presentation/components/InfoModal.dart';

class GroupConnectionScreen extends StatelessWidget {
  const GroupConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double buttonSize = MediaQuery.of(context).size.width * 0.15;
    final double modalWidth = MediaQuery.of(context).size.width * 0.6;
    final TextStyle headingStyle = Theme.of(context).textTheme.titleMedium!;
    final TextStyle bodyStyle = Theme.of(context).textTheme.bodySmall!;
    final TextEditingController _codeController = TextEditingController();

    return Scaffold(
      body: BackgroundContainer(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InfoModal(
                width: modalWidth,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Conexão com a Turma',
                            style: headingStyle,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Digite o código da turma fornecido pelo seu professor:',
                            style: bodyStyle,
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: _codeController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Código da Turma',
                              labelStyle: bodyStyle,
                            ),
                            style: bodyStyle.copyWith(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 12),
                  SizedBox(
                    width: buttonSize,
                    child: ActionButton(
                      type: ButtonType.denial,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: buttonSize,
                    child: ActionButton(
                      type: ButtonType.confirmation,
                      onPressed: () {
                        // Lógica para validar e enviar o código
                        final code = _codeController.text.trim();
                        if (code.isNotEmpty) {
                          // TODO: Implementar lógica de conexão
                          print('Código enviado: $code');
                          // Navegar para próxima tela após conexão
                          // Navigator.push(...);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Por favor, digite um código válido'),
                            ),
                          );
                        }
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
}