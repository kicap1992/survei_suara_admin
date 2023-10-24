class CalegListModel {
  List<CalegModel>? caleg;
  int? jumlah;

  CalegListModel({this.caleg, this.jumlah});

  CalegListModel.fromJson(Map<String, dynamic> json) {
    if (json['caleg'] != null) {
      caleg = <CalegModel>[];
      json['caleg'].forEach((v) {
        caleg!.add(CalegModel.fromJson(v));
      });
    }
    jumlah = json['jumlah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (caleg != null) {
      data['caleg'] = caleg!.map((v) => v.toJson()).toList();
    }
    data['jumlah'] = jumlah;
    return data;
  }
}

class CalegModel {
  int? idCaleg;
  String? namaCaleg;
  int? nomorUrutCaleg;
  String? foto;

  CalegModel({this.idCaleg, this.namaCaleg, this.nomorUrutCaleg, this.foto});

  CalegModel.fromJson(Map<String, dynamic> json) {
    idCaleg = json['id_caleg'];
    namaCaleg = json['nama_caleg'];
    nomorUrutCaleg = json['nomor_urut_caleg'];
    foto = json['foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_caleg'] = idCaleg;
    data['nama_caleg'] = namaCaleg;
    data['nomor_urut_caleg'] = nomorUrutCaleg;
    data['foto'] = foto;
    return data;
  }
}
