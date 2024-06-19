class Notifications {
  final String patientname;
  final String doctor_name;
  final String timing;


  Notifications({
    required this.patientname,
    required this.doctor_name,
    required this.timing

  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      patientname: json['patientname'] ?? 'N/A',
      doctor_name: json['doctor_name'] ?? 'N/A',
      timing: json['timing'] ?? 'N/A',

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'patientname': patientname,
      'doctor_name': doctor_name,
      'timing': timing,
    };
  }

}