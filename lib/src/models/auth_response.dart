class AuthResponse {
  String _status;
  String _otp;
  String _message;

  AuthResponse.fromJson(Map<String, dynamic> json) {
    _status = json['status'].toString();
    _otp = json['otp'] != null ? json['otp'].toString() : null;
    _message = json['message'] != null ? json['message'].toString() : null;
  }

  String get status => _status;

  String get otp => _otp;

  String get message => _message;
}
