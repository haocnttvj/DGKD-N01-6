import 'package:billpay1/screens/BillPaymentScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ElectricityBillCalculator extends StatefulWidget {
  @override
  _ElectricityBillCalculatorState createState() =>
      _ElectricityBillCalculatorState();
}

class _ElectricityBillCalculatorState extends State<ElectricityBillCalculator> {
  final TextEditingController _usageController = TextEditingController();
  double _usage = 0;
  double _billAmount = 0;
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bill Calculation'),
          content:
              Text('Your bill amount is ${_billAmount.toStringAsFixed(2)} VND'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Electricity Bill Calculator'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _usageController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
              decoration: InputDecoration(
                labelText: 'Monthly Usage (kWh)',
                helperText: _usageController.text.isEmpty
                    ? 'Please enter only numbers'
                    : '',
                helperStyle: TextStyle(color: Colors.red),
              ),
              onChanged: (value) {
                setState(() {
                  _usage = double.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Bill Amount: \ ${_billAmount.toStringAsFixed(2)}\VND',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              child: Text('Calculate Bill'),
              onPressed: () {
                setState(() {
                  _billAmount = _calculateBillAmount(_usage);
                });
                _showDialog(
                    context); // Call the function to show the dialog box
              },
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          BillPaymentScreen(billAmount: 200))),
              icon: Icon(
                // <-- Icon
                Icons.contact_mail,
                size: 24.0,
              ),
              label: Text('Pay'), // <-- Text
            ),
          ],
        ),
      ),
    );
  }

  double _calculateBillAmount(double usage) {
    if (usage <= 200) {
      return usage * 3500;
    } else if (usage <= 300) {
      return 200 * 3500 + (usage - 200) * 4000;
    } else if (usage <= 500) {
      return 200 * 3500 + 100 * 4000 + (usage - 300) * 4500;
    } else {
      return 200 * 3500 + 100 * 4000 + 200 * 4500 + (usage - 500) * 5000;
    }
  }
}
