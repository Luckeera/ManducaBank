import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'views/login_screen.dart';
import 'views/principal_screen.dart';
import 'views/cotacao_screen.dart';
import 'views/transferencia_screen.dart';

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
        '/': (context) => const LoginScreen(),
        '/principal': (context) => const PrincipalScreen(),
        '/cotacao': (context) => const CotacaoScreen(),
        '/transferencia': (context) => const TransferenciaScreen(),
      },
    );
  }
}
