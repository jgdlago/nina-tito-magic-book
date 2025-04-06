import 'package:flutter/material.dart';
import 'package:nina_tito_magic_book/presentation/components/background_container.dart';
import 'package:nina_tito_magic_book/presentation/components/Info_modal.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    final double modalWidth = MediaQuery.of(context).size.width * 0.6;

    return Scaffold(
      body: BackgroundContainer(
        child: Center(
          child: InfoModal(
            width: modalWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Bem Vindo!',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Nina e Tito: Em busca do livro mágico é um jogo educativo voltado para crianças de 6 a 12 anos. Seu principal objetivo é ajudar na prevenção, identificação e conscientização sobre possíveis situações de vulnerabilidade infantil. O conteúdo do jogo é baseado em uma pesquisa desenvolvida pela psicóloga Me. Jussara Besutti.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}