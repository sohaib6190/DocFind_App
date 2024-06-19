import 'package:avatar_glow/avatar_glow.dart';
import 'package:cinema_app/BottomNavBar/bottom_nav_bar.dart';
import 'package:cinema_app/DoctorJourney/DocConfirmation.dart';
import 'package:cinema_app/Models/Doctors_Appointment.dart';
import 'package:cinema_app/Notifications/Notifications.dart';
import 'package:cinema_app/components/CustomButton.dart';
import 'package:cinema_app/components/CustomDoctorAppointmentButton.dart';
import 'package:cinema_app/components/CustomTopBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class doctor_appointment extends StatefulWidget {


  @override
  State<doctor_appointment> createState() => _doctor_appointmentState();
}

class _doctor_appointmentState extends State<doctor_appointment> {




  late Future<List<Doctor_Appointment>> doctors_appointments;


  void initState() {
    super.initState();
    final List argument = Get.arguments;
    final String name = argument[0];

    doctors_appointments = fetchDoctorsAppointments(name);

  }
  Future<List<Doctor_Appointment>> fetchDoctorsAppointments(String name) async {
    final url = Uri.parse('http://192.168.18.8:3030/read/appointments');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name}),
    );

    if (response.statusCode == 200) {

      List<dynamic> body = json.decode(response.body);
      List<Doctor_Appointment> doctors_appointments= body.map((dynamic item) => Doctor_Appointment.fromJson(item)).toList();
      return doctors_appointments;
    } else {
      throw Exception('Failed to load doctors');
    }
  }




  @override
  Widget build(BuildContext context) {
    final List argument = Get.arguments;

    final String patients = argument[1];
    final String experience = argument[2];
    final String rating = argument[3];




    return Scaffold(
      backgroundColor: Color(0xff18A0FB),
     //   bottomNavigationBar: MyBottomNavBar(),
        body:FutureBuilder<List<Doctor_Appointment>>(
          future: doctors_appointments,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No doctors found'));
            } else {
              return


                  ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Doctor_Appointment doctor_appoint = snapshot.data![index];
                      return   Column(

                        children: [

                                  CustomTopBar(text: 'Doctor Appointment'),

                            SizedBox(
                              height: 40.h,
                            ),

                            AvatarGlow(
                                startDelay: const Duration(milliseconds: 1000),
                                glowColor: Colors.white,
                                glowShape: BoxShape.circle,
                                curve: Curves.fastOutSlowIn,
                                child: const Material(
                                    elevation: 8.0,
                                    shape: CircleBorder(),
                                    color: Colors.transparent,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage('assets/images/doctor.png'),
                                      backgroundColor: Colors.white,
                                      radius: 70,
                                    )
                                )),


                            SizedBox(
                              height: 20.h,
                            ),


                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 30,
                                  child: Icon(Icons.favorite),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 30,
                                  child: Icon(Icons.account_circle),
                                ),

                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 30,
                                  child: Icon(Icons.eighteen_up_rating_rounded),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('$patients',style: TextStyle(fontSize: 20.sp,color: Colors.white,fontWeight: FontWeight.w600)),
                                Text('$experience',style: TextStyle(fontSize: 20.sp,color: Colors.white,fontWeight: FontWeight.w600)),
                                Text('$rating',style: TextStyle(fontSize: 20.sp,color: Colors.white,fontWeight: FontWeight.w600)),
                              ],
                            ),

                            SizedBox(
                              height: 10.h,
                            ),

                            Container(
                              width: 375.w,
                              height: 500.h,

                              decoration: BoxDecoration(
                                color: Color(0xffF9F9F9),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(80),topRight: Radius.circular(80)),

                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                          SizedBox(
                            height: 20.h,
                          ),


                                  Center(child: Text(doctor_appoint.name,style: TextStyle(fontSize: 18.sp,color: Color(0xff202244),fontWeight: FontWeight.bold))),

                                    SizedBox(
                                      height: 20.h,
                                    ),


                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text('Morning slots',style: TextStyle(fontSize: 20.sp,color: Color(0xff202244),
                                        fontWeight: FontWeight.bold)),
                                  )  ,


                                  SizedBox(
                                    height: 20.h,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [

                                      CustomDocAppButton(textinfo: doctor_appoint.slot1,),
                                      CustomDocAppButton(textinfo: doctor_appoint.slot2,),
                                      CustomDocAppButton(textinfo: doctor_appoint.slot3,)
                                    ],
                                  ),


                                  SizedBox(
                                    height: 20.h,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text('Afternoon slots',style: TextStyle(fontSize: 20.sp,color: Color(0xff202244),
                                        fontWeight: FontWeight.bold)),
                                  )  ,


                                  SizedBox(
                                    height: 20.h,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [

                                      CustomDocAppButton(textinfo: doctor_appoint.afternoon_slot1,),
                                          CustomDocAppButton(textinfo: doctor_appoint.afternoon_slot2,)
                                    ],
                                  ),

                            SizedBox(
                               height: 20.h,
                               ),

                                  Center(
                                    child: Container(
                                      width: 327.w,
                                      height: 57.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 44.h,
                                            width: 44.w,
                                            color: Color(0xff9CD2F6),
                                            child: Icon(Icons.phone,size: 15,color: Color(0xff18A0FB),),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Voice Call',style :TextStyle(fontSize: 18.sp,color: Color(0xff202244),fontWeight: FontWeight.w600,)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 150),
                                            child: Text(doctor_appoint.voice_call.toString(),style: TextStyle(fontSize: 15.sp,color: Color(0xff18A0FB))),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),



                                  SizedBox(
                                    height: 20.h,
                                  ),

                                  Center(
                                    child: Container(
                                      width: 327.w,
                                      height: 57.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 44.h,
                                            width: 44.w,
                                            color: Color(0xff9CD2F6),
                                            child: Icon(Icons.video_call,size: 15,color: Color(0xff18A0FB),),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Video Call',style :TextStyle(fontSize: 18.sp,color: Color(0xff202244),fontWeight: FontWeight.w600,)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 150),
                                            child: Text(doctor_appoint.video_call.toString(),style: TextStyle(fontSize: 15.sp,color: Color(0xff18A0FB))),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 10.h,
                                  ),


                                  Center(
                                    child: SizedBox(
                                      width: 330.w,
                                      height: 52.h,
                                      child: CustomRoundButton(btname: 'Request for appointment', btcolor: Color(0xff18A0FB)
                                        ,onPressed: (){

                                          Get.to(() => DocConfirmation(), arguments: [doctor_appoint.name,doctor_appoint.slot1],
                                            transition: Transition.rightToLeftWithFade,
                                            duration: Duration(milliseconds: 500),

                                          );

                                        },),
                                    ),
                                  )

                                ],
                              ),
                            )





                        ],
                      );

                    },
                  );


            }
          },
        ),



    );
  }
}
