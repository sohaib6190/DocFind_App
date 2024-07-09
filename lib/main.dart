import 'package:cinema_app/BottomNavBar/bottom_nav_bar.dart';
import 'package:cinema_app/Categories/Categories.dart';
import 'package:cinema_app/DoctorJourney/DocConfirmation.dart';

import 'package:cinema_app/DoctorJourney/doctors_list.dart';
import 'package:cinema_app/Home/HomePage.dart';
import 'package:cinema_app/Notifications/Notifications.dart';
import 'package:cinema_app/Payment/Payment.dart';
import 'package:cinema_app/SearchScreen/ChatRoom.dart';
import 'package:cinema_app/SearchScreen/searchscreen.dart';
import 'package:cinema_app/Splash%20Screen/Splash.dart';
import 'package:cinema_app/components/Searchable.dart';
import 'package:cinema_app/components/Splash_payment.dart';
import 'package:cinema_app/login%20and%20signup%20screens/ResetPassword.dart';
import 'package:cinema_app/login%20and%20signup%20screens/Signin_screen.dart';
import 'package:cinema_app/login%20and%20signup%20screens/UserForm.dart';
import 'package:cinema_app/login%20and%20signup%20screens/signup_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart' ;
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'DoctorJourney/Doctors_Info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDpwUTA66DfGU1p4YGaI3Ir-adWYfLj6ZQ",
            authDomain: "cinema-app-caa49.firebaseapp.com",
            projectId: "cinema-app-caa49",
            storageBucket: "cinema-app-caa49.appspot.com",
            messagingSenderId: "308248073154",
            appId: "1:308248073154:web:ddfad1f38514696a73bc5b",
            measurementId: "G-HTRTQ5ZXTN"));
  } else {
    await Firebase.initializeApp();
  }
  runApp( MyApp());

}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(

          title: 'Docfinder',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            splashColor: Colors.red,
            highlightColor: Colors.black.withOpacity(.5),
            visualDensity: VisualDensity.adaptivePlatformDensity,

          ),
          home: Splash_Screen(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: (){
          Get.to(()=> SearchScreen());

        },
        child: Text('Hello'),
      )
    );
  }
}
