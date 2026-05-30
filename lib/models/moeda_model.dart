class MoedaModel {
  final String code;
  final String codein;
  final String name;
  final double bid;
  final double ask;
  final double pctChange;

  MoedaModel({
    required this.code,
    required this.codein,
    required this.name,
    required this.bid,
    required this.ask,
    required this.pctChange,
  });

  // Factory para converter JSON em instância da classe
  factory MoedaModel.fromJson(Map<String, dynamic> json) {
    return MoedaModel(
      code: json['code'] ?? '',
      codein: json['codein'] ?? '',
      name: json['name'] ?? '',
      // Convertendo strings da API para double
      bid: double.tryParse(json['bid'].toString()) ?? 0.0,
      ask: double.tryParse(json['ask'].toString()) ?? 0.0,
      pctChange: double.tryParse(json['pctChange'].toString()) ?? 0.0,
    );
  }

  // Método auxiliar para facilitar exibição ou depuração
  @override
  String toString() {
    return 'MoedaModel(code: $code, name: $name, bid: $bid)';
  }
}
