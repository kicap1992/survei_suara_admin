import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../../app/app.logger.dart';
import '../../../../../app/core/custom_base_view_model.dart';

import 'package:image_picker/image_picker.dart';

import '../../../../../model/area_model.dart';
import '../../../../../model/caleg_model.dart';
import '../../../../../model/my_response.model.dart';

class TambahEditCalegViewModel extends CustomBaseViewModel {
  final log = getLogger('TambahEditCalegViewModel');

  // variabel list area
  List<AreaModel> listAreaModel = [];
  List<AreaModel> allListAreaModel = [];

  // form variable
  final formKey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController cariAreaController = TextEditingController();
  TextEditingController nomorUrutController = TextEditingController();
  List<int> listAreaId = [];

  // image picker
  String? _imagePath;
  final ImagePicker _picker = ImagePicker();
  XFile? imageFile;
  Uint8List? imageBytes;

  CalegModel? calegModel;

  Future<void> init(data) async {
    globalVar.backPressed = 'exitApp';
    await getData();
    calegModel = data;
    if (calegModel != null) {
      namaController.text = calegModel!.namaCaleg!;
      nomorUrutController.text = calegModel!.nomorUrutCaleg!.toString();
      getAreaList(calegModel!.idCaleg!);
      // listAreaId = calegModel!.area!.map((e) => e.id!).toList();
    }
    log.i(data);
  }

  getAreaList(int idCaleg) async {
    log.i('getAreaList');
    setBusy(true);
    globalVar.backPressed = 'cantBack';
    try {
      var response = await httpService.get('caleg/relasi_area/$idCaleg');
      log.i(response.data);
      MyResponseModel myResponseModel = MyResponseModel.fromJson(response.data);
      var data = myResponseModel.data['area'];
      for (var item in data) {
        listAreaId.add(item['id_area']);
      }
      listAreaModel = [];
      for (var item in allListAreaModel) {
        if (listAreaId.contains(item.idArea)) {
          listAreaModel.add(item);
        }
      }

      log.i('listAreaModel: $listAreaModel');

      // log.i('jumlahArea: $jumlahArea');
    } catch (e) {
      log.e(e);
    } finally {
      globalVar.backPressed = 'exitApp';
      setBusy(false);
    }
  }

  getData() async {
    log.i('getData');
    setBusy(true);
    globalVar.backPressed = 'cantBack';
    try {
      var response = await httpService.get('area');
      log.i(response.data);
      MyResponseModel myResponseModel = MyResponseModel.fromJson(response.data);
      AreaListModel areaListModel =
          AreaListModel.fromJson(myResponseModel.data);
      listAreaModel = areaListModel.area!;
      allListAreaModel = areaListModel.area!;
      // jumlahArea = areaListModel.jumlah!;

      log.i('listAreaModel: $listAreaModel');
      // log.i('jumlahArea: $jumlahArea');
    } catch (e) {
      log.e(e);
    } finally {
      globalVar.backPressed = 'exitApp';
      setBusy(false);
    }
  }

  void addImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imageFile = image;
        _imagePath = image.path;
        imageBytes = await image.readAsBytes();

        log.i('image path: $_imagePath');
        notifyListeners();
      }
    } catch (e) {
      log.e(e);
    }
  }

  tambahHapusArea(int idArea) {
    log.i('tambahHapusArea');
    if (listAreaId.contains(idArea)) {
      listAreaId.remove(idArea);
    } else {
      listAreaId.add(idArea);
    }

    notifyListeners();
  }

  cariArea() {
    log.i('cariArea ${cariAreaController.text}');

    if (cariAreaController.text.isEmpty) {
      listAreaModel = allListAreaModel;
      return;
    }

    listAreaModel = allListAreaModel
        .where((element) => element.namaArea!
            .toLowerCase()
            .contains(cariAreaController.text.toLowerCase()))
        .toList();

    notifyListeners();
  }

  Future<bool> addCaleg() async {
    log.i('addCaleg');
    setBusy(true);
    globalVar.backPressed = 'cantBack';
    easyLoading.customLoading('Tambah Caleg..');

    var formData = FormData.fromMap({
      'nama': namaController.text,
      'nomor_urut': nomorUrutController.text,
      'area': const JsonEncoder().convert(listAreaId),
      'foto': await MultipartFile.fromFile(
        imageFile!.path,
        filename: imageFile!.name,
        contentType: MediaType('image', 'jpeg'),
      )
    });

    try {
      var response = await httpService.postWithFormData('caleg', formData);
      log.i(response.data);
      // await getData();

      // navigationService.back();
      // navigationService.back();
      // snackbarService.showSnackbar(
      //   message: 'Berhasil menambahkan Caleg',
      //   duration: const Duration(seconds: 2),
      // );
      // completer(DialogResponse(confirmed: true));
      return true;
      // navigationService.popRepeated(2);
    } catch (e) {
      log.e(e);
      return false;
    } finally {
      easyLoading.dismissLoading();
      globalVar.backPressed = 'exitApp';
      setBusy(false);
      // navigationService.back();
      // Navigator.of(context!).pop();
      // remove all dialog
    }
  }
}
