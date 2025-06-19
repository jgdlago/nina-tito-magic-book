import 'package:flutter/material.dart';

class PauseMenuWidget extends StatelessWidget {
  final VoidCallback onResume;

  const PauseMenuWidget({super.key, required this.onResume});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xAA000000),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Jogo Pausado",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onResume,
              child: const Text("Continuar"),
            ),
          ],
        ),
      ),
    );
  }
}