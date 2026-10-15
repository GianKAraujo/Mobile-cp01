import 'package:flutter/material.dart';

import 'screens/home_page.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const BibliotecaApp());
}

class BibliotecaApp extends StatelessWidget {
  const BibliotecaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biblioteca FIAP',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.tema,
      home: const HomePage(),
    );
  }
}
