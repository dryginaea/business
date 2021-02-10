class ErrorVersion {
  String version;
  bool critical;

  ErrorVersion(this.version, this.critical);

  factory ErrorVersion.fromJson(Map<String, dynamic> json) {
    return ErrorVersion(json['version'].toString(), json['critical']);
  }
}