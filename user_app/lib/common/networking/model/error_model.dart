/// Common error model for API requests
class Error {
  String? message;

  Error({message});

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(message: json['message']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{'message': message};
    return data;
  }
}
