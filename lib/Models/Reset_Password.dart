class Password{
  final String email;


Password({required this.email});

  factory Password.fromJson(Map<String, dynamic> json) {
    return Password(
      email: json['email'],

    );
  }

}