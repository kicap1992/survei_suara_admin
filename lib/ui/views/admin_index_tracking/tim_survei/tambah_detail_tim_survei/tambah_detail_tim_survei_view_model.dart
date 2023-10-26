import 'package:cek_suara/model/tim_survei_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../app/app.logger.dart';
import '../../../../../app/core/custom_base_view_model.dart';

class TambahDetailTimSurveiViewModel extends CustomBaseViewModel {
  final log = getLogger('TambahDetailTimSurveiViewModel');

  // form variabel
  final formKey = GlobalKey<FormState>();
  TextEditingController nikController = TextEditingController();
  TextEditingController namaController = TextEditingController();

  TimSurveiModel? timSurveiModel;

  Future<void> init(data) async {
    globalVar.backPressed = 'exitApp';
    timSurveiModel = data;
    if (timSurveiModel != null) {
      nikController.text = timSurveiModel!.nik!;
      namaController.text = timSurveiModel!.nama!;
    }
  }

  Future<bool> tambahTimSurvei() async {
    globalVar.backPressed = 'cantBack';
    setBusy(true);
    easyLoading.customLoading('Menambahkan Tim Survei...');

    try {
      var formData = FormData.fromMap({
        'nik': nikController.text,
        'nama': namaController.text,
      });
      var response = await httpService.postWithFormData('survei', formData);
      log.i(response.data);
      return true;
    } catch (e) {
      // log.e(e);
      // snackbarService.showSnackbar(
      //   message: 'Gagal menambahkan Tim Survei\n${e.res}',
      //   title: 'Error',
      //   duration: const Duration(seconds: 2),
      // );
      return false;
    } finally {
      globalVar.backPressed = 'exitApp';
      easyLoading.dismissLoading();
      setBusy(false);
    }
  }
}
