class Users {
  final int? userId;
  final String? fullName;

  final String email;

  final String password;

  Users({
    this.userId,
    this.fullName,
    required this.email,
    required this.password,
  });
  factory Users.fromjson(Map<String, dynamic> json) {
    return Users(
      userId: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
    );
  }
  Map<String, dynamic> tojson() => {
        'id': userId,
        'fullName': fullName,
        'email': email,
        'password': password,
      };
}
