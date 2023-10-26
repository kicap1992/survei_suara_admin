import '../../../../app/app.logger.dart';
import '../../../../app/core/custom_base_view_model.dart';
import '../../../../model/area_model.dart';
import '../../../../model/caleg_model.dart';
import '../../../../model/my_response.model.dart';
import '../../../../model/tim_survei_model.dart';

class AdminFirstPageViewModel extends CustomBaseViewModel {
  final log = getLogger('AdminFirstPageViewModel');

  // variabel
  int jumlahArea = 0;
  int jumlahCaleg = 0;
  int jumlahTimSurvei = 0;
  bool status = false;

  Future<void> init() async {
    globalVar.backPressed = 'exitApp';
    await getDataArea();
  }

  getDataArea() async {
    log.i('getData');
    setBusy(true);
    globalVar.backPressed = 'cantBack';
    try {
      var response = await httpService.get('area');
      log.i(response.data);
      MyResponseModel myResponseModel = MyResponseModel.fromJson(response.data);
      AreaListModel areaListModel =
          AreaListModel.fromJson(myResponseModel.data);
      jumlahArea = areaListModel.jumlah!;

      response = await httpService.get('caleg');
      log.i(response.data);
      myResponseModel = MyResponseModel.fromJson(response.data);
      CalegListModel calegListModel =
          CalegListModel.fromJson(myResponseModel.data);
      jumlahCaleg = calegListModel.jumlah!;

      response = await httpService.get('survei');
      myResponseModel = MyResponseModel.fromJson(response.data);
      TimSurveiListModel timSurveiListModel =
          TimSurveiListModel.fromJson(myResponseModel.data);
      jumlahTimSurvei = timSurveiListModel.jumlah!;
      status = true;
    } catch (e) {
      status = false;
      log.e(e);
    } finally {
      globalVar.backPressed = 'exitApp';
      setBusy(false);
    }
  }
}
