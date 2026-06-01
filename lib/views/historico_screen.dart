import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class HistoricoScreen extends StatefulWidget {
  const HistoricoScreen({super.key});

  @override
  State<HistoricoScreen> createState() => _HistoricoScreenState();
}

class _HistoricoScreenState extends State<HistoricoScreen> {
  final DatabaseHelper _db = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Histórico',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_outlined, color: Colors.redAccent),
            onPressed: () => _confirmarLimpeza(context),
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _db.getTransferencias(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.history, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Nenhuma transferência encontrada.',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ],
              ),
            );
          }

          final transferencias = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: transferencias.length,
            itemBuilder: (context, index) {
              final transacao = transferencias[index];
              final double valor = transacao['valor'] ?? 0.0;
              final String destinatario = transacao['destinatario'] ?? 'Desconhecido';
              final String data = transacao['data'] ?? '';
              final String tipo = transacao['tipo'] ?? 'Transferência';

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  leading: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                  title: Text(
                    destinatario,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '$data\n$tipo',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  trailing: Text(
                    '- R\$ ${valor.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/comprovante',
                      arguments: transacao,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _confirmarLimpeza(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar Histórico'),
        content: const Text('Deseja apagar todas as transferências salvas?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              await _db.clearHistorico();
              if (mounted) {
                setState(() {});
                Navigator.pop(context);
              }
            },
            child: const Text('Limpar', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}
