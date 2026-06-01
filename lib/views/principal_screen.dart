import 'package:flutter/material.dart';
import '../widgets/balance_card.dart';
import '../widgets/action_card.dart';
import '../database/database_helper.dart';

class PrincipalScreen extends StatelessWidget {
  const PrincipalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🛠️ MODIFICADO: Captura o nome enviado pela login_screen através dos argumentos de rota
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    final String nomeUsuario = args is String ? args : 'Cliente';
    final DatabaseHelper db = DatabaseHelper();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ManducaBank',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              right: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(14),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1A1A1A),
        selectedItemColor: const Color.fromARGB(255, 255, 62, 126),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        onTap: (index) async {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.pushNamed(context, '/cotacao');
              break;
            case 2:
              await Navigator.pushNamed(
                context,
                '/transferencia',
                arguments: {
                  'idUsuario': '12345',
                },
              );
              // Força a atualização da Home ao voltar da transferência
              (context as Element).markNeedsBuild();
              break;
            case 3:
              Navigator.pushNamed(
                context,
                '/perfil',
                arguments:
                    nomeUsuario, // 👈 ADICIONADO: Passa o nome para a tela de perfil
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Cotação',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send),
            label: 'Transferir',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Olá, $nomeUsuario 👋', // 👈 AJUSTADO: Agora mostra o nome dinâmico
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Bem-vindo de volta',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 30),
                const BalanceCard(),
                const SizedBox(height: 35),
                const Text(
                  'Ações rápidas',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1,
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    ActionCard(
                      icon: Icons.attach_money,
                      title: 'Cotações',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/cotacao',
                        );
                      },
                    ),
                    ActionCard(
                      icon: Icons.send,
                      title: 'Transferência',
                      onTap: () async {
                        await Navigator.pushNamed(
                          context,
                          '/transferencia',
                          arguments: {
                            'idUsuario': '12345',
                          },
                        );
                        // Força a atualização da Home ao voltar da transferência pelo Grid também
                        (context as Element).markNeedsBuild();
                      },
                    ),
                    ActionCard(
                      icon: Icons.qr_code_scanner,
                      title: 'QR Code',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/qr',
                        );
                      },
                    ),
                    ActionCard(
                      icon: Icons.receipt_long,
                      title: 'Comprovantes',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/historico', // 🛠️ AJUSTADO: Agora vai para o histórico
                        );
                      },
                    ),
                    ActionCard(
                      icon: Icons.credit_card,
                      title: 'Cartões',
                      onTap: () {
                        Navigator.pushNamed(context, '/construcao',
                            arguments: 'Cartões');
                      },
                    ),
                    ActionCard(
                      icon: Icons.pie_chart,
                      title: 'Investimentos',
                      onTap: () {
                        Navigator.pushNamed(context, '/construcao',
                            arguments: 'Investimentos');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'Últimas movimentações',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: db.getTransferencias(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'Nenhuma movimentação recente.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    final transactions = snapshot.data!.take(3).toList();

                    return Column(
                      children: transactions.map((trans) {
                        return _buildTransaction(
                          icon: Icons.send,
                          title: trans['destinatario'] ?? 'Transferência',
                          value: '- R\$ ${trans['valor'].toStringAsFixed(2)}',
                          color: Colors.redAccent,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/comprovante',
                              arguments: trans,
                            );
                          },
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildTransaction({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
