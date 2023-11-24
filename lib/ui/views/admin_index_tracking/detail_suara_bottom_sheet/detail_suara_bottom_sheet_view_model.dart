import '../../../../app/app.bottomsheets.dart';
import '../../../../app/app.logger.dart';
import '../../../../app/core/custom_base_view_model.dart';
import '../../../../model/my_response.model.dart';
import '../../../../model/pemilih_model.dart';

class DetailSuaraBottomSheetViewModel extends CustomBaseViewModel {
  final log = getLogger('DetailSuaraBottomSheetViewModel');
  bool status = false;

  List<PemilihModel> listPemilih = [];
  int counter = 0;

  Future<void> init(sheetRequest) async {
    String id = sheetRequest.data.toString();
    String status = sheetRequest.description;

    await getData(id, status);
  }

  getData(String id, String status) async {
    setBusy(true);

    try {
      // var response = await httpService.get('caleg/suara/$id');
      var response = await httpService
          .get('${status == 'Caleg' ? 'caleg' : 'survei'}/suara/$id');
      MyResponseModel myResponseModel = MyResponseModel.fromJson(response.data);
      PemilihDetail pemilihDetail =
          PemilihDetail.fromJson(myResponseModel.data);

      log.i(pemilihDetail.pemilihModel!);

      listPemilih = pemilihDetail.pemilihModel!;
      counter = pemilihDetail.jumlah!;
      this.status = true;
    } catch (e) {
      this.status = false;
    } finally {
      setBusy(false);
    }
  }

  showDetailPemilih(PemilihModel listPemilih) async {
    await bottomSheetService.showCustomSheet(
      variant: BottomSheetType.detailSuaraPemilihBottomSheetView,
      title: 'Detail Suara Pemilih',
      description: 'Detail Suara Pemilih',
      // isScrollControlled: true,
      data: listPemilih,
    );
  }
}
