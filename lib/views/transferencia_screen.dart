import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';

class TransferenciaScreen extends StatefulWidget {
  const TransferenciaScreen({super.key});

  @override
  State<TransferenciaScreen> createState() => _TransferenciaScreenState();
}

class _TransferenciaScreenState extends State<TransferenciaScreen> {
  final valorController = TextEditingController();
  final descricaoController = TextEditingController();
  final DatabaseHelper db = DatabaseHelper();
  double saldoAtual = 0.0;

  @override
  void initState() {
    super.initState();
    _carregarSaldo();
  }

  Future<void> _carregarSaldo() async {
    final s = await db.getSaldo();
    setState(() {
      saldoAtual = s;
    });
  }

  Future<void> salvarTransferencia(String destinatario) async {
    final valor = double.tryParse(
      valorController.text.replaceAll(',', '.'),
    );

    if (valor == null || valor <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite um valor válido')),
      );
      return;
    }

    if (valor > saldoAtual) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Saldo insuficiente para esta operação!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final String descricao = descricaoController.text.trim().isEmpty 
        ? 'Transferência Pix' 
        : descricaoController.text;
    final String dataAtual = DateTime.now().toString().substring(0, 19);

    // Dados que serão salvos no banco
    final Map<String, dynamic> dadosTransacao = {
      'valor': valor,
      'destinatario': destinatario,
      'data': dataAtual,
      'tipo': descricao,
    };

    // 1. Insere no banco SQLite (com tratamento de erro para não travar no Windows)
    try {
      await db.insertTransferencia(dadosTransacao).timeout(const Duration(seconds: 1));
      await db.updateSaldo(saldoAtual - valor).timeout(const Duration(seconds: 1));
    } catch (e) {
      print("ERRO AO SALVAR NO BANCO: $e. Prosseguindo em memória...");
      // Fallback: se o banco falhar, atualizamos apenas a variável local para o comprovante
      db.updateSaldo(saldoAtual - valor); // Isso atualiza a variável estática de memória
    }

    if (!mounted) return;

    // Redireciona substituindo a tela atual para o Comprovante
    Navigator.pushReplacementNamed(
      context,
      '/comprovante',
      arguments: dadosTransacao,
    );
    }
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String idUsuario = args?['idUsuario'] ?? 'Usuário';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transferência',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 32,
                        backgroundColor: Color.fromARGB(255, 255, 62, 126),
                        child: Icon(Icons.person, size: 32, color: Colors.white),
                      ),
                      const SizedBox(width: 18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Destinatário',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            idUsuario,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                const Text(
                  'Valor da transferência',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                CustomInput(
                  hint: 'R\$ 0,00',
                  icon: Icons.attach_money,
                  controller: valorController,
                ),
                const SizedBox(height: 25),
                const Text(
                  'Descrição',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                CustomInput(
                  hint: 'Ex: pagamento, presente...',
                  icon: Icons.description,
                  controller: descricaoController,
                ),
                const SizedBox(height: 35),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Saldo disponível'),
                          Text(
                            'R\$ ${saldoAtual.toStringAsFixed(2).replaceAll('.', ',')}',
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Taxa'),
                          Text(
                            'Grátis',
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                CustomButton(
                  text: 'Confirmar Transferência',
                  onPressed: () => salvarTransferencia(idUsuario),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}