import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/pessoa.dart';
import '../utils/app_colors.dart';
import '../utils/formatadores.dart';

/// Item da lista: recebe o objeto [pessoa] e as funções [onSaida] e
/// [onExcluir], que avisam o widget pai (HomePage) sobre a ação do usuário.
class PessoaItem extends StatelessWidget {
  final Pessoa pessoa;
  final VoidCallback onSaida;
  final VoidCallback onExcluir;

  const PessoaItem({
    super.key,
    required this.pessoa,
    required this.onSaida,
    required this.onExcluir,
  });

  @override
  Widget build(BuildContext context) {
    final presente = pessoa.estaNoAmbiente;
    final corSituacao = presente ? AppColors.verde : AppColors.cinzaSaiu;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          key: ObjectKey(pessoa),
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            extentRatio: 0.5,
            children: [
              SlidableAction(
                onPressed: (_) => onSaida(),
                backgroundColor: AppColors.laranja,
                foregroundColor: Colors.white,
                icon: Icons.logout,
                label: 'SAÍDA',
              ),
              SlidableAction(
                onPressed: (_) => onExcluir(),
                backgroundColor: AppColors.vermelho,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'EXCLUIR',
              ),
            ],
          ),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor:
                      presente ? AppColors.lilas : const Color(0xFFE0E0E0),
                  child: Icon(
                    presente ? Icons.menu_book : Icons.book_outlined,
                    color: presente ? AppColors.roxoEscuro : AppColors.cinzaSaiu,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pessoa.nome,
                        style: GoogleFonts.merriweather(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.tinta,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      _linha(Icons.badge_outlined, 'ID: ${pessoa.identificacao}'),
                      _linha(Icons.login,
                          'Entrada: ${Formatadores.dataHora(pessoa.dataEntrada)}'),
                      if (pessoa.dataSaida != null)
                        _linha(Icons.logout,
                            'Saída: ${Formatadores.dataHora(pessoa.dataSaida!)}'),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.circle, size: 10, color: corSituacao),
                          const SizedBox(width: 6),
                          Text(
                            'Situação: ${pessoa.situacao}',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w700,
                              color: corSituacao,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (presente)
                  IconButton(
                    tooltip: 'Registrar saída',
                    onPressed: onSaida,
                    icon: const Icon(Icons.logout, color: AppColors.roxo),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _linha(IconData icone, String texto) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        children: [
          Icon(icone, size: 14, color: AppColors.cinzaTexto),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              texto,
              style: GoogleFonts.lato(fontSize: 13, color: AppColors.cinzaTexto),
            ),
          ),
        ],
      ),
    );
  }
}
