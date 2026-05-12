import 'package:flutter/material.dart';

class TransferenciaScreen extends StatelessWidget {
  const TransferenciaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Extraindo argumentos passados via rota
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String idUsuario = args?['idUsuario'] ?? 'N/A';
    final double valorInicial = args?['valorInicial'] ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferência'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID do Destinatário: $idUsuario', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Valor Sugerido: R\$ ${valorInicial.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Lógica de confirmação aqui
                Navigator.pop(context);
              },
              child: const Center(child: Text('Confirmar Transferência')),
            ),
          ],
        ),
      ),
    );
  }
}
