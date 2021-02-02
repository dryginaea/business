class CheckPhoneInDB {
  final bool status;
  final String message;
  final String http_code;

  CheckPhoneInDB({this.status, this.message, this.http_code});

  factory CheckPhoneInDB.fromJson(Map<String, dynamic> json) {
    return CheckPhoneInDB(
      status: json['status'],
      message: json['message'].toString(),
      http_code: json['http_code'].toString()
    );
  }
}