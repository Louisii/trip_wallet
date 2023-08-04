import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static const cotacaoUSKey = 'cotacaoUS';
  static const cotacaoCADKey = 'cotacaoCAD';
  static const taxaUSKey = 'taxaUS';
  static const taxaCADKey = 'taxaCAD';
  static const iofKey = 'iof';

  Future<void> savePreference(String key, double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
  }

  Future<Map<String, double>> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      cotacaoUSKey: prefs.getDouble(cotacaoUSKey) ?? 4.86,
      cotacaoCADKey: prefs.getDouble(cotacaoCADKey) ?? 3.64,
      taxaUSKey: prefs.getDouble(taxaUSKey) ?? 7.00,
      taxaCADKey: prefs.getDouble(taxaCADKey) ?? 13.00,
      iofKey: prefs.getDouble(iofKey) ?? 5.38,
    };
  }
}
