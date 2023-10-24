import 'package:cek_suara/app/themes/app_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/themes/app_colors.dart';
import '../../../widgets/top_container.dart';
import './halaman_caleg_view_model.dart';

class HalamanCalegView extends StatelessWidget {
  const HalamanCalegView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HalamanCalegViewModel>.reactive(
      viewModelBuilder: () => HalamanCalegViewModel(),
      onViewModelReady: (HalamanCalegViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        HalamanCalegViewModel model,
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
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TopContainer(
                      title: 'Jumlah Caleg',
                      value: '${model.jumlahCaleg} Caleg',
                      icon: Icons.co_present_outlined,
                      background: greenColor,
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      // flex: 3,
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          color: warningColor,
                        ),
                        child: Column(
                          // mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: model.isBusy
                              ? MainAxisAlignment.center
                              : (model.listCalegModel.isNotEmpty
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.center),
                          children: [
                            if (model.isBusy)
                              const LinearProgressIndicator(
                                minHeight: 5,
                                color: mainColor,
                              ),
                            if (!model.isBusy &&
                                model.listCalegModel.isNotEmpty)
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      for (var i = 0;
                                          i < model.jumlahCaleg;
                                          i++)
                                        Card(
                                          child: ListTile(
                                            leading: Text('${i + 1}'),
                                            title: Text(
                                              model
                                                  .listCalegModel[i].namaCaleg!,
                                              style: boldTextStyle,
                                            ),
                                            subtitle: Text(
                                              'No. Urut: ${model.listCalegModel[i].nomorUrutCaleg!}',
                                              style: italicTextStyle,
                                            ),
                                            trailing: IconButton(
                                              icon: const Icon(Icons.edit,
                                                  color: mainColor),
                                              onPressed: () {},
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            if (!model.isBusy && model.listCalegModel.isEmpty)
                              const Center(
                                child: Text(
                                  'Tidak ada data caleg diinput sebelumnya',
                                  style: italicTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              model.addCaleg();
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
