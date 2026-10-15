import 'package:intl/intl.dart';

/// Formatação de datas com o pacote intl.
class Formatadores {
  Formatadores._();

  static final DateFormat _dataHora = DateFormat("dd/MM/yyyy 'às' HH:mm");

  /// Ex.: 30/09/2026 às 19:35
  static String dataHora(DateTime data) => _dataHora.format(data);
}
