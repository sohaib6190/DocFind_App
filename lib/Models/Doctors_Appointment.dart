class Doctor_Appointment {
  final String name;
  final String slot1;
  final String slot2;
  final String slot3;
  final String afternoon_slot1;
  final String afternoon_slot2;
  final int voice_call;
  final int video_call;


  Doctor_Appointment({
    required this.name,
    required this.slot1,
    required this.slot2,
    required this.slot3,
    required this.afternoon_slot1,
    required this.afternoon_slot2,
    required this.voice_call,
    required this.video_call
  });

  factory Doctor_Appointment.fromJson(Map<String, dynamic> json) {
    return Doctor_Appointment(
        name: json['doct_name'] ?? 'N/A',
        slot1: json['slot1'] ?? 'N/A',
        slot2: json['slot2'] ?? 'N/A',
        slot3: json['slot3'] ?? 'N/A',
        afternoon_slot1: json['afternoon_slot1'] ?? 'N/A',
        afternoon_slot2: json['afternoon_slot2'] ?? 'N/A',
        voice_call: json['voice_call'] ?? 'N/A',
        video_call: json['video_call'] ?? 'N/A'

    );
  }
}