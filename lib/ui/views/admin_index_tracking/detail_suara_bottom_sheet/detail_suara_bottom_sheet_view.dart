import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/themes/app_colors.dart';
import '../../../../app/themes/app_text.dart';
import './detail_suara_bottom_sheet_view_model.dart';

class DetailSuaraBottomSheetView extends StatelessWidget {
  final SheetRequest? request;
  final Function(SheetResponse)? completer;

  const DetailSuaraBottomSheetView({
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailSuaraBottomSheetViewModel>.reactive(
      viewModelBuilder: () => DetailSuaraBottomSheetViewModel(),
      onViewModelReady: (DetailSuaraBottomSheetViewModel model) async {
        await model.init(request!);
      },
      builder: (
        BuildContext context,
        DetailSuaraBottomSheetViewModel model,
        Widget? child,
      ) {
        return SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.topCenter,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Text(
                  request!.title!,
                  style: italicTextStyle.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: warningColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Jumlah Suara: ${model.counter}',
                            style: boldTextStyle,
                          ),
                          const SizedBox(height: 10),
                          if (model.isBusy)
                            const Center(child: CircularProgressIndicator()),
                          if (!model.isBusy &&
                              model.status == true &&
                              model.counter > 0)
                            for (var i = 0; i < model.counter; i++)
                              Card(
                                child: ListTile(
                                  // leading is datetime dummy
                                  leading: Text(model.myFunction
                                      .convertDateTime2(
                                          model.listPemilih[i].createdAt!)),
                                  title: Text(
                                    model.listPemilih[i].namaPemilih!,
                                    style: boldTextStyle,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (request!.description == 'Caleg')
                                        CardWidget(
                                            title: 'Tim',
                                            value: model
                                                .listPemilih[i].namaTimSurvei!),
                                      CardWidget(
                                          title: 'Kec',
                                          value:
                                              model.listPemilih[i].kecamatan!),
                                      CardWidget(
                                          title: 'Kel / Desa',
                                          value:
                                              model.listPemilih[i].kelurahan!),
                                      CardWidget(
                                          title: 'TPS',
                                          value: model.listPemilih[i].tps!
                                              .toString()),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.info_outline,
                                      color: mainColor,
                                    ),
                                    onPressed: () {
                                      model.showDetailPemilih(
                                        model.listPemilih[i],
                                      );
                                    },
                                  ),
                                ),
                              ),
                          if (!model.isBusy &&
                              model.status == true &&
                              model.counter == 0)
                            const Center(
                              child: Text(
                                'Belum ada data',
                                style: boldTextStyle,
                              ),
                            ),
                          if (!model.isBusy && model.status == false)
                            const Center(
                              child: Text(
                                'Error: Gagal mengambil data dari server',
                                style: boldTextStyle,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: italicTextStyle.copyWith(
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Expanded(
          flex: 1,
          child: Text(
            ' : ',
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            value,
            style: boldTextStyle.copyWith(
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
