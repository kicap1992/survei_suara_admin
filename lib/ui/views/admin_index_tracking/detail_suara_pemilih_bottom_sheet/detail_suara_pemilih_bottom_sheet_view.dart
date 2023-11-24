import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../app/themes/app_colors.dart';
import '../../../../../app/themes/app_text.dart';
import './detail_suara_pemilih_bottom_sheet_view_model.dart';

class DetailSuaraPemilihBottomSheetView extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse)? completer;

  const DetailSuaraPemilihBottomSheetView({
    Key? key,
    required this.request,
    this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailSuaraPemilihBottomSheetViewModel>.reactive(
      viewModelBuilder: () => DetailSuaraPemilihBottomSheetViewModel(),
      onViewModelReady: (DetailSuaraPemilihBottomSheetViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        DetailSuaraPemilihBottomSheetViewModel model,
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
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    request.title!,
                    style: boldTextStyle.copyWith(
                      fontSize: 16,
                      color: fontColor,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        model.showImage(
                          context,
                          dotenv.env['url']! + request.data!.img!,
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          dotenv.env['url']! + request.data!.img!,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.error,
                                color: backgroundColor,
                                size: 50,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  _DetailChildWidget(
                    title: 'Nama',
                    value: request.data!.namaPemilih!,
                  ),
                  _DetailChildWidget(
                    title: 'No KTP /\nNo HP',
                    value: request.data!.nikNomorHp!,
                  ),
                  _DetailChildWidget(
                    title: 'Tanggal/\nWaktu',
                    value: model.myFunction
                        .convertDateTime2(request.data!.createdAt!),
                  ),
                  _DetailChildWidget(
                      title: 'Caleg', value: request.data!.namaCaleg!),
                  _DetailChildWidget(
                    title: 'Tim Survei',
                    value: request.data!.namaTimSurvei!,
                  ),
                  _DetailChildWidget(
                    title: 'Kecamatan',
                    value: request.data!.kecamatan!,
                  ),
                  _DetailChildWidget(
                    title: 'Kelurahan',
                    value: request.data!.kelurahan!,
                  ),
                  _DetailChildWidget(
                    title: 'TPS',
                    value: request.data!.tps!.toString(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DetailChildWidget extends StatelessWidget {
  const _DetailChildWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: boldTextStyle.copyWith(
                fontSize: 16,
                color: fontColor,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              ' : ',
              style: boldTextStyle.copyWith(
                fontSize: 16,
                color: fontColor,
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              value,
              style: italicTextStyle.copyWith(
                fontSize: 16,
                color: fontColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
