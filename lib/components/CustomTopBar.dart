import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomTopBar extends StatelessWidget {
  final String text;


  CustomTopBar({
    required this.text,

});
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        SizedBox(
          height: 50.h,
        ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [


        InkWell(
            onTap: (){
              Get.back();
            },
            child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Icon(Icons.arrow_back_rounded,size: 20.sp,)
            )),
        Text(text as String,style: TextStyle(fontSize: 20.sp,color: Color(0xff202244),fontWeight: FontWeight.w600),),

        SizedBox(
          width: 20.w,
        )
      ],
    ),
    ],
    );
  }

}
