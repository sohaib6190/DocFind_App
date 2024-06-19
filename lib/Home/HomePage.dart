import 'package:cinema_app/Categories/Categories.dart';
import 'package:cinema_app/components/CustomButton.dart';
import 'package:cinema_app/components/CustomTextField.dart';
import 'package:cinema_app/components/CustomTopBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home_Page extends StatefulWidget {





  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  final List<Map<String, dynamic>> homedata = [
  {
    'text':'Diagnostic',
    'color' :Color(0xff7166F9),
    'icon' : Icons.medical_information_outlined
  },

  {
    'text':'Dental',
    'color' :Color(0xffFF7854),
    'icon' : Icons.mediation_sharp
  },

  {
    'text':'Surgeon',
    'color' :Color(0xffFEA725),
    'icon' : Icons.medication_liquid_sharp
  },


    {
      'text':'Radiology',
      'color' :Color(0xff68EEBE),
      'icon' : Icons.medical_services_outlined
    }



  ];

  String? patientname;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     fetchusername() ;
  }

  Future<void> fetchusername () async {
    final prefs = await SharedPreferences.getInstance();
    final String? name = prefs.getString('patientname');
    setState(() {
      patientname = name;
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      
        children: AnimateList(
            interval: 400.ms,
            delay: 400.ms,
            effects: [FadeEffect(duration: 300.ms)],
          children: [

              CustomTopBar(text: 'DocFind'),

            SizedBox(
              height: 30.h,
            ),




            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text('Welcome $patientname',style: TextStyle(fontSize: 20.sp,color: Color(0xff202244),fontWeight: FontWeight.w600)),
            ),

              SizedBox(
                height: 20.h,
              ),

            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: CustomTextField(lname: 'Find Doctor', hname: 'doctor', bgcolor: Color(0xffF6F6F6),icon: Icons.search),
            ),



                  SizedBox(
                    height: 30.h,
                  ),

                  Expanded(
                    child: GridView.count(crossAxisCount: 2,

                      shrinkWrap: true,

                    children: homedata.map((value) {
                    
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            Get.to(()=> Categories(),transition:Transition.rightToLeftWithFade);
                          },
                          child: Container(
                            width: 155.w,
                            height: 137.h,
                            decoration: BoxDecoration(
                              color: value['color'],
                              borderRadius: BorderRadius.circular(20),
                            ),

                            child:Column(
                              children: [
                                SizedBox(
                                  height:20.h
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(value['icon'],size: 30,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(value['text'],style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white
                                  ),),
                                )
                              ],
                            ),

                          ),
                        ),
                      );
                    
                    }).toList(),
                    
                    
                    ),
                  ),



                SizedBox(
                    width: 330.w,
                    height: 52.h,
                    child: CustomRoundButton(btname: 'See All Categories', btcolor: Color(0xff18A0FB),onPressed: (){

                      Get.to(()=> Categories(),transition:Transition.rightToLeftWithFade);

                    },))











          ]
        )
      ),
    );
  }
}
