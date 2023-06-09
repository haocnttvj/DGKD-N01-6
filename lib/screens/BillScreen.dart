import 'package:flutter/material.dart';
import '../constant/constant.dart';

class BillScreen extends StatefulWidget {
  @override
  _BillScreenState createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  TextEditingController _billController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _totalBill = 0.0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill Calculator'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _billController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter bill amount',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Add Bill'),
              onPressed: () {
                setState(() {
                  _totalBill += double.parse(_billController.text);
                  _billController.clear();
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Total Bill: $_totalBill',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
