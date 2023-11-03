import '../app/app.locator.dart';
import '../services/other_function.dart';

class PemilihDetailModel {
  List<PemilihModel>? pemilihModel;
  int? jumlah;

  PemilihDetailModel({this.pemilihModel, this.jumlah});

  PemilihDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      pemilihModel = <PemilihModel>[];
      json['data'].forEach((v) {
        pemilihModel!.add(PemilihModel.fromJson(v));
      });
    }
    jumlah = json['jumlah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pemilihModel != null) {
      data['data'] = pemilihModel!.map((v) => v.toJson()).toList();
    }
    data['jumlah'] = jumlah;
    return data;
  }
}

class PemilihModel {
  final myFunction = locator<MyFunction>();

  String? nikNomorHp;
  String? namaPemilih;
  String? img;
  String? nikTimSurvei;
  String? namaTimSurvei;
  String? namaCaleg;
  String? namaArea;
  String? createdAt;

  PemilihModel(
      {this.nikNomorHp,
      this.namaPemilih,
      this.img,
      this.nikTimSurvei,
      this.namaTimSurvei,
      this.namaCaleg,
      this.namaArea,
      this.createdAt});

  PemilihModel.fromJson(Map<String, dynamic> json) {
    nikNomorHp = json['nik_nomor_hp'];
    namaPemilih = json['nama_pemilih'];
    img = json['img'];
    nikTimSurvei = json['nik_tim_survei'];
    namaTimSurvei = json['nama_tim_survei'];
    namaCaleg = json['nama_caleg'];
    namaArea = json['nama_area'];
    createdAt = myFunction.convertDateTime(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nik_nomor_hp'] = nikNomorHp;
    data['nama_pemilih'] = namaPemilih;
    data['img'] = img;
    data['nik_tim_survei'] = nikTimSurvei;
    data['nama_tim_survei'] = namaTimSurvei;
    data['nama_caleg'] = namaCaleg;
    data['nama_area'] = namaArea;
    data['created_at'] = createdAt;
    return data;
  }
}
