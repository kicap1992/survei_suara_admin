class KecamatanDetail {
  List<KecamatanModel>? kecamatan;
  int? jumlah;

  KecamatanDetail({this.kecamatan, this.jumlah});

  KecamatanDetail.fromJson(Map<String, dynamic> json) {
    if (json['kecamatan'] != null) {
      kecamatan = <KecamatanModel>[];
      json['kecamatan'].forEach((v) {
        kecamatan!.add(KecamatanModel.fromJson(v));
      });
    }
    jumlah = json['jumlah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (kecamatan != null) {
      data['kecamatan'] = kecamatan!.map((v) => v.toJson()).toList();
    }
    data['jumlah'] = jumlah;
    return data;
  }
}

class KecamatanModel {
  String? kecamatanId;
  String? name;

  KecamatanModel({this.kecamatanId, this.name});

  KecamatanModel.fromJson(Map<String, dynamic> json) {
    kecamatanId = json['kecamatan_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kecamatan_id'] = kecamatanId;
    data['name'] = name;
    return data;
  }
}

class KelurahanDetail {
  List<KelurahanModel>? kelurahan;
  int? jumlah;

  KelurahanDetail({this.kelurahan, this.jumlah});

  KelurahanDetail.fromJson(Map<String, dynamic> json) {
    if (json['kelurahan'] != null) {
      kelurahan = <KelurahanModel>[];
      json['kelurahan'].forEach((v) {
        kelurahan!.add(KelurahanModel.fromJson(v));
      });
    }
    jumlah = json['jumlah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (kelurahan != null) {
      data['kelurahan'] = kelurahan!.map((v) => v.toJson()).toList();
    }
    data['jumlah'] = jumlah;
    return data;
  }
}

class KelurahanModel {
  String? kelurahanId;
  String? kecamatanId;
  String? name;

  KelurahanModel({this.kelurahanId, this.kecamatanId, this.name});

  KelurahanModel.fromJson(Map<String, dynamic> json) {
    kelurahanId = json['kelurahan_id'];
    kecamatanId = json['kecamatan_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kelurahan_id'] = kelurahanId;
    data['kecamatan_id'] = kecamatanId;
    data['name'] = name;
    return data;
  }
}
