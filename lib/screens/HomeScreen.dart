import 'package:billpay1/screens/AdminPage.dart';
import 'package:billpay1/screens/show_result.dart';
import 'package:flutter/material.dart';

import '../reusable_widgets/reusable_widget.dart';

class HomeScreen extends StatefulWidget {
  late final String userName;
  late final String userImageUrl;

  HomeScreen({required this.userName, required this.userImageUrl});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double billAmount = 0.0;
  double tipPercentage = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Tính tiền điện'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.userImageUrl),
            radius: 50,
          ),
          SizedBox(height: 20),
          Text(
            'Welcome, ${widget.userName}!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          SizedBox(height: 10),
          SizedBox(height: 20),
          SizedBox(height: 10),
          TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                tipPercentage = double.tryParse(value) ?? 0.0;
              });
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ElectricityBillCalculator())),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                fixedSize: const Size(300, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            child: const Text('Electric Bill and Pay'),
          ),
          SizedBox(height: 10),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => AdminPage())),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                fixedSize: const Size(300, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            child: const Text('Admin'),
          ),
        ],
      ),
    );
  }
}
