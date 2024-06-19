import 'package:cinema_app/SearchScreen/ChatRoom.dart';
import 'package:cinema_app/components/CustomButton.dart';
import 'package:cinema_app/components/CustomTextField.dart';
import 'package:cinema_app/components/CustomTopBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Map<String, dynamic>? userMap;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] > user2.toLowerCase().codeUnits[0]) {
      return "$user2$user1";
    } else {
      return "$user1$user2";
    }
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .where("email", isEqualTo: _search.text)
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          userMap = snapshot.docs[0].data() as Map<String, dynamic>;
          print(userMap);
        });
      } else {
        setState(() {
          userMap = null;
        });
        print("No user found with email: ${_search.text}");
      }
    } catch (e) {
      print("Error searching for user: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTopBar(text: 'Search Doctor'),
          SizedBox(
            height: 40.h,
          ),
          CustomTextField(
            lname: 'Enter Doctor Name',
            hname: 'Enter Your Email',
            bgcolor: Color(0xffFFFFFF),
            icon: Icons.search,
            controller: _search,
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            width: 330.w,
            height: 52.h,
            child: CustomRoundButton(
              btname: 'Search',
              btcolor: Color(0xff18A0FB),
              onPressed: onSearch,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          userMap != null
              ? ListTile(
            onTap: () {
              String? currentUserName = _auth.currentUser?.displayName;
              String? userName = userMap?['name'] as String?;

              if (currentUserName != null && userName != null) {
                String roomId = chatRoomId(currentUserName, userName);

                print("Navigating to chat room with ID: $roomId");

                Get.to(() => Chat_Room(chatid: roomId, userMap: userMap!));
              } else {
                print('Error: User information is missing');
                print('currentUserName: $currentUserName');
                print('userMap["name"]: ${userMap?["name"]}');
              }
            },
            leading: Icon(
              Icons.verified_user_outlined,
              size: 20,
            ),
            title: Text(userMap?['name'] ?? 'No Name'),
            subtitle: Text(userMap?['email'] ?? 'No Email'),
            trailing: Icon(
              Icons.chat,
              size: 20,
            ),
          )
              : Text('No doctor found'),
        ],
      ),
    );
  }
}
