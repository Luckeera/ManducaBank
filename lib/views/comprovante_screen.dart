import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ComprovanteScreen extends StatelessWidget {
  const ComprovanteScreen({super.key});

  void compartilharComprovante() {
    SharePlus.instance.share(
      ShareParams(
        text: '''
Comprovante Pix

Valor: R\$ 100,00
Destinatário: João Silva
Banco: ManducaBank

Transferência realizada com sucesso.
''',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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

            const Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Valor'),
                      trailing: Text('R\$ 100,00'),
                    ),
                    ListTile(
                      title: Text('Destinatário'),
                      trailing: Text('João Silva'),
                    ),
                    ListTile(
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
                child: const Text('Compartilhar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}