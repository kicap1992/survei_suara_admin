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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TopContainer(
                      title: 'Jumlah Area',
                      value: '10 Area',
                      icon: Icons.place_outlined,
                      background: warningColor,
                    ),
                    const SizedBox(height: 10),
                    const TopContainer(
                      title: 'Jumlah Caleg',
                      value: '10 Caleg',
                      icon: Icons.co_present_outlined,
                      background: greenColor,
                    ),
                    const SizedBox(height: 10),
                    const TopContainer(
                      title: 'Jumlah Pemilih',
                      value: '10 Pemilih',
                      icon: Icons.people_alt_outlined,
                      background: blueColor,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                            text: 'terlebih dahulu sebelum menambahkan data ',
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
