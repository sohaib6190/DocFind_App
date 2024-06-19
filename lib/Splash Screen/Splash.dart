import 'dart:async';

import 'package:cinema_app/login%20and%20signup%20screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Splash_Screen extends StatefulWidget {

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2),
            ()=>  Get.to(()=> Signup(),
          transition: Transition.leftToRightWithFade,

          duration: Duration(milliseconds: 500),

        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   Center(
        child: Lottie.asset(
        'assets/images/Splash_Screen.json',
        width: 100.w,
        height: 150.h,
          fit: BoxFit.fill

          ),

      ),
    );
  }
}
