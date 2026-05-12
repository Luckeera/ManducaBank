import 'package:flutter/material.dart';

class PrincipalScreen extends StatelessWidget {
  const PrincipalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ManducaBank - Principal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/cotacao'),
              child: const Text('Ver Cotações'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Exemplo de passagem de argumentos para a tela de transferência
                Navigator.pushNamed(
                  context, 
                  '/transferencia', 
                  arguments: {'idUsuario': '12345', 'valorInicial': 100.0}
                );
              },
              child: const Text('Realizar Transferência'),
            ),
          ],
        ),
      ),
    );
  }
}
