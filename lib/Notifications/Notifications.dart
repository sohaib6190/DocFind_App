import 'dart:convert';
import 'package:cinema_app/Models/Notifications.dart';
import 'package:cinema_app/components/CustomTopBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Notification_Screen extends StatefulWidget {


  @override
  State<Notification_Screen> createState() => _Notification_ScreenState();
}

class _Notification_ScreenState extends State<Notification_Screen> {

  late Future<List<Notifications>> notifications;

  void initState() {
    super.initState();
    notifications = get_Notifications();
  }


  Future<List<Notifications>> get_Notifications() async {
    final prefs = await SharedPreferences.getInstance();
    final String? patientname = prefs.getString('patientname');
    print('Retrieved patientname from SharedPreferences: $patientname');
    final url = Uri.parse('http://localhost:3030/read/notifications');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'patientname':patientname}),
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Notifications> user_notification= body.map((dynamic item) => Notifications.fromJson(item)).toList();
      return user_notification;
    } else {
      throw Exception('Failed to send data');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),

      body: FutureBuilder<List<Notifications>>(
        future: notifications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Notification found'));
          } else {
            return Column(

                children:AnimateList(
                  interval: 400.ms,
                  effects: [FadeEffect(duration: 300.ms)],
                  children: [
                    CustomTopBar(text: 'Notifications'),
                    SizedBox(
                      height: 20.h,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context,index){
                          Notifications user_notifications = snapshot.data![index];
                          return Column(
                            children: [

                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Icon(Icons.notifications),
                                  ),






                          Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'You have an appointment with \n${user_notifications.doctor_name} at ${user_notifications.timing}',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Color(0xff202244),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),




                            ]
                          );
                        },
                      ),
                    )

                  ],
                )
            );
          }
        },
      ),
    );
  }
}
