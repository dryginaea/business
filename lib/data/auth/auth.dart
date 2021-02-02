class Auth {
  final bool status;
  final String message;
  final String token;

  Auth({this.status, this.message, this.token});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
        status: json['status'],
        message: json['message'],
        token: json['token']
    );
  }
}