import 'package:cinema_app/BottomNavBar/bottom_nav_bar.dart';
import 'package:cinema_app/DoctorJourney/Doctor_Appointment.dart';
import 'package:cinema_app/Models/Doctor_Profile.dart';
import 'package:cinema_app/components/CustomButton.dart';
import 'package:cinema_app/components/CustomTopBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:avatar_glow/avatar_glow.dart';


class doctors_profile extends StatefulWidget {


  @override
  State<doctors_profile> createState() => _doctors_profileState();
}

class _doctors_profileState extends State<doctors_profile> {

  late Future<List<Doctor_Profile>> doctors_profile;

  void initState() {
    super.initState();
    final String name = Get.arguments;
     doctors_profile = fetchDoctors(name);

  }


  Future<List<Doctor_Profile>> fetchDoctors(String name) async {
    final url = Uri.parse('http://localhost:3030/read/details/doctorprofile2');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name}),
    );

    if (response.statusCode == 200) {

      List<dynamic> body = json.decode(response.body);
      List<Doctor_Profile> doctors_profile= body.map((dynamic item) => Doctor_Profile.fromJson(item)).toList();
      return doctors_profile;
    } else {
      throw Exception('Failed to load doctors');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xff18A0FB),
     // bottomNavigationBar: MyBottomNavBar(),

      body: FutureBuilder<List<Doctor_Profile>>(
        future: doctors_profile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No doctors found'));
          } else {
            return Column(
              children: [
                CustomTopBar(text: 'Doctor Detail'),

                SizedBox(
                  height: 10.h,
                ),


                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Doctor_Profile doctor_info = snapshot.data![index];
                      return   Column(

                        children: AnimateList(
                          interval: 400.ms,
                          effects: [FadeEffect(duration: 300.ms)],
                      children: [



                          SizedBox(
                            height: 30.h,
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
                            height: 30.h,
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
                              Text(doctor_info.patients,style: TextStyle(fontSize: 20.sp,color: Colors.white,fontWeight: FontWeight.w600)),
                              Text(doctor_info.experience,style: TextStyle(fontSize: 20.sp,color: Colors.white,fontWeight: FontWeight.w600)),
                              Text(doctor_info.rating,style: TextStyle(fontSize: 20.sp,color: Colors.white,fontWeight: FontWeight.w600)),
                            ],
                          ),

                          SizedBox(
                            height: 20.h,
                          ),

                          Container(
                            width: 375.w,
                            height: 453.h,

                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(80),topRight: Radius.circular(80)),

                            ),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 SizedBox(
                                   height: 20.h,
                                 ),
                                 Center(child: Text(doctor_info.name,style: TextStyle(fontSize: 18.sp,color: Color(0xff202244),fontWeight: FontWeight.w600))),
                                 SizedBox(
                                   height: 20.h,
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.only(left: 20),
                                   child: Text('About Doctor',style: TextStyle(fontSize: 18.sp,color: Color(0xff202244),fontWeight: FontWeight.w700)),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.only(left: 20),
                                   child: Text(doctor_info.about_doctor,style: TextStyle(fontSize: 18.sp,color: Color(0xff979797),fontWeight: FontWeight.w400)),
                                 ),


                                 Padding(
                                   padding: const EdgeInsets.only(top: 230),
                                   child: Center(child: SizedBox(
                                       width: 330.w,
                                       height: 52.w,
                                       child: CustomRoundButton(btname: 'Get Apppointment', btcolor: Color(0xff18A0FB),
                                         onPressed:(){
                                           Get.to(() => doctor_appointment(), arguments: [doctor_info.name,doctor_info.patients,doctor_info.experience,doctor_info.rating],
                                             transition: Transition.rightToLeftWithFade,
                                             duration: Duration(milliseconds: 500),
                                           );
                                         } ,

                                       ))),
                                 )
                               ],
                             ),
                          )


                        ],
                        ),
                      );

                    },
                  ),
                ),
              ],
            );
          }
        },
      ),






    );
  }
}
