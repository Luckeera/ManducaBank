import 'package:flutter/material.dart';
import '../views/login_screen.dart';
import '../views/principal_screen.dart';
import '../views/cotacao_screen.dart';
import '../views/transferencia_screen.dart';

class AppRoutes {
  // Definição dos nomes das rotas
  static const String login = '/login';
  static const String principal = '/principal';
  static const String cotacao = '/cotacao';
  static const String transferencia = '/transferencia';

  // Mapa de rotas para o MaterialApp
  static Map<String, WidgetBuilder> get routes => {
        login: (context) => const LoginScreen(),
        principal: (context) => const PrincipalScreen(),
        cotacao: (context) => const CotacaoScreen(),
        transferencia: (context) => const TransferenciaScreen(),
      };
}
