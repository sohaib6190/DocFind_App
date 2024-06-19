import 'package:cinema_app/BottomNavBar/bottom_nav_bar.dart';
import 'package:cinema_app/Payment/Payment.dart';
import 'package:cinema_app/SearchScreen/searchscreen.dart';
import 'package:cinema_app/components/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DocConfirmation extends StatefulWidget {
  @override
  State<DocConfirmation> createState() => _DocConfirmationState();
}

class _DocConfirmationState extends State<DocConfirmation> {


  @override
  Widget build(BuildContext context) {

    final List argument = Get.arguments;

    final String name = argument[0];
    final String slot = argument[1];
    return Scaffold(
        backgroundColor:  Color(0xff18A0FB),
      //bottomNavigationBar: MyBottomNavBar(),
      body: Column(
        children: AnimateList(
               interval: 400.ms,
                  effects: [FadeEffect(duration: 300.ms)],
          children: [
          SizedBox(
            height: 40.h,
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/doctor.png'),
            backgroundColor: Colors.white,
            radius: 70,
          ),

          SizedBox(
            height: 300.h,
          ),

          Center(
            child: SizedBox(
                width: 330.w,
                height: 52.h,
                child: CustomRoundButton(btname: 'View Details', btcolor: Color(0xff18A0FB),onPressed: (){

                  Get.bottomSheet(
                      Container(

                        decoration: BoxDecoration(
                            color: Color(0xffF6F6F6),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))

                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Divider(
                              height: 10.h,
                              thickness: 2,
                              color: Color(0xffABB4BD),
                            ),

                            SizedBox(
                              height: 40.h,
                            ),

                            FaIcon(FontAwesomeIcons.thumbsUp,color: Color(0xff18A0FB),
                              size: 70  ,
                            ),

                            SizedBox(
                              height: 40.h,
                            ),

                            Text('Thank You!\nYour Appointment Created',style :TextStyle(fontSize: 17.sp,color: Color(0xff202244),fontWeight: FontWeight.w700,)),

                            SizedBox(
                              height: 40.h,
                            ),

                            Text('You booked an appoinment with \n${name} on sep 21, at'
                                ' ${slot}',


                                style :TextStyle(fontSize: 16.sp,color: Color(0xff979797),
                                  fontWeight: FontWeight.w400,)),
                         SizedBox(
                           height: 20.h,
                         ),

                         SizedBox(
                             width: 330.w,
                             height: 52.h,
                             child: CustomRoundButton(btname: 'Payment', btcolor: Color(0xff18A0FB),onPressed: () async {

                               final prefs = await SharedPreferences.getInstance();
                               await prefs.setString('name', name);
                               await prefs.setString('slot', slot);
                               Get.to(() => Payment_Screen(),
                                 //arguments: [name,patientname,slot],
                                 transition: Transition.leftToRightWithFade,

                                 duration: Duration(milliseconds: 500),
                               );
                             },))


                          ],
                        ),
                      )
                  );


                },)),
          )
        ],
      ),
      ),
    );
  }
}
