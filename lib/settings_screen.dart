import 'package:flutter/material.dart';
import 'package:trip_wallet/preferencias_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final PreferencesManager _preferencesManager = PreferencesManager();
  double cotacaoUS = 4.80;
  double cotacaoCAD = 3.60;
  double taxaUS = 7.00;
  double taxaCAD = 15.00;
  double iof = 5.38;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    setState(() {});
  }

  Future<void> _loadPreferences() async {
    final preferences = await _preferencesManager.loadPreferences();
    setState(() {
      cotacaoUS = preferences['cotacaoUS'] ?? cotacaoUS;
      cotacaoCAD = preferences['cotacaoCAD'] ?? cotacaoCAD;
      taxaUS = preferences['taxaUS'] ?? taxaUS;
      taxaCAD = preferences['taxaCAD'] ?? taxaCAD;
      iof = preferences['iof'] ?? iof;
      isLoading = false;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Valores'),
      ),
      body: isLoading // Show loading indicator if preferences are still loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildListTile(
                    'Cotação US\$',
                    'US\$ ${cotacaoUS.toStringAsFixed(2)}',
                    () => openEditDialog(
                      context: context,
                      initialValue: cotacaoUS,
                      key: PreferencesManager.cotacaoUSKey,
                      title: 'Cotação do dólar americano',
                      onSave: (value) => cotacaoUS = value,
                    ),
                  ),
                  _buildListTile(
                    'Cotação CAD\$',
                    'CAD\$ ${cotacaoCAD.toStringAsFixed(2)}',
                    () => openEditDialog(
                      context: context,
                      initialValue: cotacaoCAD,
                      key: PreferencesManager.cotacaoCADKey,
                      title: 'Cotação do dólar canadense',
                      onSave: (value) => cotacaoCAD = value,
                    ),
                  ),
                  _buildListTile(
                    'Taxa de compra US',
                    '${taxaUS.toStringAsFixed(2)}%',
                    () => openEditDialog(
                      context: context,
                      initialValue: taxaUS,
                      key: PreferencesManager.taxaUSKey,
                      title: 'Taxa de compra US',
                      onSave: (value) => taxaUS = value,
                    ),
                  ),
                  _buildListTile(
                    'Taxa de compra CAD',
                    '${taxaCAD.toStringAsFixed(2)}%',
                    () => openEditDialog(
                      context: context,
                      initialValue: taxaCAD,
                      key: PreferencesManager.taxaCADKey,
                      title: 'Taxa de compra CAD',
                      onSave: (value) => taxaCAD = value,
                    ),
                  ),
                  _buildListTile(
                    'IOF',
                    '${iof.toStringAsFixed(2)}%',
                    () => openEditDialog(
                      context: context,
                      initialValue: iof,
                      title: 'IOF',
                      key: PreferencesManager.iofKey,
                      onSave: (value) => iof = value,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  ListTile _buildListTile(String title, String value, VoidCallback onTap) {
    return ListTile(
      tileColor: Colors.white,
      onTap: onTap,
      leading: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      title: Text(
        value,
        style:
            Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.blue),
        textAlign: TextAlign.end,
      ),
    );
  }

  void openEditDialog(
      {required BuildContext context,
      required double initialValue,
      required String title,
      required String key,
      required Function(double) onSave}) {
    TextEditingController controller =
        TextEditingController(text: initialValue.toStringAsFixed(2));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                border: OutlineInputBorder(),
              ),
              controller: controller, // Use the TextEditingController
              keyboardType: TextInputType.number,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                double newValue = double.tryParse(controller.text) ?? 0;
                onSave(newValue);
                await _preferencesManager.savePreference(key, newValue);
                Navigator.of(context).pop();
                setState(() {});
              },
              child: const Text("Confirmar"),
            ),
          ],
        );
      },
    );
  }
}
