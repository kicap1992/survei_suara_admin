import '../../../../app/app.dialogs.dart';
import '../../../../app/app.logger.dart';
import '../../../../app/core/custom_base_view_model.dart';
import '../../../../model/caleg_model.dart';
import '../../../../model/my_response.model.dart';

class HalamanCalegViewModel extends CustomBaseViewModel {
  final log = getLogger('HalamanCalegViewModel');

  // variabel
  List<CalegModel> listCalegModel = [];
  int jumlahCaleg = 0;

  Future<void> init() async {
    globalVar.backPressed = 'exitApp';
    await getData();
  }

  getData() async {
    log.i('getData');
    setBusy(true);
    globalVar.backPressed = 'cantBack';
    try {
      var response = await httpService.get('caleg');
      log.i(response.data);
      MyResponseModel myResponseModel = MyResponseModel.fromJson(response.data);
      CalegListModel calegListModel =
          CalegListModel.fromJson(myResponseModel.data);
      listCalegModel = calegListModel.caleg!;
      jumlahCaleg = calegListModel.jumlah!;

      log.i('listCalegModel: $listCalegModel');
      log.i('jumlahCaleg: $jumlahCaleg');
    } catch (e) {
      log.e(e);
    } finally {
      globalVar.backPressed = 'exitApp';
      setBusy(false);
    }
  }

  addCaleg() async {
    // log.i('addCaleg');
    var res = await dialogService.showCustomDialog(
      variant: DialogType.tambahEditCalegView,
      data: {
        'title': 'Tambah Caleg',
      },
    );

    log.i(res?.confirmed);
  }
}
