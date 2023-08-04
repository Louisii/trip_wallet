import 'package:flutter/material.dart';
import 'package:trip_wallet/conversor.dart';
import 'package:trip_wallet/settings_screen.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedMoeda = 'BR\$';

  List<String> moedas = ['BR\$', 'US\$', 'CAD\$'];

  TextEditingController valorController = TextEditingController();

  double valorBR = 0.0;
  double valorUS = 0.0;
  double valorCAD = 0.0;

  @override
  void initState() {
    super.initState();
    valorController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.blue,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 8.0),
              Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedMoeda,
                          items: moedas.map((String moeda) {
                            return DropdownMenuItem<String>(
                              value: moeda,
                              child: Text(moeda),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedMoeda = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      controller: valorController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Digite o valor que deseja calcular',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        double valorDeEntrada =
                            double.tryParse(valorController.text) ?? 0.0;
                        Conversor converter =
                            Conversor(selectedMoeda, valorDeEntrada);
                        converter
                            .converter()
                            .then((Map<String, double> valoresConvertidos) {
                          setState(() {
                            valorBR = valoresConvertidos['BR\$']!;
                            valorUS = valoresConvertidos['US\$']!;
                            valorCAD = valoresConvertidos['CAD\$']!;
                          });
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text(
                          'Calcular',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                  // Exibindo os valores nas três moedas
                ],
              ),
              const SizedBox(height: 28.0),
              Text(
                '\u{1F1E7}\u{1F1F7}  R\$${valorBR.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                '\u{1F1FA}\u{1F1F8}  US\$${valorUS.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                '\u{1F1E8}\u{1F1E6}  CAD\$${valorCAD.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
