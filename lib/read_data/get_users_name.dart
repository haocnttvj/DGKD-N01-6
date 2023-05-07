import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String documentID;

  GetUserName({required this.documentID});


  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final now = DateTime.now().month;

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentID).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            List<dynamic> numbers = data['month'];
            List<int> number = numbers.map((e) => e as int).toList();
            int cur_number = number[now] - number[now - 1];
            int num=0;
            if(cur_number<100){
              num=cur_number*3500;
            }
            else {
              num=cur_number*4000;

            };
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${data['name']}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Số điện tháng ${now}: $cur_number',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Số tiền phải tra điện tháng ${now}: ${num}',
                  style: TextStyle(fontSize: 14),
                ),

              ],
            );


          }
          return Text('loading');
        }));
  }
}
