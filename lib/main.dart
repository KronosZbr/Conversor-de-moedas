import 'package:flutter/material.dart';

void main() {
  runApp(MinhaApp());
}

class MinhaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de Moedas',
      home: TelaConversorMoeda(),
    );
  }
}

class TelaConversorMoeda extends StatefulWidget {
  @override
  _TelaConversorMoedaState createState() => _TelaConversorMoedaState();
}

class _TelaConversorMoedaState extends State<TelaConversorMoeda> {
  double _valorEntrada = 0.0;
  String _moedaOrigem = 'USD';
  String _moedaDestino = 'BRL';
  double _valorConvertido = 0.0;

  final Map<String, double> _taxasCambio = {
    'USD': 1.0, // Dólar
    'BRL': 5.41, // Real Brasileiro
    'EUR': 0.85, // Euro
    'GBP': 0.75, // Libra Esterlina
  };

  void _converterMoeda() {
    setState(() {
      double taxaOrigem = _taxasCambio[_moedaOrigem]!;
      double taxaDestino = _taxasCambio[_moedaDestino]!;
      _valorConvertido = (_valorEntrada / taxaOrigem) * taxaDestino;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversor de Moedas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Valor a ser convertido',
                border: OutlineInputBorder(),
              ),
              onChanged: (valor) {
                setState(() {
                  _valorEntrada = double.tryParse(valor) ?? 0.0;
                  _converterMoeda();
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _moedaOrigem,
                    decoration: InputDecoration(
                      labelText: 'De',
                      border: OutlineInputBorder(),
                    ),
                    items: _taxasCambio.keys
                        .map((String moeda) => DropdownMenuItem<String>(
                              value: moeda,
                              child: Text(moeda),
                            ))
                        .toList(),
                    onChanged: (valor) {
                      setState(() {
                        _moedaOrigem = valor!;
                        _converterMoeda();
                      });
                    },
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _moedaDestino,
                    decoration: InputDecoration(
                      labelText: 'Para',
                      border: OutlineInputBorder(),
                    ),
                    items: _taxasCambio.keys
                        .map((String moeda) => DropdownMenuItem<String>(
                              value: moeda,
                              child: Text(moeda),
                            ))
                        .toList(),
                    onChanged: (valor) {
                      setState(() {
                        _moedaDestino = valor!;
                        _converterMoeda();
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Text(
              _valorEntrada == 0.0
                  ? 'Insira um valor para converter'
                  : '$_valorEntrada $_moedaOrigem = ${_valorConvertido.toStringAsFixed(2)} $_moedaDestino',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
