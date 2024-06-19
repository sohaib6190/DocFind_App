import 'package:firebase_auth/firebase_auth.dart';

class User_Form{
 final String patient_name;
 final int age;
 final String email;
 final String mobile_number;


 User_Form({
   required this.patient_name,
   required this.age,
   required this.email,
   required this.mobile_number
});


 factory User_Form.fromJson(Map<String, dynamic> json) {
   return User_Form(
       patient_name: json['pname'] ?? 'N/A',
       age: json['age'] ?? 'N/A',
       email: json['email'] ?? 'N/A',
       mobile_number: json['mobile_number'] ?? 'N/A'
   );
 }



}