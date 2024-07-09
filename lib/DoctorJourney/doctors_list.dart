import 'dart:convert';
import 'package:cinema_app/DoctorJourney/Doctors_Info.dart';
import 'package:cinema_app/Models/Doctor.dart';
import 'package:cinema_app/Notifications/Notifications.dart';
import 'package:cinema_app/components/CustomTopBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:searchfield/searchfield.dart';


class DoctorsList extends StatefulWidget {

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {

  late Future<List<Doctor>> doctors_list;
  List<String> suggestions = [];
  final TextEditingController searchController = TextEditingController();
  @override

  void initState() {
    super.initState();
    final int argument = Get.arguments;
    doctors_list = fetchDoctors(argument);

  }

  Future<List<Doctor>> fetchDoctors(int id) async {
    final url = Uri.parse('http://localhost:3030  /read/details');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'id': id}),
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Doctor> doctors= body.map((dynamic item) => Doctor.fromJson(item)).toList();
      suggestions = doctors.map((doctor) => doctor.name).toList();
      return doctors;
    } else {
      throw Exception('Failed to load doctors');
    }
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      body: FutureBuilder<List<Doctor>>(
        future: doctors_list,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No doctors found'));
          } else {
            return Column(

              children:AnimateList(
                interval: 400.ms,
                effects: [FadeEffect(duration: 300.ms)],
           children: [
                CustomTopBar(text: 'Select'),

                  SizedBox(
                    height: 20.h,
                  ),


                Search(context),


                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Doctor doctor = snapshot.data![index];
                      return Column(
                        children: [


                          SizedBox(
                            height: 15.h,
                          ),
                          Container(
                            width: 325.w,
                            height: 88.h,
                            color: Colors.white,
                            child: Center(
                              child: ListTile(

                                leading: CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/doctor.png'),
                                  radius: 25.h,

                                  backgroundColor: Color(0xff18A0FB),
                                ),
                                title: Text(doctor.name,style :TextStyle(fontSize: 18.sp,color: Color(0xff202244),fontWeight: FontWeight.w600,)),
                                subtitle: Text(doctor.speciality),
                                trailing: InkWell(
                                    onTap: (){
                                      Get.to(() => doctors_profile(), arguments: doctor.name);
                                      // Get.to(() => Notification_Screen(), arguments: doctor.name);

                                    },
                                    child: Icon(Icons.add_circle_rounded,size: 30.sp,)),
                                onTap: (){},
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
              )
            );
          }
        },
      ),
    );

  }

  Widget Search(BuildContext context){
    Widget searchChild(x) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
      child: Text(x, style: TextStyle(fontSize: 18, color: Colors.black)),
    );
    return  Padding(
      padding: const EdgeInsets.all(25.0),
      child: SearchField(

        suggestionDirection: SuggestionDirection.flex,
        onSearchTextChanged: (query) {
          final filter = suggestions
              .where((element) =>
              element.toLowerCase().contains(query.toLowerCase()))
              .toList();
          return filter
              .map((e) =>
              SearchFieldListItem<String>(e, child: searchChild(e)))
              .toList();
        },
        //initialValue: SearchFieldListItem<String>('John Doe'),
        controller: searchController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || !suggestions.contains(value.trim())) {
            return 'No Doctor Available';
          }
          return null;
        },
        onSubmit: (x) {},
        autofocus: false,
        key: const Key('searchfield'),
        hint: 'Search by Doctor Name',

        itemHeight: 50,
        onTapOutside: (x) {
          // focus.unfocus();
        },

        scrollbarDecoration: ScrollbarDecoration(
          thickness: 12,
          radius: Radius.circular(6),
          trackColor: Colors.grey,
          trackBorderColor: Colors.red,
          thumbColor: Colors.orange,
        ),
        suggestionStyle:
        const TextStyle(fontSize: 18, color: Colors.black),
        searchStyle: TextStyle(fontSize: 18, color: Colors.black),
        suggestionItemDecoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade200,
              width: 1,
            ),
          ),
        ),
        searchInputDecoration: InputDecoration(
          prefixIcon: Icon(Icons.search,color: Color(0xff979797),),
          suffixIcon: Icon(Icons.filter_list_sharp,color: Color(0xff202244),),
          hintStyle: TextStyle(fontSize: 13, color: Color(0xff979797),fontWeight: FontWeight.w600),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(
              width: 1,
              color: Color(0xff18A0FB),
              style: BorderStyle.solid,
            ),
          ),
          border: OutlineInputBorder(

            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
              color: Color(0xff202244),
              style: BorderStyle.solid,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
        ),
        suggestionsDecoration: SuggestionDecoration(
          // border: Border.all(color: Colors.orange),
            elevation: 8.0,
            selectionColor: Colors.grey.shade100,
            hoverColor: Colors.purple.shade100,

            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )),
        suggestions: suggestions
            .map((e) =>
            SearchFieldListItem<String>(e, child: searchChild(e)))
            .toList(),
        suggestionState: Suggestion.expand,
        onSuggestionTap: (SearchFieldListItem<String> x) {},
      ),
    );
  }
}

