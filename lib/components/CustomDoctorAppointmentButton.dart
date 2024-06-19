import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDocAppButton extends StatefulWidget {

  final String? textinfo;
  final VoidCallback? onPressed;


  CustomDocAppButton({
     this.textinfo,
    this.onPressed,

  });





  @override
  State<CustomDocAppButton> createState() => _CustomDocAppButtonState();
}

class _CustomDocAppButtonState extends State<CustomDocAppButton> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onPressed,
        onHover: (hovering) {
          setState(() => isHovering = hovering);
        },
        child: Container(
          width: 102.w,
          height:33.h ,
          decoration: BoxDecoration(
            // color: widget.color,
            color: isHovering ? Colors.white : Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
          ),
          child: Center(
            child: Text(widget.textinfo ?? '',style: TextStyle(fontSize: 15.sp,color: Color(0xff979797),
                fontWeight: FontWeight.w600),),
          ),
        ),
      ),
    );
  }
}