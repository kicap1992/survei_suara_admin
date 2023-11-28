import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/themes/app_colors.dart';
import '../../../../app/themes/app_text.dart';
import '../../../widgets/top_container.dart';
import './admin_first_page_view_model.dart';

class AdminFirstPageView extends StatelessWidget {
  const AdminFirstPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdminFirstPageViewModel>.reactive(
      viewModelBuilder: () => AdminFirstPageViewModel(),
      onViewModelReady: (AdminFirstPageViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        AdminFirstPageViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: WillPopScope(
            onWillPop: () async {
              // model.log.i('backPressed: ${model.globalVar.backPressed}');
              if (model.globalVar.backPressed == 'exitApp') {
                // model.back();
                model.quitApp(context);
              }
              return false;
            },
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TopContainer(
                      //   title: 'Jumlah\nArea',
                      //   value: '${model.jumlahArea} Area',
                      //   icon: Icons.place_outlined,
                      //   background: warningColor,
                      // ),
                      // const SizedBox(height: 10),
                      TopContainer(
                        title: 'Jumlah\nCaleg',
                        value: '${model.jumlahCaleg} Caleg',
                        icon: Icons.co_present_outlined,
                        background: greenColor,
                      ),
                      const SizedBox(height: 10),
                      TopContainer(
                        title: 'Tim\nSurvei',
                        value: '${model.jumlahTimSurvei} Tim Survei',
                        icon: Icons.co_present_outlined,
                        background: orangeColor,
                      ),
                      const SizedBox(height: 10),
                      TopContainer(
                        title: 'Jumlah\nPemilih',
                        value: '${model.jumlahPemilih} Pemilih',
                        icon: Icons.people_alt_outlined,
                        background: blueColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (model.isBusy)
                        const Center(child: CircularProgressIndicator()),
                      if (!model.isBusy && model.status == true)
                        RichText(
                          text: TextSpan(
                            text: 'Selamat Datang, ',
                            style: regularTextStyle,
                            children: [
                              const TextSpan(
                                text: 'Admin\n',
                                style: boldTextStyle,
                              ),
                              const TextSpan(
                                text: 'Silahkan tambahkan data ',
                                style: regularTextStyle,
                              ),
                              TextSpan(
                                text: 'Area ',
                                style: boldTextStyle.copyWith(
                                  color: greenColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const TextSpan(
                                text:
                                    'terlebih dahulu sebelum menambahkan data ',
                                style: regularTextStyle,
                              ),
                              TextSpan(
                                text: 'Caleg',
                                style: boldTextStyle.copyWith(
                                  color: greenColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const TextSpan(
                                text:
                                    '.\n\nData Pemilih akan diambil dari data yang dimasukkan oleh tim survei\n\n',
                                style: regularTextStyle,
                              ),
                              const TextSpan(
                                text:
                                    'Jika terjadi kesalahan pada data, silahkan hubungi ',
                                style: regularTextStyle,
                              ),
                            ],
                          ),
                        ),
                      if (!model.isBusy && model.status == false)
                        RichText(
                          text: TextSpan(
                            text: 'Selamat Datang, ',
                            style: regularTextStyle,
                            children: [
                              const TextSpan(
                                text: 'Admin\n',
                                style: boldTextStyle,
                              ),
                              const TextSpan(
                                text: 'Terjadi ',
                                style: regularTextStyle,
                              ),
                              TextSpan(
                                text: 'Error ',
                                style: boldTextStyle.copyWith(
                                  color: redColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const TextSpan(
                                text: 'pada saat mengambil data\n',
                                style: regularTextStyle,
                              ),
                              const TextSpan(
                                text: 'Silahkan coba lagi dengan menekan icon',
                                style: regularTextStyle,
                              ),
                              TextSpan(
                                text: ' Pengaturan\n',
                                style: boldTextStyle.copyWith(
                                  color: greenColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const TextSpan(
                                text: 'di pojok kanan bawah\n',
                                style: regularTextStyle,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // with setting icon
          floatingActionButton: FloatingActionButton(
            backgroundColor: warningColor,
            onPressed: () {
              // model.gotoSetting();
              model.snackbarService.showSnackbar(
                message: 'Fitur belum tersedia',
                duration: const Duration(seconds: 2),
              );
            },
            child: const Icon(Icons.settings, color: fontColor),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }
}
