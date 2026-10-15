import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';
import '../utils/formatadores.dart';

/// Função recebida da HomePage. Retorna uma mensagem de erro ou null se
/// o cadastro deu certo.
typedef CadastrarCallback = String? Function(String nome, String identificacao);

class CadastroPage extends StatefulWidget {
  final CadastrarCallback onCadastrar;

  const CadastroPage({super.key, required this.onCadastrar});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  DateTime _agora = DateTime.now();
  late final Timer _relogio;

  @override
  void initState() {
    super.initState();
    _relogio = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _agora = DateTime.now());
    });
  }

  @override
  void dispose() {
    _relogio.cancel();
    _nomeController.dispose();
    _idController.dispose();
    super.dispose();
  }

  void _salvar() {
    final nome = _nomeController.text.trim();
    final id = _idController.text.trim();
    final messenger = ScaffoldMessenger.of(context);

    // Regra 3: campos obrigatórios
    if (nome.isEmpty || id.isEmpty) {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text('Preencha o nome e a identificação!'),
          backgroundColor: AppColors.vermelho,
        ));
      return;
    }

    final erro = widget.onCadastrar(nome, id);
    if (erro != null) {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(erro),
          backgroundColor: AppColors.vermelho,
        ));
      return;
    }

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(
        content: Text('Pessoa cadastrada com sucesso!'),
        backgroundColor: AppColors.verde,
      ));
    Navigator.of(context).pop();
  }

  InputDecoration _decoracao(String label, IconData icone) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icone, color: AppColors.roxo),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.roxo, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova entrada')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Icon(Icons.auto_stories, size: 72, color: AppColors.roxo),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Registrar leitor',
                  style: GoogleFonts.merriweather(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.roxoEscuro,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _nomeController,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: _decoracao('Nome', Icons.person_outline),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _idController,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _salvar(),
                decoration: _decoracao('Identificação / RM', Icons.badge_outlined),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.schedule, color: AppColors.cinzaTexto, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Data e hora do cadastro: ${Formatadores.dataHora(_agora)}',
                    style: GoogleFonts.lato(color: AppColors.cinzaTexto),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              FilledButton.icon(
                onPressed: _salvar,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.roxo,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.login),
                label: Text(
                  'Registrar entrada',
                  style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
