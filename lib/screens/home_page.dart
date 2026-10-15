import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/pessoa.dart';
import '../utils/app_colors.dart';
import '../widgets/confirmacao_dialog.dart';
import '../widgets/lotacao_card.dart';
import '../widgets/pessoa_item.dart';
import 'cadastro_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const int capacidadeMaxima = 50;

  final List<Pessoa> _pessoas = [];

  int get _presentes => _pessoas.where((p) => p.estaNoAmbiente).length;
  bool get _lotado => _presentes >= capacidadeMaxima;

  void _snack(String mensagem, Color cor) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(mensagem), backgroundColor: cor));
  }

  /// Passada para a CadastroPage. Retorna o erro ou null se cadastrou.
  String? _cadastrar(String nome, String identificacao) {
    // Regra 1: capacidade
    if (_lotado) {
      return 'Não é possível realizar a entrada. Ambiente lotado!';
    }
    // Regra 4: mesma identificação não pode estar dentro duas vezes
    final duplicado = _pessoas.any((p) =>
        p.estaNoAmbiente &&
        p.identificacao.toLowerCase() == identificacao.toLowerCase());
    if (duplicado) {
      return 'Já existe uma pessoa no ambiente com a identificação $identificacao!';
    }

    setState(() {
      _pessoas.insert(0, Pessoa(nome: nome, identificacao: identificacao));
    });
    return null;
  }

  void _abrirCadastro() {
    if (_lotado) {
      _snack('Ambiente lotado! Não é possível registrar uma nova entrada.',
          AppColors.vermelho);
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CadastroPage(onCadastrar: _cadastrar),
      ),
    );
  }

  Future<void> _registrarSaida(Pessoa pessoa) async {
    // Regra 2: não registra saída duas vezes
    if (!pessoa.estaNoAmbiente) {
      _snack('${pessoa.nome} já saiu do ambiente!', AppColors.laranja);
      return;
    }

    final confirmou = await mostrarConfirmacao(
      context,
      titulo: 'Registrar saída?',
      mensagem: 'Deseja realmente registrar a saída de ${pessoa.nome}?',
      icone: Icons.logout,
    );
    if (!confirmou || !mounted) return;

    setState(() => pessoa.registrarSaida());
    _snack('Saída registrada com sucesso!', AppColors.verde);
  }

  Future<void> _excluir(Pessoa pessoa) async {
    final confirmou = await mostrarConfirmacao(
      context,
      titulo: 'Excluir registro?',
      mensagem: 'Deseja realmente excluir o registro de ${pessoa.nome}?',
      icone: Icons.delete_outline,
      textoConfirmar: 'EXCLUIR',
    );
    if (!confirmou || !mounted) return;

    setState(() => _pessoas.remove(pessoa));
    _snack('Registro excluído!', AppColors.roxoEscuro);
  }

  Future<void> _limparSaidas() async {
    final quantidade = _pessoas.where((p) => !p.estaNoAmbiente).length;
    if (quantidade == 0) {
      _snack('Não há registros de saída para limpar.', AppColors.roxoEscuro);
      return;
    }

    final confirmou = await mostrarConfirmacao(
      context,
      titulo: 'Limpar registros?',
      mensagem: 'Remover os $quantidade registro(s) de quem já saiu?',
      icone: Icons.cleaning_services_outlined,
      textoConfirmar: 'LIMPAR',
    );
    if (!confirmou || !mounted) return;

    setState(() => _pessoas.removeWhere((p) => !p.estaNoAmbiente));
    _snack('Registros de saída removidos!', AppColors.verde);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biblioteca FIAP'),
        leading: const Icon(Icons.local_library),
        actions: [
          IconButton(
            tooltip: 'Limpar registros de saída',
            onPressed: _limparSaidas,
            icon: const Icon(Icons.cleaning_services_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _abrirCadastro,
        backgroundColor: _lotado ? AppColors.cinzaSaiu : AppColors.roxo,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.person_add_alt_1),
        label: Text(
          'Nova entrada',
          style: GoogleFonts.lato(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LotacaoCard(
                presentes: _presentes,
                capacidade: capacidadeMaxima,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.menu_book, color: AppColors.roxo),
                  const SizedBox(width: 8),
                  Text(
                    'Registro de acessos',
                    style: GoogleFonts.merriweather(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.roxoEscuro,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${_pessoas.length} registro(s)',
                    style: GoogleFonts.lato(color: AppColors.cinzaTexto),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Deslize um item para a esquerda para ver as ações.',
                style: GoogleFonts.lato(fontSize: 12, color: AppColors.cinzaTexto),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _pessoas.isEmpty
                    ? _listaVazia()
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 96),
                        itemCount: _pessoas.length,
                        itemBuilder: (context, index) {
                          final pessoa = _pessoas[index];
                          return PessoaItem(
                            key: ObjectKey(pessoa),
                            pessoa: pessoa,
                            onSaida: () => _registrarSaida(pessoa),
                            onExcluir: () => _excluir(pessoa),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listaVazia() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_stories_outlined, size: 64, color: AppColors.lilas),
          const SizedBox(height: 12),
          Text(
            'Nenhum leitor na biblioteca',
            style: GoogleFonts.merriweather(
              fontSize: 16,
              color: AppColors.roxoEscuro,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Toque em "Nova entrada" para registrar.',
            style: GoogleFonts.lato(color: AppColors.cinzaTexto),
          ),
        ],
      ),
    );
  }
}
