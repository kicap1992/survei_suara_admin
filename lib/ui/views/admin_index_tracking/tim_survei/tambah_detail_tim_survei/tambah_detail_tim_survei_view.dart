import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../../app/themes/app_colors.dart';
import '../../../../widgets/my_button.dart';
import '../../../../widgets/my_textformfield.dart';
import './tambah_detail_tim_survei_view_model.dart';

class TambahDetailTimSurveiView extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const TambahDetailTimSurveiView({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TambahDetailTimSurveiViewModel>.reactive(
      viewModelBuilder: () => TambahDetailTimSurveiViewModel(),
      onViewModelReady: (TambahDetailTimSurveiViewModel model) async {
        await model.init(request.data);
      },
      builder: (
        BuildContext context,
        TambahDetailTimSurveiViewModel model,
        Widget? child,
      ) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: backgroundColor,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: model.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      request.title ?? '',
                    ),
                    const SizedBox(height: 15),
                    MyTextFormField(
                      hintText: 'NIK Tim Survei',
                      labelText: 'NIK Tim Survei',
                      keyboardType: TextInputType.number,
                      controller: model.nikController,
                      readOnly: model.timSurveiModel != null,
                      maxLength: 16,
                      validator: Validatorless.multiple(
                        [
                          Validatorless.required(
                              'NIK Tim Survei tidak boleh kosong'),
                          Validatorless.min(
                              16, 'NIK Tim Survei harus 16 digit'),
                          Validatorless.number(
                              'NIK Tim Survei harus berupa angka')
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    MyTextFormField(
                      hintText: 'Nama Tim Survei',
                      labelText: 'Nama Tim Survei',
                      readOnly: model.timSurveiModel != null,
                      controller: model.namaController,
                      validator: Validatorless.required(
                          'Nama Tim Survei tidak boleh kosong'),
                    ),
                    const SizedBox(height: 20),
                    if (model.timSurveiModel == null)
                      Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '  Pilih Caleg',
                            ),
                          ),
                          if (model.isBusy)
                            const LinearProgressIndicator(
                              minHeight: 5,
                              color: mainColor,
                            ),
                          if (!model.isBusy && model.listCalegModel.isNotEmpty)
                            Container(
                              width: double.infinity,
                              height: 60,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: sixthGrey,
                                ),
                              ),
                              child: Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: model.selectedCaleg!,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      onChanged: (String? newValue) {
                                        model.log.i(newValue);
                                        model.selectedCaleg = newValue!;
                                        model.selectedCalegId = model
                                            .listCalegModel
                                            .firstWhere((element) =>
                                                element.namaCaleg ==
                                                model.selectedCaleg)
                                            .idCaleg;

                                        model.log.i(model.selectedCalegId);

                                        model.notifyListeners();
                                      },
                                      items: model.listCalegString
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                              overflow: TextOverflow.ellipsis),
                                        );
                                      }).toList()),
                                ),
                              ),
                            ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    if (model.timSurveiModel == null)
                      SizedBox(
                        width: 200,
                        child: MyButton(
                          text: 'Tambah',
                          onPressed: () {
                            if (model.formKey.currentState!.validate()) {
                              model.dialogService
                                  .showConfirmationDialog(
                                title: 'Tambah Tim Survei',
                                description:
                                    'Apakah anda yakin ingin menambahkan Tim Survei ${model.namaController.text} ?',
                                confirmationTitle: 'Ya',
                                cancelTitle: 'Tidak',
                              )
                                  .then((value) async {
                                if (value!.confirmed) {
                                  bool res = await model.tambahTimSurvei();
                                  if (res) {
                                    completer(DialogResponse(confirmed: true));
                                  }
                                }
                              });
                            }
                          },
                        ),
                      ),
                    if (model.timSurveiModel != null)
                      Column(
                        children: [
                          MyTextFormField(
                            labelText: 'Caleg',
                            hintText: 'Caleg',
                            readOnly: true,
                            controller: model.namaCalegController,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // create rounde icon with one is delete and one is info
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: mainColor.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.list_alt_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: IconButton(
                                  onPressed: () async {
                                    completer(DialogResponse(confirmed: true));
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
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
