import 'dart:convert';
import 'package:cinema_app/BottomNavBar/bottom_nav_bar.dart';
import 'package:cinema_app/Categories/Categories.dart';
import 'package:cinema_app/components/CustomButton.dart';
import 'package:cinema_app/components/CustomTextField.dart';
import 'package:cinema_app/components/CustomTopBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserForm extends StatefulWidget {
  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final TextEditingController patientNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  Future<void> sendUserData() async {
    final url = Uri.parse('http://localhost:3030/add/userdata');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'pname': patientNameController.text,
        'age': ageController.text,
        'email': emailController.text,
        'mobile_number': mobileNumberController.text,
      }),
    );

    if (response.statusCode == 200) {
      // Handle successful response
      print('Data sent successfully');
    } else {
      // Handle error response
      throw Exception('Failed to send user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAF9F9),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: AnimateList(
          interval: 400.ms,
          effects: [FadeEffect(duration: 300.ms)],
          children: [
            CustomTopBar(text: 'Patient Details'),
            SizedBox(height: 40.h),
            Container(
              width: 335.w,
              height: 518.h,
              decoration: BoxDecoration(
                color: Color(0xffEEEDED),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Patient Name',
                      style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: SizedBox(
                      height: 52.h,
                      width: 310.w,
                      child: CustomTextField(
                        lname: 'Name',
                        hname: 'Name',
                        bgcolor: Colors.white,
                        controller: patientNameController,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Age',
                      style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: SizedBox(
                      height: 52.h,
                      width: 310.w,
                      child: CustomTextField(
                        lname: '12',
                        hname: 'Age',
                        bgcolor: Colors.white,
                        controller: ageController,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Email',
                      style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: SizedBox(
                      height: 52.h,
                      width: 310.w,
                      child: CustomTextField(
                        lname: 'xyz@gmail.com',
                        hname: 'Email',
                        bgcolor: Colors.white,
                        controller: emailController,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Mobile Number',
                      style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: SizedBox(
                      height: 52.h,
                      width: 310.w,
                      child: CustomTextField(
                        lname: '+92',
                        hname: 'Mobile Number',
                        bgcolor: Colors.white,
                        controller: mobileNumberController,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            SizedBox(
              width: 330.w,
              height: 52.h,
              child: CustomRoundButton(
                btname: 'Proceed',
                btcolor: Color(0xff18A0FB),
                onPressed: () async {
                  try {
                    await sendUserData();
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('patientname', patientNameController.text);
                    Get.to(() => MyBottomNavBar());
                    // Navigate to the next screen or show a success message
                  } catch (e) {
                    // Show an error message
                    print('Error: $e');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
