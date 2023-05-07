import 'package:billpay1/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';
import 'HomeScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _sodienthangtruoc = TextEditingController();
  TextEditingController _sodienthangnay = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:AppBar(
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
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        hexStringToColor("000022"),
        hexStringToColor("000022"),
        hexStringToColor("9999FF"),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: SingleChildScrollView(

        child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.2, 20, 0),
          child: Column(

            children: <Widget>[



              logoWidget("assets/images/logo1.png"),
              SizedBox(
                height: 1,

              ),


              reusableTextField("So dien thang truoc", Icons.person_outline,
                  false, _sodienthangtruoc),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("So dien thang nay", Icons.lock_outline, true,
                  _sodienthangnay),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 20,
              ),
              Row(children: <Widget>[
                SizedBox.fromSize(
                  size: Size(56, 56),
                  child: ClipOval(
                    child: Material(
                      color: Colors.amberAccent,
                      child: InkWell(
                        splashColor: Colors.green,
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.payment_outlined), // <-- Icon
                            Text("Pay"), // <-- Text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    // <-- Icon
                    Icons.download,
                    size: 24.0,
                  ),
                  label: Text('Download Bill Payed'), // <-- Text
                ),
              ])
            ],
          ),
        ),
      ),
    ));
  }
}
