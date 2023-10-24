class MyResponseModel {
  String? message;
  dynamic data;
  bool? status;

  MyResponseModel({this.message, this.data, this.status});

  MyResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['data'] = this.data;
    data['status'] = status;
    return data;
  }
}
