import '../../../../app/app.dialogs.dart';
import '../../../../app/app.logger.dart';
import '../../../../app/core/custom_base_view_model.dart';
import '../../../../app/themes/app_colors.dart';
import '../../../../model/my_response.model.dart';
import '../../../../model/tim_survei_model.dart';

class TimSurveiViewModel extends CustomBaseViewModel {
  final log = getLogger('TimSurveiViewModel');

  // variabel
  List<TimSurveiModel> listTimSurveiModel = [];
  int jumlahTimSurvei = 0;
  bool status = false;

  Future<void> init() async {
    globalVar.backPressed = 'exitApp';
    await getData();
  }

  getData() async {
    setBusy(true);
    // easyLoading.showLoading();
    // globalVar.backPressed = 'cantBack';
    try {
      var response = await httpService.get('survei');
      MyResponseModel myResponseModel = MyResponseModel.fromJson(response.data);
      TimSurveiListModel timSurveiListModel =
          TimSurveiListModel.fromJson(myResponseModel.data);
      listTimSurveiModel = timSurveiListModel.survei!;
      jumlahTimSurvei = timSurveiListModel.jumlah!;
      log.i('listTimSurveiModel: $listTimSurveiModel');
      log.i('jumlahTimSurvei: $jumlahTimSurvei');
      status = true;
    } catch (e) {
      log.e(e.toString());
      status = false;
    } finally {
      setBusy(false);
      // globalVar.backPressed = 'exitApp';
      // easyLoading.dismissLoading();
    }
  }

  addTimSurvei() async {
    var res = await dialogService.showCustomDialog(
      variant: DialogType.tambahDetailTimSurveiView,
      title: 'Tambah Tim Survei',
    );

    if (res!.confirmed) {
      await getData();
      snackbarService.showSnackbar(
        message: 'Berhasil menambahkan Tim Survei\nPassword default: 12345678',
        title: 'Sukses',
        duration: const Duration(seconds: 2),
      );
    }
  }

  deleteTimSurvei(TimSurveiModel listTimSurveiModel) async {
    dialogService
        .showDialog(
      title: 'Hapus Tim Survei',
      description:
          'Apakah anda yakin ingin menghapus ${listTimSurveiModel.nama} ?',
      buttonTitle: 'Hapus',
      cancelTitle: 'Batal',
      buttonTitleColor: dangerColor,
      cancelTitleColor: mainColor,
    )
        .then((value) async {
      if (value!.confirmed) {
        await httpService.delete('survei/${listTimSurveiModel.nik}');
        await getData();
        snackbarService.showSnackbar(
          message: 'Berhasil menghapus ${listTimSurveiModel.nama}',
          title: 'Sukses',
          duration: const Duration(seconds: 2),
        );
      }
    });
  }

  showDetailTimSurvei(TimSurveiModel listTimSurveiModel) async {
    var res = await dialogService.showCustomDialog(
      variant: DialogType.tambahDetailTimSurveiView,
      title: 'Detail Tim Survei',
      data: listTimSurveiModel,
    );

    if (res!.confirmed) {
      deleteTimSurvei(listTimSurveiModel);
    }
  }
}
