import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ComprovanteScreen extends StatelessWidget {
  const ComprovanteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Recebe dinamicamente os dados enviados pela TransferenciaScreen
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    
    final double valor = args?['valor'] ?? 0.0;
    final String destinatario = args?['destinatario'] ?? 'Não informado';
    final String tipo = args?['tipo'] ?? 'Transferência';

    void compartilharComprovante() {
      SharePlus.instance.share(
        ShareParams(
          text: '''
Comprovante ManducaBank

Tipo: $tipo
Valor: R\$ ${valor.toStringAsFixed(2)}
Destinatário: $destinatario
Banco: ManducaBank

Transferência realizada com sucesso via SQLite.
''',
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comprovante'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Transferência realizada!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Card(
              color: const Color(0xFF1E1E1E), // Alinhado ao design escuro do grupo
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Valor'),
                      trailing: Text(
                        'R\$ ${valor.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: const Text('Destinatário'),
                      trailing: Text(destinatario),
                    ),
                    ListTile(
                      title: const Text('Descrição/Tipo'),
                      trailing: Text(tipo),
                    ),
                    const ListTile(
                      title: Text('Banco'),
                      trailing: Text('ManducaBank'),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: compartilharComprovante,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Compartilhar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}