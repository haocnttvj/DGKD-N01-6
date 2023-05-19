// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import '../read_data//get_users_name.dart';
// import '../read_data/email_sender.dart';
import 'HomeScreen.dart';
import '../read_data/send_email.dart';
import 'signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
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
            child: Icon(Icons.oil_barrel),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            userName: "${user.email}",
                            userImageUrl:
                                "https://i.ytimg.com/vi/1l_YadQTg5Q/maxresdefault.jpg",
                          )));
            },
            icon: Icon(
              // <-- Icon
              Icons.logout,
              size: 24.0,
            ),
            label: Text('Exit'),

            // <-- Text
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
                      onPressed: () => sendEmail(data[index].get('email')),
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
}
