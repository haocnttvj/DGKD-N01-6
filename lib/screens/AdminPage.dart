// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import '../read_data//get_users_name.dart';
import 'signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  late Stream<QuerySnapshot> _userStream;

  @override
  void initState() {
    super.initState();
    _userStream = FirebaseFirestore.instance.collection('users').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.email!,
          style: TextStyle(fontSize: 16),
        ),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: _userStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            final data = snapshot.data!.docs;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: GetUserName(documentID: data[index].id),
                    tileColor: Colors.grey[200],
                    trailing: TextButton(
                      onPressed: sendEmail,
                      child: Text('Send Email'),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void sendEmail() async {
    final smtpServer = gmail('username', 'password');

    final message = Message()
      ..from = Address('your_email_address@example.com')
      ..recipients.add('recipient1@example.com')
      ..ccRecipients
          .addAll(['recipient2@example.com', 'recipient3@example.com'])
      ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Test Email'
      ..text =
          'This is a test email sent from Flutter using the mailer package.';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. Error: $e');
    }
  }
}
