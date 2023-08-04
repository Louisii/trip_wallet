import 'package:trip_wallet/preferencias_manager.dart';

class Conversor {
  String moedaDeEntrada;
  double valorDeEntrada;

  Conversor(this.moedaDeEntrada, this.valorDeEntrada);

  double valorBR = 0.0;
  double valorUS = 0.0;
  double valorCAD = 0.0;

  double cotacaoUS = 0;
  double cotacaoCAD = 0;
  double taxaUS = 0;
  double taxaCAD = 0;
  double iof = 0;

  final PreferencesManager _preferencesManager = PreferencesManager();

  Future<void> _loadPreferences() async {
    final preferences = await _preferencesManager.loadPreferences();

    cotacaoUS = preferences['cotacaoUS'] ?? cotacaoUS;
    cotacaoCAD = preferences['cotacaoCAD'] ?? cotacaoCAD;
    taxaUS = preferences['taxaUS'] ?? taxaUS;
    taxaCAD = preferences['taxaCAD'] ?? taxaCAD;
    iof = preferences['iof'] ?? iof;
  }

  Future<Map<String, double>> converter() async {
    await _loadPreferences();

    switch (moedaDeEntrada) {
      case 'BR\$':
        {
          valorBR = valorDeEntrada;
          valorUS = valorDeEntrada / cotacaoUS;
          valorCAD = valorDeEntrada / cotacaoCAD;
        }
        break;
      case 'US\$':
        {
          valorBR =
              (valorDeEntrada * cotacaoUS) * (1 + taxaUS / 100) * (1 + iof / 100);
          valorUS = valorDeEntrada;
          valorCAD = valorDeEntrada * cotacaoUS / cotacaoCAD;
        }
        break;
      case 'CAD\$':
        {
          valorBR =
              (valorDeEntrada * cotacaoCAD) * (1 + taxaCAD / 100) * (1 + iof / 100);
          valorCAD = valorDeEntrada;
          valorUS = valorDeEntrada * cotacaoCAD / cotacaoUS;
        }
        break;
    }

    final valores = {
      'BR\$': valorBR,
      'US\$': valorUS,
      'CAD\$': valorCAD,
    };

    return valores;
  }
}
