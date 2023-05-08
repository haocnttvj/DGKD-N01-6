import 'package:flutter/material.dart';

class BillScreen extends StatelessWidget {
  final List<String> items;
  final List<double> prices;
  final List<int> quantities;

  const BillScreen({Key? key, required this.items, required this.prices, required this.quantities}) : super(key: key);

  double get totalBill {
    double total = 0.0;
    for (int i = 0; i < items.length; i++) {
      total += prices[i] * quantities[i];
    }
    return total;
  }

  double get tipAmount {
    return totalBill * 0.15;
  }

  double get grandTotal {
    return totalBill + tipAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Total Bill: \$${totalBill.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Tip Amount (15%): \$${tipAmount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Grand Total: \$${grandTotal.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 32.0),
          ElevatedButton(
            child: Text('Pay Now'),
            onPressed: () {
              // TODO: implement payment functionality
            },
          ),
        ],
      ),
    );
  }
}