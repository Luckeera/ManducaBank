import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/moeda_model.dart';

class CotacaoScreen extends StatefulWidget {
  const CotacaoScreen({super.key});

  @override
  State<CotacaoScreen> createState() => _CotacaoScreenState();
}

class _CotacaoScreenState extends State<CotacaoScreen> {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cotações em Tempo Real'),
      ),
      body: FutureBuilder<List<MoedaModel>>(
        future: _apiService.fetchCotacoes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Exibindo progresso enquanto carrega
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Tratamento de erro na interface
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma cotação disponível.'));
          }

          // Lista de moedas carregada
          final moedas = snapshot.data!;
          return ListView.builder(
            itemCount: moedas.length,
            itemBuilder: (context, index) {
              final moeda = moedas[index];
              return ListTile(
                title: Text('${moeda.name} (${moeda.code})'),
                subtitle: Text('Compra: R\$ ${moeda.bid.toStringAsFixed(2)}'),
                trailing: Text('${moeda.pctChange}%', 
                  style: TextStyle(color: moeda.pctChange >= 0 ? Colors.green : Colors.red),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
