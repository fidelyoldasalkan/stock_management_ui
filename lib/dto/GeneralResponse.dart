class GeneralResponse {
  String? status;
  String? errorCode;
  dynamic data;

  static GeneralResponse fromJson(Map<String, dynamic> json) {
    final generalResponse = GeneralResponse();
    generalResponse.data = json['data'];
    generalResponse.errorCode = json['errorCode'];
    generalResponse.status = json['status'];
    return generalResponse;
  }
}