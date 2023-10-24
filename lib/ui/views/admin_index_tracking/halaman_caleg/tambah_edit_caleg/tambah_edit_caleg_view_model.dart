import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../../app/app.logger.dart';
import '../../../../../app/core/custom_base_view_model.dart';

import 'package:image_picker/image_picker.dart';

import '../../../../../model/area_model.dart';
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
  List<int> listAreaId = [];

  // image picker
  String? _imagePath;
  final ImagePicker _picker = ImagePicker();
  XFile? imageFile;
  Uint8List? imageBytes;

  Future<void> init() async {
    globalVar.backPressed = 'exitApp';
    await getData();
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

  addCaleg() async {
    dialogService
        .showDialog(
      title: 'Tambah Caleg',
      description:
          'Apakah anda yakin ingin menambahkan Caleg ${namaController.text}?',
      buttonTitle: 'Ya',
      cancelTitle: 'Tidak',
    )
        .then((value) async {
      if (value!.confirmed) {
        log.i('addCaleg');
        setBusy(true);
        globalVar.backPressed = 'cantBack';
        easyLoading.customLoading('Tambah Caleg..');

        var formData = FormData.fromMap({
          'nama': namaController.text,
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
          await getData();

          navigationService.back();
          // navigationService.back();
          snackbarService.showSnackbar(
            message: 'Berhasil menambahkan Caleg',
            duration: const Duration(seconds: 2),
          );
          // navigationService.popRepeated(2);
        } catch (e) {
          log.e(e);

          // navigationService.back();
          snackbarService.showSnackbar(
            message: 'Gagal menambahkan Caleg, ${e.toString()}',
            duration: const Duration(seconds: 2),
          );
        } finally {
          easyLoading.dismissLoading();
          globalVar.backPressed = 'exitApp';
          setBusy(false);
          // navigationService.back();
          // Navigator.of(context!).pop();
          // remove all dialog
        }
      }
    });
  }
}
