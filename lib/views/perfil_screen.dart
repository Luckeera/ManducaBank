import 'package:flutter/material.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🛠️ MODIFICADO: Captura o nome enviado pela principal_screen
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    final String nomeUsuario = args is String ? args : 'Cliente';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meu Perfil',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Avatar do Usuário com as cores do banco
              Center(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 62, 126),
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                        radius: 55,
                        backgroundColor: Color(0xFF1E1E1E),
                        child: Icon(
                          Icons.person,
                          size: 65,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // 🛠️ AJUSTADO: Agora exibe o nome dinâmico do login!
              Text(
                nomeUsuario, 
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              
              const SizedBox(height: 6),
              const Text(
                'Agência: 0001 • Conta: 104832-9',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 30),
              
              // Seção de Opções
              _buildMenuOption(
                icon: Icons.shield_outlined,
                title: 'Segurança e Privacidade',
                subtitle: 'Alterar senha, biometria e chaves',
              ),
              _buildMenuOption(
                icon: Icons.credit_card_outlined,
                title: 'Configurar Cartões',
                subtitle: 'Limites, bloqueio temporário e aviso viagem',
              ),
              _buildMenuOption(
                icon: Icons.notifications_none_outlined,
                title: 'Notificações',
                subtitle: 'Gerenciar alertas do aplicativo',
              ),
              _buildMenuOption(
                icon: Icons.help_outline,
                title: 'Central de Ajuda',
                subtitle: 'Fale conosco e perguntas frequentes',
              ),
              
              const SizedBox(height: 25),
              
              // Botão de Logoff (Sair do App)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                  },
                  icon: const Icon(Icons.logout, color: Colors.redAccent),
                  label: const Text(
                    'Sair da Conta',
                    style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white12),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color.fromARGB(255, 255, 62, 126)),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}