/// Representa uma pessoa que entrou na biblioteca.
class Pessoa {
  final String nome;
  final String identificacao;
  final DateTime dataEntrada;
  DateTime? _dataSaida;

  Pessoa({
    required this.nome,
    required this.identificacao,
    DateTime? dataEntrada,
  }) : dataEntrada = dataEntrada ?? DateTime.now();

  DateTime? get dataSaida => _dataSaida;

  bool get estaNoAmbiente => _dataSaida == null;

  String get situacao => estaNoAmbiente ? 'No ambiente' : 'Saiu';

  /// Regra 2: quem já saiu não pode ter a saída registrada de novo.
  /// Retorna false se a saída já tinha sido registrada.
  bool registrarSaida([DateTime? momento]) {
    if (!estaNoAmbiente) return false;
    _dataSaida = momento ?? DateTime.now();
    return true;
  }
}
