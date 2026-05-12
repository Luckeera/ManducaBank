import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const ManducaBankApp());
}

class ManducaBankApp extends StatelessWidget {
  const ManducaBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ManducaBank',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // Rota inicial do aplicativo
      initialRoute: AppRoutes.login,
      // Configuração das rotas nomeadas
      routes: AppRoutes.routes,
    );
  }
}
