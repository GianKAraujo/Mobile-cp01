import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

/// Painel com a lotação atual (mantém os status do Checkpoint 01).
class LotacaoCard extends StatelessWidget {
  final int presentes;
  final int capacidade;

  const LotacaoCard({
    super.key,
    required this.presentes,
    required this.capacidade,
  });

  bool get _lotado => presentes >= capacidade;
  bool get _quaseLotado => presentes >= capacidade * 0.8 && !_lotado;

  String get _status {
    if (_lotado) return 'Biblioteca lotada';
    if (_quaseLotado) return 'Quase lotado';
    return 'Pode entrar';
  }

  Color get _corStatus {
    if (_lotado) return AppColors.vermelho;
    if (_quaseLotado) return AppColors.laranja;
    return AppColors.verde;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage('assets/images/cont_bg.jpeg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Color(0xCC2E0F45), BlendMode.srcOver),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.local_library, color: AppColors.lilas, size: 48),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pessoas no ambiente',
                  style: GoogleFonts.lato(color: Colors.white70, fontSize: 14),
                ),
                Text(
                  '$presentes / $capacidade',
                  style: GoogleFonts.merriweather(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: capacidade == 0 ? 0 : presentes / capacidade,
                    minHeight: 8,
                    color: _corStatus,
                    backgroundColor: Colors.white24,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _corStatus,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _status,
              style: GoogleFonts.lato(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
