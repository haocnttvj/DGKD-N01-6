import 'package:billpay1/screens/AdminPage.dart';
import 'package:billpay1/screens/calculate_bill.dart';
import 'package:billpay1/screens/express.dart';
import 'package:billpay1/screens/maket.dart';
import 'package:billpay1/screens/show_result.dart';
import 'package:billpay1/screens/signin_screen.dart';
import 'package:billpay1/screens/test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';
import 'homenew.dart';


class HomeScreenz extends StatefulWidget {
  const HomeScreenz({Key? key}) : super(key: key);



  @override
  _HomeScreenStatez createState() => _HomeScreenStatez();
}

class _HomeScreenStatez extends State<HomeScreenz> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  User? user= FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          ("Well Come Home Page"),
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
          ElevatedButton(

            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreenr(userName: 'haodeptrai', userImageUrl: "https://i.ytimg.com/vi/1l_YadQTg5Q/maxresdefault.jpg")));
            }, child: null,


            // <-- Text
          ),
        ],
      ),



       body: Container(

          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,

          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                hexStringToColor("6699FF"),
                hexStringToColor("000022"),
                hexStringToColor("000022"),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Column(
                children: <Widget>[



                  logoWidget("assets/images/logo1.png"),
                  SizedBox(
                    height: 30,
                  ),

                  Row(children: <Widget>[


                    const Text("_You wan to Pay for bill_",
                        style: TextStyle(color: Colors.black,height: 2, backgroundColor: Colors.white,fontSize: 20),),

                    const Text("  "),

                    ElevatedButton.icon(
                      onPressed: () => Navigator.push(
                          context, MaterialPageRoute(builder: (context) => HomeScreenr(userName: 'Honagquyhao', userImageUrl: 'https://i.ytimg.com/vi/1l_YadQTg5Q/maxresdefault.jpg'))),
                      icon: Icon(
                        // <-- Icon
                        Icons.payment,
                        size: 24.0,
                      ),
                      label: Text('Get'), // <-- Text
                    ),
                  ]),
                  Row(children: <Widget>[


                    const Text("_You want to go market_     _",
                      style: TextStyle(color: Colors.black,height: 2, backgroundColor: Colors.white,fontSize: 20),),
                    const Text("  "),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.push(
                          context, MaterialPageRoute(builder: (context) => MarketScreen())),
                      icon: Icon(
                        // <-- Icon
                        Icons.download_done,
                        size: 24.0,
                      ),
                      label: Text('Get'), // <-- Text
                    ),
                  ]),
                  Row(children: <Widget>[


                    const Text("_Your phone number update",
                      style: TextStyle(color: Colors.black,height: 2, backgroundColor: Colors.white,fontSize: 20),),
                    const Text("  "),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.push(
                          context, MaterialPageRoute(builder: (context) => HomeScreeny())),
                      icon: Icon(
                        // <-- Icon
                        Icons.exit_to_app,
                        size: 24.0,
                      ),
                      label: Text('Get'), // <-- Text
                    ),
                  ]),
                  Row(children: <Widget>[


                    const Text("__If you are admid ____->",
                      style: TextStyle(color: Colors.black,height: 2, backgroundColor: Colors.white,fontSize: 20),),

                    const Text("  "),

                    ElevatedButton.icon(
                      onPressed: () => Navigator.push(
                          context, MaterialPageRoute(builder: (context) => AdminPage())),
                      icon: Icon(
                        // <-- Icon
                        Icons.contact_mail,
                        size: 24.0,
                      ),
                      label: Text('Go'), // <-- Text
                    ),
                  ]),
                  Row(children: <Widget>[


                    const Text("__Pay Bill____->",
                      style: TextStyle(color: Colors.black,height: 2, backgroundColor: Colors.white,fontSize: 20),),

                    const Text("  "),

                    ElevatedButton.icon(
                      onPressed: () => Navigator.push(
                          context, MaterialPageRoute(builder: (context) => ElectricityBillCalculator())),
                      icon: Icon(
                        // <-- Icon
                        Icons.payment_outlined,
                        size: 24.0,
                      ),
                      label: Text('Go'), // <-- Text
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
