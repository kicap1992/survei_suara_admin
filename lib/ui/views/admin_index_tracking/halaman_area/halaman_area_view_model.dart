import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../app/app.logger.dart';
import '../../../../app/core/custom_base_view_model.dart';
import '../../../../app/themes/app_colors.dart';
import '../../../../model/area_model.dart';
import '../../../../model/my_response.model.dart';

class HalamanAreaViewModel extends CustomBaseViewModel {
  final log = getLogger('HalamanAreaViewModel');

  // variabel
  List<AreaModel> listAreaModel = [];
  int jumlahArea = 0;
  bool status = false;

  // add area form
  final formKey = GlobalKey<FormState>();
  TextEditingController namaAreaController = TextEditingController();

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
      jumlahArea = areaListModel.jumlah!;

      log.i('listAreaModel: $listAreaModel');
      log.i('jumlahArea: $jumlahArea');
      status = true;
    } catch (e) {
      status = false;
      log.e(e);
    } finally {
      globalVar.backPressed = 'exitApp';
      setBusy(false);
    }
  }

  Future<bool> addArea() async {
    log.i('addArea');
    setBusy(true);
    globalVar.backPressed = 'cantBack';
    easyLoading.customLoading('Tambah Area..');

    var formData = FormData.fromMap({
      'area': namaAreaController.text,
    });

    try {
      var response = await httpService.postWithFormData('area', formData);
      log.i(response.data);
      await getData();
      // reset form
      namaAreaController.clear();
      return true;
    } catch (e) {
      log.e(e);
      return false;
    } finally {
      easyLoading.dismissLoading();
      globalVar.backPressed = 'exitApp';
      setBusy(false);
    }
  }

  deleteArea(int idArea) {
    dialogService
        .showDialog(
      title: 'Hapus Area',
      description: 'Apakah Anda yakin ingin menghapus area ini?',
      buttonTitle: 'Hapus',
      cancelTitle: 'Batal',
      buttonTitleColor: dangerColor,
      cancelTitleColor: mainColor,
    )
        .then((value) async {
      if (value!.confirmed) {
        log.i('deleteArea id_area: $idArea');
        setBusy(true);
        globalVar.backPressed = 'cantBack';
        easyLoading.customLoading('Hapus Area..');

        try {
          var response = await httpService.delete('area/$idArea');
          log.i(response.data);
          await getData();
        } catch (e) {
          log.e(e);
        } finally {
          easyLoading.dismissLoading();
          globalVar.backPressed = 'exitApp';
          setBusy(false);
        }
      }
    });
  }
}
