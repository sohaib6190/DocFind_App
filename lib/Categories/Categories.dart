import 'package:cinema_app/BottomNavBar/bottom_nav_bar.dart';
import 'package:cinema_app/DoctorJourney/doctors_list.dart';
import 'package:cinema_app/Staggered_Animation/AutoRefresh.dart';
import 'package:cinema_app/Staggered_Animation/Cards.dart';
import 'package:cinema_app/components/CustomTopBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:convert';
import '../login and signup screens/ResetPassword.dart';
import 'package:http/http.dart' as http;
class Categories extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    var columnCount = 2;


    var categoriesdata = [
      {
        'image': AssetImage('assets/images/i1.png'),
        'id' : 1
      },
      {
        'image': AssetImage('assets/images/i2.png'),
        'id' : 2
      },
      {
        'image': AssetImage('assets/images/i3.png'),
        'id' : 3
      },
      {
        'image': AssetImage('assets/images/i4.png'),
        'id' : 4
      },
      {
        'image': AssetImage('assets/images/i5.png'),
        'id' : 5
      },
      {
        'image': AssetImage('assets/images/i6.png'),
        'id' : 6
      },
      {
        'image': AssetImage('assets/images/i7.png'),
        'id' : 7
      },
      {
        'image': AssetImage('assets/images/i8.png'),
        'id' : 8
      },
    ];

    return Scaffold(
      //bottomNavigationBar: MyBottomNavBar(),
      body: Column(
        children: [
          CustomTopBar(text: 'Categories'),
          SizedBox(height: 22.h),
          Expanded(
            child: AnimationLimiter(
              child: GridView.count(
                childAspectRatio: 1.0,
                padding: const EdgeInsets.all(8.0),
                crossAxisCount: columnCount,
                children: categoriesdata.asMap().entries.map((entry) {
                  int index = entry.key;
                  var data = entry.value;
                 // Color color = entry.value['color'] as Color;
                  AssetImage image = entry.value['image'] as AssetImage;
                  int id = data['id'] as int;


                  return AnimationConfiguration.staggeredGrid(
                    columnCount: columnCount,
                    position: index,
                    duration: const Duration(milliseconds: 675),
                    child: ScaleAnimation(
                      scale: 0.5,
                      child: FadeInAnimation(
                        child: InkWell(
                          onTap: (){

                          Get.to(() => DoctorsList(), arguments: id);

                          },
                          child: EmptyCard(
                            width: 144,
                            height: 70,
                            image:image,

                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
 
  }
}
