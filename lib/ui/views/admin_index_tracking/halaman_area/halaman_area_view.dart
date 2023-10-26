import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../app/themes/app_colors.dart';
import '../../../widgets/my_button.dart';
import '../../../widgets/my_textformfield.dart';
import './halaman_area_view_model.dart';

class HalamanAreaView extends StatelessWidget {
  const HalamanAreaView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HalamanAreaViewModel>.reactive(
      viewModelBuilder: () => HalamanAreaViewModel(),
      onViewModelReady: (HalamanAreaViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        HalamanAreaViewModel model,
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
                child: Form(
                  key: model.formKey,
                  child: Column(
                    children: [
                      MyTextFormField(
                        hintText: 'Nama Area',
                        labelText: 'Nama Area',
                        controller: model.namaAreaController,
                        validator: Validatorless.required(
                            'Nama Area tidak boleh kosong'),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 250,
                        child: MyButton(
                          text: 'Tambah Area',
                          onPressed: () async {
                            if (model.formKey.currentState!.validate()) {
                              // close keyboard
                              FocusScope.of(context).unfocus();
                              bool res = await model.addArea();
                              model.log.i('res: $res');
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        flex: 3,
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
                            children: [
                              Text(
                                'Jumlah Area: ${model.jumlahArea} area',
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 10),
                              if (model.isBusy)
                                const Center(
                                    child: CircularProgressIndicator()),
                              if (!model.isBusy)
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        if (model.jumlahArea == 0)
                                          Center(
                                            child: model.status == true
                                                ? const Text(
                                                    'Belum ada area diinput')
                                                : const Text(
                                                    'Gagal mengambil data'),
                                          ),
                                        if (model.jumlahArea > 0)
                                          for (var i = 0;
                                              i < model.jumlahArea;
                                              i++)
                                            Card(
                                              child: ListTile(
                                                leading: Text('${i + 1}'),
                                                title: Text(
                                                    '${model.listAreaModel[i].namaArea}'),
                                                trailing: IconButton(
                                                  // trash bin icon
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    model.deleteArea(model
                                                        .listAreaModel[i]
                                                        .idArea!);
                                                  },
                                                ),
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
