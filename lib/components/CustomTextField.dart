import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomTextField extends StatelessWidget {
  final String lname;
  final String hname;
  final Color bgcolor;
  final TextEditingController? controller;
  final IconData? icon;



  CustomTextField({
    required this.lname,
    required this.hname,
    required this.bgcolor,
    this.controller,
    this.icon,

  });




  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 330.w,
        height: 52.h,
        child: TextField(
          controller: controller,
          style: TextStyle(fontSize: 20.sp,color: Colors.black),
          decoration: InputDecoration(
            suffixIcon: icon != null ? Icon(icon, size: 20.sp) : null,
            suffixStyle: TextStyle(fontSize: 20.sp),
            contentPadding: EdgeInsets.only(left: 10),
            enabledBorder: OutlineInputBorder(
              borderSide:
              BorderSide( color: Colors.white10),
              borderRadius: BorderRadius.circular(4.0),
            ),
            labelText: lname,
            hintText: hname,
            filled: true,
            fillColor: bgcolor,

            labelStyle: TextStyle(fontSize: 15.sp,fontFamily: 'Poppins',color: Color(0xff202244)),
          ),
        ),
      ),
    ) ;
  }
}
