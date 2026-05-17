import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/moeda_model.dart';

class ApiService {
  // Endpoint da AwesomeAPI para cotações em tempo real
  static const String _baseUrl =
      'https://economia.awesomeapi.com.br/json/last/USD-BRL,EUR-BRL,BTC-BRL';

  // Função para buscar as cotações
  Future<List<MoedaModel>> fetchCotacoes() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // A API retorna um objeto onde cada chave é o par de moedas (ex: USDBRL)
        return data.values.map((json) => MoedaModel.fromJson(json)).toList();
      } else {
        throw Exception(
            'Falha ao carregar cotações: Status ${response.statusCode}');
      }
    } catch (e) {
      // Tratamento básico de erro
      throw Exception('Erro na requisição: $e');
    }
  }
}
