import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'HomeScreen.dart';

class HomeScreeny extends StatelessWidget {
  final List<String> _recentTransactions = [    'May 6, 2023 - Starbucks - \$4.99',    'May 5, 2023 - Uber - \$18.27',    'May 4, 2023 - Amazon - \$99.99',    'May 3, 2023 - Spotify - \$9.99',    'May 2, 2023 - Netflix - \$13.99',  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment App'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _recentTransactions.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(_recentTransactions[index]),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      // Navigate to transaction details screen
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add payment method screen
        },
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          children: [


            UserAccountsDrawerHeader(
              accountName: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Text(snapshot.data!.email!);
                  } else {
                    return Text('Anonymous');
                  }
                },
              ),
              accountEmail: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Text(snapshot.data!.providerData[0].providerId);
                  } else {
                    return Text('');
                  }
                },
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://picsum.photos/200/300',

                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                // Navigate to profile screen
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to settings screen
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help & Feedback'),
              onTap: () {
                // Navigate to help & feedback screen
              },
            ),
            Divider(),
            ElevatedButton.icon(

              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreenz()));
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
      ),
    );
  }
}