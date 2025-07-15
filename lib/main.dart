import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TipCalculator(),
    );
  }
}

class TipCalculator extends StatefulWidget {
  const TipCalculator({super.key});

  @override
  State<TipCalculator> createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  final TextEditingController _billAmountController = TextEditingController();
  double _tipPercentage = 15.0;
  double _tipAmount = 0.0;
  double _totalAmount = 0.0;

  void _calculateTip() {
    setState(() {
      final double billAmount = double.tryParse(_billAmountController.text) ?? 0.0;
      _tipAmount = billAmount * (_tipPercentage / 100);
      _totalAmount = billAmount + _tipAmount;
    });
  }

  @override
  void dispose() {
    _billAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Tip Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _billAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Bill Amount',
                border: OutlineInputBorder(),
                prefixText: '\$',
              ),
              onChanged: (value) => _calculateTip(),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                const Text('Tip Percentage:'),
                Expanded(
                  child: Slider(
                    value: _tipPercentage,
                    min: 0,
                    max: 100,
                    divisions: 20,
                    label: '${_tipPercentage.round()}%',
                    onChanged: (double value) {
                      setState(() {
                        _tipPercentage = value;
                        _calculateTip();
                      });
                    },
                  ),
                ),
                Text('${_tipPercentage.round()}%'),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Tip Amount: \$${_tipAmount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text(
              'Total Amount: \$${_totalAmount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
