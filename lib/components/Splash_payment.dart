import 'dart:async';

import 'package:cinema_app/Notifications/Notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
class Splash_Payment extends StatefulWidget {


  @override
  State<Splash_Payment> createState() => _Splash_PaymentState();

}

class _Splash_PaymentState extends State<Splash_Payment> {

  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>  Get.to(()=> Notification_Screen(),
              transition: Transition.leftToRightWithFade,

              duration: Duration(milliseconds: 500),

        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: [

          SizedBox(
            height: 200.h,
          ),
          Center(
            child: Lottie.asset(
              'assets/images/lottie.json',
              width: 200,
              height: 200,

            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text('Payment Successful',style :TextStyle(fontSize: 35.sp,color: Colors.green,fontWeight: FontWeight.w500),),
        ],
      ),
    );
  }
}
