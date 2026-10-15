import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_cont_fiap/models/pessoa.dart';

void main() {
  test('Pessoa começa no ambiente', () {
    final p = Pessoa(nome: 'Maria', identificacao: '123');
    expect(p.estaNoAmbiente, isTrue);
    expect(p.situacao, 'No ambiente');
  });

  test('Saída não pode ser registrada duas vezes', () {
    final p = Pessoa(nome: 'Maria', identificacao: '123');
    expect(p.registrarSaida(), isTrue);
    expect(p.situacao, 'Saiu');
    expect(p.registrarSaida(), isFalse);
  });
}
