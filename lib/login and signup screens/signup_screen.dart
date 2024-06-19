import 'package:cinema_app/Categories/Categories.dart';
import 'package:cinema_app/Home/HomePage.dart';
import 'package:cinema_app/components/CustomButton.dart';
import 'package:cinema_app/components/CustomTextField.dart';
import 'package:cinema_app/login%20and%20signup%20screens/Signin_screen.dart';
import 'package:cinema_app/login%20and%20signup%20screens/UserForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var namecontroller = TextEditingController();
    var emailcontroller = TextEditingController();
    var passwordcontroller = TextEditingController();

    void signUp() async {
      if (namecontroller.text.trim().isEmpty) {
        Get.snackbar(
          'Error',
          'Name cannot be blank',
          snackPosition: SnackPosition.TOP,
          forwardAnimationCurve: Curves.elasticInOut,
          reverseAnimationCurve: Curves.easeOut,
        );
      } else if(emailcontroller.text.trim().isEmpty){
        Get.snackbar(
          'Error',
          'Email cannot be empty',
          snackPosition: SnackPosition.TOP,
          forwardAnimationCurve: Curves.elasticInOut,
          reverseAnimationCurve: Curves.easeOut,
          backgroundColor: Colors.blue
        );
      } else if(passwordcontroller.text.trim().isEmpty){
        Get.snackbar(
          'Error',
          'Password cannot be empty',
          snackPosition: SnackPosition.TOP,
          forwardAnimationCurve: Curves.elasticInOut,
          reverseAnimationCurve: Curves.easeOut,
          backgroundColor: Colors.redAccent
        );
      }

      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordcontroller.text.trim(),

          

        );

        await credential.user?.updateProfile(displayName: namecontroller.text.trim());
        // Handle successful sign-up, e.g., navigate to another screen
        //Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();
        await _firestore.collection('users').doc(credential.user?.uid).set({
          "name" : namecontroller.text.trim(),
          "email" :emailcontroller.text.trim(),
          "status" :"Unavailable"
        });
        Get.showSnackbar(

          GetSnackBar(
          title: "Successful",
            message: "User Successfuly Created",
            icon: const Icon(Icons.login_sharp),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.green,
          )
        );

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', namecontroller.text);

        Get.to(()=> UserForm(),transition:Transition.rightToLeftWithFade);

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar(
            'Warning',
            'Password should be more than 6 characters',
            snackPosition: SnackPosition.TOP,
            forwardAnimationCurve: Curves.elasticInOut,
            reverseAnimationCurve: Curves.easeOut,
          );

        } else if (e.code == 'email-already-in-use') {
          Get.snackbar(
            'Warning',
            'Email Already Registered',
            snackPosition: SnackPosition.TOP,
            forwardAnimationCurve: Curves.elasticInOut,
            reverseAnimationCurve: Curves.easeOut,
          );
        }

        else {
          print('Sign-up error: ${e.message}');
        }
      } catch (e) {
        print('Sign-up error: $e');
      }
    }
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),

      body: Column(

        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50.h,
          ),
              Center(child: Text('Lets Sign Up',style: TextStyle(fontSize: 20.sp,color: Color(0xff202244),fontWeight: FontWeight.w600),)),

          SizedBox(
            height: 52.h,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text('Create \nAccount!',style: TextStyle(fontSize: 30.sp,color: Color(0xff202244),fontWeight: FontWeight.w600),),
          ),

          SizedBox(
            height: 50.h,
          ),

      CustomTextField(lname: 'Name', hname: 'Enter Your Name', bgcolor: Color(0xffFFFFFF),
      controller: namecontroller,
      ),

            SizedBox(
              height: 20.h,
            ),

          CustomTextField(lname: 'Email', hname: 'Enter Your Email', bgcolor: Color(0xffFFFFFF),icon: Icons.email,
          controller: emailcontroller,
          ),

          SizedBox(
            height: 20.h,
          ),

          CustomTextField(lname: 'Password', hname: 'Enter Your Password', bgcolor: Color(0xffFFFFFF),icon: Icons.password,
          controller: passwordcontroller,
          ),

          SizedBox(
            height: 35.h,
          ),


        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SizedBox(
              width: 330.w,
              height: 52.h,
              child: CustomRoundButton(btname: 'Sign Up', btcolor: Color(0xff18A0FB),
              onPressed: signUp,
              )),
        ),

          SizedBox(
            height: 15.h,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Text('Already have an account?',style: TextStyle(fontSize: 15.sp,color: Color(0xff202244),fontWeight: FontWeight.w500),),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: InkWell(
                      onTap: (){
                        Get.to(()=> Login(),
                          transition: Transition.zoom,

                          duration: Duration(milliseconds: 500),
                        );
                      },
                      child: Text('Sign in',style: TextStyle(fontSize: 15.sp,color: Color(0xff18A0FB),fontWeight: FontWeight.w600),)),
                ),

    ],

    ),
        ],
      )
    );
  }
}
