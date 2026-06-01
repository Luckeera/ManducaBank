import 'package:flutter/material.dart';
import '../views/login_screen.dart';
import '../views/principal_screen.dart';
import '../views/cotacao_screen.dart';
import '../views/transferencia_screen.dart';
import '../views/perfil_screen.dart'; // 🛠️ ADICIONADO: Import da nova tela de perfil
import '../views/em_construcao_screen.dart'; // 🛠️ ADICIONADO: Import para Cartões/Investimentos se precisar
import '../views/historico_screen.dart'; // 🛠️ ADICIONADO: Import da tela de histórico

class AppRoutes {
  // Definição dos nomes das rotas
  static const String login = '/login';
  static const String principal = '/principal';
  static const String cotacao = '/cotacao';
  static const String transferencia = '/transferencia';
  static const String perfil = '/perfil'; // 🛠️ ADICIONADO: Constante da rota de perfil
  static const String construcao = '/construcao'; // 🛠️ ADICIONADO: Constante da rota de construção
  static const String historico = '/historico'; // 🛠️ ADICIONADO: Constante da rota de histórico

  // Mapa de rotas para o MaterialApp
  static Map<String, WidgetBuilder> get routes => {
        login: (context) => LoginScreen(),
        principal: (context) => const PrincipalScreen(),
        cotacao: (context) => const CotacaoScreen(),
        transferencia: (context) => const TransferenciaScreen(),
        perfil: (context) => const PerfilScreen(), // 🛠️ ADICIONADO: Linha da rota de perfil adaptada!
        construcao: (context) => const EmConstrucaoScreen(), // 🛠️ ADICIONADO: Mantendo o alinhamento do app
        historico: (context) => const HistoricoScreen(), // 🛠️ ADICIONADO: Linha da rota de histórico
      };
}