import 'package:cinema_app/Categories/Categories.dart';
import 'package:cinema_app/DoctorJourney/doctors_list.dart';
import 'package:cinema_app/Home/HomePage.dart';
import 'package:cinema_app/Notifications/Notifications.dart';
import 'package:cinema_app/SearchScreen/searchscreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

class MyBottomNavBar extends StatefulWidget {


  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController, // ADD THIS if you need to change your tab programmatically
        initialSelectedTab: "Doctors",

        labels: const ["Home", "Doctors", "Notifications", "Payment"],
        icons: const [Icons.home, Icons.medical_information_outlined, Icons.notification_add_outlined, Icons.payment_outlined],

        // Ensure badges list length matches labels list length
        badges: [
          // Badge for Home tab
          const MotionBadgeWidget(
            text: '10+',
            textColor: Colors.white, // optional, default to Colors.white
            color: Colors.red, // optional, default to Colors.red
            size: 18, // optional, default to 18
          ),
          // Badge for Doctors tab
          const MotionBadgeWidget(
            text: '10+',
            textColor: Colors.white, // optional, default to Colors.white
            color: Colors.red, // optional, default to Colors.red
            size: 18, // optional, default to 18
          ),
          // Badge for Notifications tab
          Container(
            color: Colors.black,
            padding: const EdgeInsets.all(2),
            child: const Text(
              '11',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
          // No badge for Payment tab
          null,
        ],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Color(0xff18A0FB),
        tabIconSize: 22.0,
        tabIconSelectedSize: 20.0,
        tabSelectedColor: Color(0xff18A0FB),
        tabIconSelectedColor: Color(0xff202244),
        tabBarColor: Colors.white,
        onTabItemSelected: (int value) {
          setState(() {
            // _tabController!.index = value;
            _motionTabBarController!.index = value;
          });
        },
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
        // controller: _tabController,
        controller: _motionTabBarController,
        children: <Widget>[

          Home_Page(),
          Categories(),
          Notification_Screen(),
          SearchScreen(),
        ],
      ),
    );
  }
}
