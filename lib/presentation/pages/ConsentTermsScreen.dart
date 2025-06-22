import 'package:flutter/material.dart';
import 'package:nina_tito_magic_book/presentation/components/ActionButton.dart';
import 'package:nina_tito_magic_book/presentation/components/BackgroundContainer.dart';
import 'package:nina_tito_magic_book/presentation/components/InfoModal.dart';

class ConsentTermsScreen extends StatelessWidget {
  const ConsentTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double buttonSize = MediaQuery.of(context).size.width * 0.15;
    final double modalWidth = MediaQuery.of(context).size.width * 0.6;
    final double modalHeight = MediaQuery.of(context).size.height * 0.7;
    final TextStyle headingStyle = Theme.of(context).textTheme.titleMedium!;
    final TextStyle bodyStyle = Theme.of(context).textTheme.bodySmall!;

    const String consentText = '''
Ao autorizar o jogo “As aventuras de Nina e Tito: em busca do livro mágico”, o(a) responsável concorda com a coleta e uso dos dados abaixo, conforme Lei 13.709/2018 (LGPD):

Dados: nome (opcional), idade, gênero, acertos/erros e personagem escolhido.

Finalidade: avaliar desempenho, gerar relatórios para professores e psicólogos e aperfeiçoar o jogo.

Compartilhamento: somente com profissionais credenciados, em ambiente seguro.

Base legal: seu consentimento (Art. 7º, I).

Seus direitos: acessar, corrigir ou excluir dados; revogar o consentimento; saber prazo de retenção.
''';

    return Scaffold(
      body: BackgroundContainer(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InfoModal(
                width: modalWidth,
                height: modalHeight,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Termos de consentimento do responsável',
                        style: headingStyle,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        consentText,
                        style: bodyStyle,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Voltar
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

                  // Aceitar
                  SizedBox(
                    width: buttonSize,
                    child: ActionButton(
                      type: ButtonType.confirmation,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ConsentTermsScreen(),
                          ),
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
}