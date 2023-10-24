class AreaListModel {
  List<AreaModel>? area;
  int? jumlah;

  AreaListModel({this.area, this.jumlah});

  AreaListModel.fromJson(Map<String, dynamic> json) {
    if (json['area'] != null) {
      area = <AreaModel>[];
      json['area'].forEach((v) {
        area!.add(AreaModel.fromJson(v));
      });
    }
    jumlah = json['jumlah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (area != null) {
      data['area'] = area!.map((v) => v.toJson()).toList();
    }
    data['jumlah'] = jumlah;
    return data;
  }
}

class AreaModel {
  int? idArea;
  String? namaArea;

  AreaModel({this.idArea, this.namaArea});

  AreaModel.fromJson(Map<String, dynamic> json) {
    idArea = json['id_area'];
    namaArea = json['nama_area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_area'] = idArea;
    data['nama_area'] = namaArea;
    return data;
  }
}
