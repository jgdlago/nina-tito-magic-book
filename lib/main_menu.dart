import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainMenu extends StatelessWidget {
  final VoidCallback onStartGame;
  final VoidCallback onSettings;

  const MainMenu({
    super.key,
    required this.onStartGame,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/main_menu_background.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Color(0x80000000),
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  'As aventuras de Nina e Tito em busca do livro màgico',
                  style: GoogleFonts.londrinaShadow(
                    fontSize: 44,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // Botão configurações
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: ElevatedButton(
                  onPressed: onSettings,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Configurações'),
                ),
              ),
            ),
            // Botão iniciar
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: ElevatedButton(
                  onPressed: onStartGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Iniciar Jogo'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
