import 'package:flutter/material.dart';

class EmConstrucaoScreen extends StatelessWidget {
  const EmConstrucaoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final String titulo = args is String ? args : 'Recurso';

    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.construction,
                size: 80,
                color: Color.fromARGB(255, 255, 62, 126),
              ),
              const SizedBox(height: 24),
              Text(
                'A tela de $titulo está chegando!',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Nossos desenvolvedores estão trabalhando duro nesta funcionalidade.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}