import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomRoundButton extends StatelessWidget {
  final String btname;
  final Color btcolor;
  final VoidCallback? onPressed;





  CustomRoundButton({
    required this.btname,
    required this.btcolor,
    this.onPressed,


  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(btname,style: TextStyle(color: Colors.white,fontSize: 15.sp,fontWeight: FontWeight.w600,fontFamily:'Poppins'),),
      ),

      style: ElevatedButton.styleFrom(

        backgroundColor: btcolor,
        elevation: 3,

        //shadowColor: Colors.blue,



      ),


    );

  }
}
