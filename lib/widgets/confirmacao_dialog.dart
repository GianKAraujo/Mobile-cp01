import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

/// Mostra um AlertDialog de confirmação. Retorna true se o usuário confirmar.
Future<bool> mostrarConfirmacao(
  BuildContext context, {
  required String titulo,
  required String mensagem,
  required IconData icone,
  String textoConfirmar = 'CONFIRMAR',
}) async {
  final resultado = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      icon: Icon(icone, color: AppColors.roxo, size: 36),
      title: Text(titulo),
      content: Text(mensagem),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('CANCELAR'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: FilledButton.styleFrom(backgroundColor: AppColors.roxo),
          child: Text(textoConfirmar),
        ),
      ],
    ),
  );
  return resultado ?? false;
}
