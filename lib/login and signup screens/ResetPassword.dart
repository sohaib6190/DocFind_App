import 'dart:convert';
import 'package:cinema_app/components/CustomButton.dart';
import 'package:cinema_app/components/CustomTopBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cinema_app/components/CustomTextField.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ResetPassword extends StatefulWidget {


  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  var _resetpasswordcontroller = TextEditingController();


  Future<void> sendEmail() async {
    final email = _resetpasswordcontroller.text;
    final url = Uri.parse('http://localhost:3030/generate-password-reset-link');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email}),
    );

    if (response.statusCode == 200) {
      // Successfully sent the email
      Get.snackbar(
                  'Successed',
                  'Success to send link',
                  snackPosition: SnackPosition.TOP,
                  forwardAnimationCurve: Curves.elasticInOut,
                  reverseAnimationCurve: Curves.easeOut,
                  backgroundColor: Colors.green
                );
    } else {
      Get.snackbar(
                  'Error',
                  'Failed to send link',
                  snackPosition: SnackPosition.TOP,
                  forwardAnimationCurve: Curves.elasticInOut,
                  reverseAnimationCurve: Curves.easeOut,
                  backgroundColor: Colors.red
                );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          
         CustomTopBar(text: 'Reset Password'),

          SizedBox(
            height: 52.h,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Text('We need your registration email address to send you password reset code!',
              style: TextStyle(fontSize: 16.sp,color: Color(0xff202244),fontWeight: FontWeight.w500),),
          ),

          SizedBox(
            height: 50.h,
          ),

          CustomTextField(lname: 'Email', hname: 'Enter Your Email', bgcolor: Color(0xffE3E3E3),
            controller: _resetpasswordcontroller,
          ),

          SizedBox(
            height: 35.h,
          ),


          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
                width: 330.w,
                height: 52.h,
                child: CustomRoundButton(btname: 'Send Code', btcolor: Color(0xff18A0FB),
                  onPressed: sendEmail,

                )),
          ),
        ],
      )
    );

  }
}
