class Doctor_Profile{

  final String name;
  final String patients;
  final String experience;
  final String rating;
  final String about_doctor;

  Doctor_Profile({
    required this.name,
    required this.patients,
    required this.experience,
    required this.rating,
    required this.about_doctor

});

  factory Doctor_Profile.fromJson(Map<String, dynamic> json) {
    return Doctor_Profile(
      name: json['doc_name'] ?? 'N/A',
      patients: json['patients'] ?? 'N/A',
      experience: json['experience'] ?? 'N/A',
      rating: json['rating'] ?? 'N/A',
      about_doctor: json['about_doctor'] ?? 'N/A'

    );
  }



}