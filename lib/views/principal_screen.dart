import 'package:flutter/material.dart';
import '../widgets/balance_card.dart';
import '../widgets/action_card.dart';

class PrincipalScreen extends StatelessWidget {
  const PrincipalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String nomeUsuario = 'Cliente';

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
                  'Olá, $nomeUsuario 👋',
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
                SizedBox(
                  height: 490,
                  child: GridView.count(
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
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/transferencia',
                            arguments: {
                              'idUsuario': '12345',
                              'valorInicial': 100.0,
                            },
                          );
                        },
                      ),
                      ActionCard(
                        icon: Icons.credit_card,
                        title: 'Cartões',
                        onTap: () {},
                      ),
                      ActionCard(
                        icon: Icons.pie_chart,
                        title: 'Investimentos',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Últimas movimentações',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildTransaction(
                  icon: Icons.shopping_cart,
                  title: 'Mercado',
                  value: '- R\$ 120,00',
                  color: Colors.red,
                ),
                _buildTransaction(
                  icon: Icons.pix,
                  title: 'Pix Recebido',
                  value: '+ R\$ 850,00',
                  color: Colors.green,
                ),
                _buildTransaction(
                  icon: Icons.movie,
                  title: 'Netflix',
                  value: '- R\$ 39,90',
                  color: Colors.red,
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
  }) {
    return Container(
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
    );
  }
}
