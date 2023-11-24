import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../../app/themes/app_colors.dart';
import '../../../../../app/themes/app_text.dart';
import '../../../../widgets/my_button.dart';
import '../../../../widgets/my_textformfield.dart';
import './tambah_edit_caleg_view_model.dart';

class TambahEditCalegView extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const TambahEditCalegView({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TambahEditCalegViewModel>.reactive(
      viewModelBuilder: () => TambahEditCalegViewModel(),
      onViewModelReady: (TambahEditCalegViewModel model) async {
        await model.init(request.data);
      },
      builder: (
        BuildContext context,
        TambahEditCalegViewModel model,
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
                    const SizedBox(height: 10),
                    if (model.calegModel == null)
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: fontParagraphColor,
                            child: model.imageBytes == null
                                ? const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.white,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.memory(
                                      model.imageBytes!,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: warningColor,
                              child: IconButton(
                                  onPressed: () {
                                    model.addImage();
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: fontColor,
                                    size: 15,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    if (model.calegModel != null)
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: fontParagraphColor,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            '${dotenv.env['api_url']}assets/caleg/${model.calegModel!.idCaleg}/${model.calegModel!.foto}',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.person,
                                size: 50,
                                color: greyBlueColor,
                              );
                            },
                          ),
                        ),
                      ),
                    const SizedBox(height: 10),
                    MyTextFormField(
                      hintText: 'Masukan Nama Caleg',
                      labelText: 'Nama Caleg',
                      controller: model.namaController,
                      readOnly: model.calegModel != null,
                      validator: Validatorless.required(
                          'Nama Caleg tidak boleh kosong'),
                    ),
                    const SizedBox(height: 10),
                    MyTextFormField(
                      hintText: 'Masukan Nomor Urut',
                      labelText: 'Nomor Urut',
                      controller: model.nomorUrutController,
                      readOnly: model.calegModel != null,
                      keyboardType: TextInputType.number,
                      validator: Validatorless.multiple(
                        // numbers only
                        [
                          Validatorless.required(
                              'Nomor Urut tidak boleh kosong'),
                          Validatorless.number('Nomor Urut harus berupa angka'),
                        ],
                      ),
                    ),
                    // if (model.calegModel == null) const SizedBox(height: 10),
                    // if (model.calegModel == null)
                    //   MyTextFormField(
                    //     hintText: 'Area',
                    //     labelText: 'Pencarian Area',
                    //     controller: model.cariAreaController,
                    //     // suffixIcon: GestureDetector(
                    //     //   onTap: () {
                    //     //     // remove keyboard focus
                    //     //     FocusScope.of(context).unfocus();
                    //     //     model.cariArea();
                    //     //   },
                    //     //   child: const Icon(Icons.search),
                    //     // ),

                    //     // controller: model.partaiController,
                    //   ),
                    const SizedBox(height: 20),
                    // create a horizontal divider

                    const Text("Pilih Kecamatan"),

                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: double.infinity,
                      // create a border
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      // create 10 random checkbox
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (model.isBusy)
                              const Center(child: CircularProgressIndicator()),
                            if (!model.isBusy && model.listAreaModel.isNotEmpty)
                              // FutureBuilder(future: , builder: builder)
                              Wrap(
                                spacing: 10,
                                children: List.generate(
                                  model.listAreaModel.length,
                                  (index) => Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                        value: model.listAreaId.contains(model
                                            .listAreaModel[index].kecamatanId!),
                                        onChanged: (value) {
                                          if (model.calegModel != null) return;
                                          model.tambahHapusArea(
                                            model.listAreaModel[index]
                                                .kecamatanId!,
                                          );
                                        },
                                      ),
                                      Expanded(
                                        child: Text(
                                          model.listAreaModel[index].name!,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            if (!model.isBusy && model.listAreaModel.isEmpty)
                              Center(
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: 'Tidak ada pencarian area\n',
                                    style: regularTextStyle,
                                    children: [
                                      TextSpan(
                                        text:
                                            ' ${model.cariAreaController.text}',
                                        style: boldTextStyle.copyWith(
                                          color: dangerColor,
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
                    const SizedBox(height: 10),
                    if (model.calegModel == null &&
                        request.title == 'Tambah Caleg')
                      SizedBox(
                        width: 250,
                        child: MyButton(
                          text: 'Tambah Caleg',
                          onPressed: () async {
                            if (model.listAreaId.isEmpty) {
                              model.snackbarService.showSnackbar(
                                message:
                                    'Pilih Area Calon Legislatif terlebih dahulu',
                                duration: const Duration(seconds: 2),
                              );
                              return;
                            }

                            if (model.imageBytes == null) {
                              model.snackbarService.showSnackbar(
                                message:
                                    'Pilih Foto Calon Legislatif terlebih dahulu',
                                duration: const Duration(seconds: 2),
                              );
                              return;
                            }

                            if (model.formKey.currentState!.validate()) {
                              // remove keyboard focus
                              FocusScope.of(context).unfocus();
                              model.dialogService
                                  .showDialog(
                                title: 'Tambah Caleg',
                                description:
                                    'Apakah anda yakin ingin menambah caleg ${model.namaController.text} ?',
                                buttonTitle: 'Ya',
                                cancelTitle: 'Batal',
                              )
                                  .then((value) async {
                                if (value!.confirmed) {
                                  bool res = await model.addCaleg();
                                  model.log
                                      .i('ini di res bagian dalamnya: $res');
                                  if (res) {
                                    // ignore: use_build_context_synchronously
                                    // Navigator.of(context).pop();
                                    completer(DialogResponse(confirmed: true));
                                  }
                                  // if (res.confirmed) {
                                  // await model.addCaleg(completer!);
                                  // completer!(DialogResponse(confirmed: true));
                                }
                              });

                              // bool res = await model.addCaleg();
                              // model.log.i('ini di res bagian dalamnya: $res');
                              // if (res) {
                              //   // ignore: use_build_context_synchronously
                              //   Navigator.of(context).pop();
                              //   completer(DialogResponse(confirmed: true));
                              // }
                              // if (res.confirmed) {
                              // await model.addCaleg(completer!);
                              // completer!(DialogResponse(confirmed: true));
                            }
                          },
                        ),
                      ),
                    if (model.calegModel != null)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // create rounde icon with one is delete and one is info
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: IconButton(
                              onPressed: () {
                                model.checkSuara(model.calegModel!);
                              },
                              icon: const Icon(
                                Icons.list_alt,
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
              ),
            ),
          ),
        );
      },
    );
  }
}
