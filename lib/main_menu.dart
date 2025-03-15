import 'package:flutter/material.dart';

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
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'As aventuras de Nina e Tito',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: onStartGame,
                child: const Text('Iniciar Jogo'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onSettings,
                child: const Text('Configurações'),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
