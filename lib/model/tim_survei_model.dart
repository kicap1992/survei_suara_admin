import '../app/app.locator.dart';
import '../services/other_function.dart';

class TimSurveiListModel {
  List<TimSurveiModel>? survei;
  int? jumlah;

  TimSurveiListModel({this.survei, this.jumlah});

  TimSurveiListModel.fromJson(Map<String, dynamic> json) {
    if (json['survei'] != null) {
      survei = <TimSurveiModel>[];
      json['survei'].forEach((v) {
        survei!.add(TimSurveiModel.fromJson(v));
      });
    }
    jumlah = json['jumlah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (survei != null) {
      data['survei'] = survei!.map((v) => v.toJson()).toList();
    }
    data['jumlah'] = jumlah;
    return data;
  }
}

class TimSurveiModel {
  final myFunction = locator<MyFunction>();
  String? nik;
  String? nama;
  String? createdAt;

  TimSurveiModel({this.nik, this.nama, this.createdAt});

  TimSurveiModel.fromJson(Map<String, dynamic> json) {
    nik = json['nik'];
    nama = json['nama'];
    createdAt = myFunction.convertDateTime(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nik'] = nik;
    data['nama'] = nama;
    data['created_at'] = createdAt;
    return data;
  }
}
