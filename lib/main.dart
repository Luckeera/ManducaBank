import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'views/login_screen.dart';
import 'views/principal_screen.dart';
import 'views/cotacao_screen.dart';
import 'views/transferencia_screen.dart';
import 'views/qr_code.dart';
import 'views/comprovante_screen.dart';
import 'views/em_construcao_screen.dart'; // 🛠️ Import da tela de aviso
import 'views/perfil_screen.dart';       // 🛠️ Import da tela de perfil

void main() {
  runApp(const ManducaBankApp());
}

class ManducaBankApp extends StatelessWidget {
  const ManducaBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ManducaBank',
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/principal': (context) => const PrincipalScreen(),
        '/cotacao': (context) => const CotacaoScreen(),
        '/transferencia': (context) => const TransferenciaScreen(),
        '/qr': (context) => const QRPage(),
        '/comprovante': (context) => const ComprovanteScreen(),
        '/construcao': (context) => const EmConstrucaoScreen(), // 🛠️ Rota de construção
        '/perfil': (context) => const PerfilScreen(),             // 🛠️ Rota de perfil adicionada!
      },
    );
  }
}