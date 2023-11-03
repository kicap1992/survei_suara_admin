import 'package:cek_suara/app/themes/app_colors.dart';

// import '../../../../app/app.bottomsheets.dart';
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
  bool status = false;

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
      status = true;
    } catch (e) {
      log.e(e);
      status = false;
    } finally {
      globalVar.backPressed = 'exitApp';
      setBusy(false);
    }
  }

  addCaleg() async {
    // log.i('addCaleg');
    // await bottomSheetService.showCustomSheet(
    //   variant: BottomSheetType.cobaBottomSheetView,
    //   title: 'Tambah Caleg',
    // );
    var res = await dialogService.showCustomDialog(
      variant: DialogType.tambahEditCalegView,
      title: 'Tambah Caleg',
    );

    if (res!.confirmed) {
      snackbarService.showSnackbar(
        message: 'Caleg berhasil ditambahkan',
        title: 'Berhasil',
        duration: const Duration(seconds: 3),
      );
      await getData();
    }
  }

  deleteCaleg(CalegModel calegModel) {
    dialogService
        .showDialog(
      title: 'Hapus Caleg',
      description:
          'Apakah anda yakin ingin menghapus caleg ${calegModel.namaCaleg} ?',
      buttonTitle: 'Hapus',
      cancelTitle: 'Batal',
      buttonTitleColor: dangerColor,
      cancelTitleColor: mainColor,
    )
        .then((value) async {
      if (value!.confirmed) {
        setBusy(true);
        easyLoading.customLoading('Menghapus Caleg...');
        try {
          var response =
              await httpService.delete('caleg/${calegModel.idCaleg}');
          log.i(response.data);
          await getData();
          snackbarService.showSnackbar(
            message: 'Caleg berhasil dihapus',
            title: 'Berhasil',
            duration: const Duration(seconds: 3),
          );
        } catch (e) {
          log.e(e);
        } finally {
          easyLoading.dismissLoading();
          setBusy(false);
        }
      }
    });
  }

  showDetailCaleg(CalegModel calegModel) async {
    var res = await dialogService.showCustomDialog(
      variant: DialogType.tambahEditCalegView,
      title: 'Detail Caleg',
      data: calegModel,
    );

    // log.i('res ini: ${res!.confirmed}');
    if (res!.confirmed) {
      await deleteCaleg(calegModel);
    }
  }
}
