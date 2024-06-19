// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// class EmptyCard extends StatelessWidget {
//   final double? width;
//   final double? height;
//
//   const EmptyCard({
//     Key? key,
//     this.width,
//     this.height,
//   }) : super(key: key);
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     var categoriesdata = [
//       {
//         'color':Colors.green
//       },
//       {
//         'color':Colors.red
//       },
//
//       {
//         'color':Colors.yellow
//       },
//
//       {
//         'color':Colors.blue
//       },
//
//       {
//         'color':Colors.purple
//       },
//
//     ];
//
//     return ListView(
//       children: categoriesdata.map((value) => Container(
//         width: width,
//           height: height,
//           margin:  EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
//           decoration:  BoxDecoration(
//             color: value['color'] ,
//            // color: Colors.blue,
//
//             borderRadius: BorderRadius.all(Radius.circular(4.0)),
//
//            // image: DecorationImage(image: AssetImage('assets/images/images.jpg'),fit: BoxFit.cover),
//             boxShadow: <BoxShadow>[
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 4.0,
//                 offset: Offset(0.0, 4.0),
//               ),
//             ],
//           ),
//       )).toList(),
//     );
//
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmptyCard extends StatelessWidget {
  final double? width;
  final double? height;
  final AssetImage image;



  const EmptyCard({
    Key? key,
    this.width,
    this.height,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: BoxDecoration(
        image: DecorationImage(image: image,fit: BoxFit.fill),
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      ),

    );
  }
}