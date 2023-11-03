import 'package:cek_suara/app/themes/app_colors.dart';
import 'package:cek_suara/app/themes/app_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

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
                                        Text(
                                          model.listPemilih[i].namaTimSurvei!,
                                          style: italicTextStyle,
                                        ),
                                      Text(
                                        model.listPemilih[i].namaArea!,
                                      ),
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
