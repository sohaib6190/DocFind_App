import 'package:cinema_app/BottomNavBar/bottom_nav_bar.dart';
import 'package:cinema_app/components/CustomTextField.dart';
import 'package:cinema_app/components/CustomTopBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Chat_Room extends StatelessWidget {

  final Map<String,dynamic> userMap;
  final String chatid;

  Chat_Room({
    required this.chatid,
    required this.userMap
});

final TextEditingController _message = TextEditingController();
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

void onSendMessage() async {

  if(_message.text.isNotEmpty){
    Map <String,dynamic> messages = {
      "sendby" : _auth.currentUser!.displayName,
      "message" : _message.text,
      "time" : FieldValue.serverTimestamp(),
    };
    await _firestore
        .collection('chatroom')
        .doc(chatid)
        .collection('chats')
        .add((messages));
   _message.clear();
  }else{
    print('Enter Some text');
  }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
   //   bottomNavigationBar: MyBottomNavBar(),
      // appBar: AppBar(
      //   title: Text(userMap['name']),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [


                  CustomTopBar(text: userMap['name']),
            SizedBox(
              height: 20.h,
            ),

            Container(
              height: 660.h,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('chatroom')
                    .doc(chatid)
                    .collection('chats')
                    .orderBy("time",descending: false).
                snapshots(

                ),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot){
                  if (snapshot.hasData) {
                    return ListView.builder(
                       itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {

         Map<String, dynamic> messageData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
          bool isSender = messageData['sendby'] == _auth.currentUser?.displayName;

            return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),
                          bottomRight: Radius.circular(20)),
                      color: isSender ? Colors.blue : Colors.grey,
                      ),

                          child: Text(
                           messageData['message'],
                              style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                             ),
                         ),
                      ),
            );
                },
                            );
                        }
                  else {
                        return Center(child: CircularProgressIndicator());





                  }
                },

              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(lname: 'Type Message', hname: 'Enter Message', bgcolor: Color(0xff18A0FB),
                  controller: _message,


                ),
                IconButton(onPressed: onSendMessage, icon:Icon(Icons.send))
              ],
            )
          ],
        ),
      ),
    );
  }
}
