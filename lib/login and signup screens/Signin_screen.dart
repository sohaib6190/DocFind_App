
import 'package:cinema_app/login%20and%20signup%20screens/ResetPassword.dart';
import 'package:cinema_app/login%20and%20signup%20screens/UserForm.dart';
import 'package:cinema_app/login%20and%20signup%20screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cinema_app/components/CustomButton.dart';
import 'package:cinema_app/components/CustomTextField.dart';
import 'package:get/get.dart';
import "package:firebase_auth/firebase_auth.dart";
class Login extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    var emailcontroller = TextEditingController();
    var passwordcontroller = TextEditingController();

    void signIn() async {
    if(emailcontroller.text.trim().isEmpty){
        Get.snackbar(
            'Error',
            'Email cannot be empty',
            snackPosition: SnackPosition.TOP,
            forwardAnimationCurve: Curves.elasticInOut,
            reverseAnimationCurve: Curves.easeOut,
            backgroundColor: Colors.red
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
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordcontroller.text.trim(),

        );


        Get.showSnackbar(

            GetSnackBar(
              title: "User Successfuly login",
              message: "User Successfuly login",
              icon: const Icon(Icons.login),
              snackPosition: SnackPosition.TOP,
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.green,
            )
        );
        Get.to(()=>  UserForm(),transition:Transition.rightToLeftWithFade);
        //Get.toNamed('/Categories');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar(
            'Warning',
            'No user found for this email',
            snackPosition: SnackPosition.TOP,
            forwardAnimationCurve: Curves.elasticInOut,
            reverseAnimationCurve: Curves.easeOut,
          );

        } else if (e.code == 'wrong-password') {
          Get.snackbar(
            'Warning',
            'Wrong Password',
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
            Center(child: Text('Lets Sign Inn',style: TextStyle(fontSize: 20.sp,color: Color(0xff202244),fontWeight: FontWeight.w600),)),

            SizedBox(
              height: 52.h,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text('Welcome',style: TextStyle(fontSize: 30.sp,color: Color(0xff202244),fontWeight: FontWeight.w600),),
            ),



            SizedBox(
              height: 50.h,
            ),

            CustomTextField(lname: 'Email', hname: 'Enter Your Email', bgcolor: Color(0xffFFFFFF),
              controller: emailcontroller,
            ),



            SizedBox(
              height: 20.h,
            ),

            CustomTextField(lname: 'Password', hname: 'Enter Your Password', bgcolor: Color(0xffFFFFFF),icon: Icons.password,
              controller: passwordcontroller,
            ),

            SizedBox(
              height: 5.h,
            ),

            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                      onTap: (){

                        Get.to(()=> ResetPassword(),
                          transition: Transition.leftToRightWithFade,

                          duration: Duration(milliseconds: 500),
                        );
                      },
                      child: Text('Forgot Password',style: TextStyle(fontSize: 10.sp,color: Color(0xff202244),fontWeight: FontWeight.w400),))),
            ),

            SizedBox(
              height: 75.h,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                  width: 330.w,
                  height: 52.h,
                  child: CustomRoundButton(btname: 'Sign In', btcolor: Color(0xff18A0FB),
                    onPressed: signIn,

                  )

              ),
            ),


            SizedBox(
              height: 15.h,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Dont have an account?',style: TextStyle(fontSize: 15.sp,color: Color(0xff202244),fontWeight: FontWeight.w500),),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: InkWell(
                      onTap: (){
                        Get.to(()=> Signup(),
                          transition: Transition.zoom,

                          duration: Duration(milliseconds: 500),
                        );
                      },
                      child: Text('Sign Up',style: TextStyle(fontSize: 15.sp,color: Color(0xff18A0FB),fontWeight: FontWeight.w600),)),
                ),

              ],

            ),
          ],
        )
    );
  }
}
