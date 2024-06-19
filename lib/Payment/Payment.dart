import 'dart:async';

import 'dart:convert';

import 'package:cinema_app/components/CustomButton.dart';
import 'package:cinema_app/components/CustomTopBar.dart';
import 'package:cinema_app/components/Splash_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/Notifications.dart';

class Payment_Screen extends StatefulWidget {

  @override
  State<Payment_Screen> createState() => _Payment_ScreenState();
}

class _Payment_ScreenState extends State<Payment_Screen> {

  int _selectedValue = 1;

  late List notifications ;

  Future<void> add_Notifications(patientname,name,slot) async {
    final url = Uri.parse('http://192.168.18.8:3030/add/notifications');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'patientname': patientname,
        'doctor_name': name,
        'timing': slot,
      }),
    );

    if (response.statusCode == 200) {
      // Handle successful response
      print('Data sent successfully');
      Get.to(() => Splash_Payment(),
        transition: Transition.circularReveal,

        duration: Duration(milliseconds: 500),
      );
    } else {
      // Handle error response
      throw Exception('Failed to send user data');
    }
  }


  void onPaymentButtonPressed() async {
    final prefs = await SharedPreferences.getInstance();
    final String? name = prefs.getString('name');
    final String? patientname = prefs.getString('patientname');
    final String? slot = prefs.getString('slot');

    if (name != null && patientname != null && slot != null) {
      notifications = add_Notifications(patientname, name, slot) as List;
    }

    try {
      await add_Notifications(patientname, name, slot);

    } catch (e) {
      // Handle error (e.g., show an error message)
      print('Failed to add notification: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xffF9F9F9),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          CustomTopBar(text: 'Payment   Method '),

          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: <Widget>[
                SizedBox(
                  height: 30.h,
                ),
                // Create a RadioListTile for option 1

                RadioListTile(
                  contentPadding:EdgeInsets.all(20.0),
                  title: Text('PayPal',style :TextStyle(fontSize: 20.sp,color: Color(0xff0079C1),fontWeight: FontWeight.w700,)), // Display the title for option 1
                tileColor:  Colors.white,
                  value: 1,
                  groupValue:
                  _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue =
                      value! as int;
                    });
                  },
                ),

                // Create a RadioListTile for option 2
                RadioListTile(
                  contentPadding:EdgeInsets.all(20.0),
                  title: Text('Google Pay',style :TextStyle(fontSize: 20.sp,color: Color(0xff0079C1),fontWeight: FontWeight.w700,),),
                  tileColor: Colors.white,
                  value: 2,
                  groupValue:
                  _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue =
                      value! as int ;
                    });
                  },
                ),

                // Create a RadioListTile for option 3
                RadioListTile(
                  contentPadding:EdgeInsets.all(20.0),
                  title: Text('Apple Pay',style :TextStyle(fontSize: 20.sp,color: Color(0xff0079C1),fontWeight: FontWeight.w700,)), // Display the title for option 3
                  tileColor: Colors.white,
                  value: 3,
                  groupValue:
                  _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue =
                      value! as int;
                    });
                  },


                ),

                SizedBox(
                  height: 100.h,
                ),

                SizedBox(
                    width: 300.w,
                    height: 52.h,
                    child: CustomRoundButton(btname: 'Payment', btcolor: Color(0xff18A0FB),onPressed: onPaymentButtonPressed))
              ],

            ),

          ),


        ],
      ),
    );
  }
}
