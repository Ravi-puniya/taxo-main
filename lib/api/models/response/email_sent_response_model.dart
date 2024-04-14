import 'dart:convert';

EmailSentResponseModel emailSentResponseModelFromJson(String str) {
  return EmailSentResponseModel.fromJson(json.decode(str));
}

String emailSentResponseModelToJson(EmailSentResponseModel data) {
  return json.encode(data.toJson());
}

class EmailSentResponseModel {
  EmailSentResponseModel({
    required this.success,
  });

  bool success;

  factory EmailSentResponseModel.fromJson(Map<String, dynamic> json) {
    return EmailSentResponseModel(
      success: json["success"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
    };
  }
}
