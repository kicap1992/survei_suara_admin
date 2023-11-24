import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../app/app.bottomsheets.dart';
import '../../../../../app/app.logger.dart';
import '../../../../../app/core/custom_base_view_model.dart';
import '../../../../../model/caleg_model.dart';
import '../../../../../model/tim_survei_model.dart';

class TambahDetailTimSurveiViewModel extends CustomBaseViewModel {
  final log = getLogger('TambahDetailTimSurveiViewModel');

  // form variabel
  final formKey = GlobalKey<FormState>();
  TextEditingController nikController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController namaCalegController = TextEditingController();

  TimSurveiModel? timSurveiModel;

  // list caleg
  List<CalegModel> listCalegModel = [];
  List<String> listCalegString = [];
  String? selectedCaleg;
  int? selectedCalegId;

  Future<void> init(data) async {
    globalVar.backPressed = 'exitApp';
    timSurveiModel = data;
    if (timSurveiModel != null) {
      nikController.text = timSurveiModel!.nik!;
      namaController.text = timSurveiModel!.nama!;
      namaCalegController.text = timSurveiModel!.namaCaleg!;
    } else {
      await getData();
    }
  }

  getData() async {
    setBusy(true);
    try {
      var response = await httpService.get('caleg');
      // log.i(response.data);
      CalegListModel calegListModel =
          CalegListModel.fromJson(response.data['data']);
      listCalegModel = calegListModel.caleg!;
      for (var element in listCalegModel) {
        listCalegString.add(element.namaCaleg!);
      }
      selectedCaleg = listCalegString[0];
      selectedCalegId = listCalegModel[0].idCaleg;
    } catch (e) {
      log.e(e);
    } finally {
      setBusy(false);
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
        'id_caleg': selectedCalegId,
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

  checkSuara(TimSurveiModel timSurveiModel) async {
    await bottomSheetService.showCustomSheet(
      data: timSurveiModel.nik,
      barrierDismissible: true,
      isScrollControlled: true,
      title: 'Detail Suara Tim Survei ${timSurveiModel.nama}',
      description: 'Tim Survei',
      ignoreSafeArea: false,
      variant: BottomSheetType.detailSuaraBottomSheetView,
    );
  }
}
