import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../../app/themes/app_colors.dart';
import '../../../../../app/themes/app_text.dart';
import '../../../../widgets/my_button.dart';
import '../../../../widgets/my_textformfield.dart';
import './tambah_edit_caleg_view_model.dart';

class TambahEditCalegView extends StatelessWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;

  const TambahEditCalegView({
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TambahEditCalegViewModel>.reactive(
      viewModelBuilder: () => TambahEditCalegViewModel(),
      onViewModelReady: (TambahEditCalegViewModel model) async {
        await model.init();
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
                      request?.data['title'] ?? '',
                    ),
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 10),
                    MyTextFormField(
                      hintText: 'Masukan Nama Caleg',
                      labelText: 'Nama Caleg',
                      controller: model.namaController,
                      validator: Validatorless.required(
                          'Nama Caleg tidak boleh kosong'),
                    ),
                    const SizedBox(height: 10),
                    MyTextFormField(
                      hintText: 'Area',
                      labelText: 'Pencarian Area',
                      controller: model.cariAreaController,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          // remove keyboard focus
                          FocusScope.of(context).unfocus();
                          model.cariArea();
                        },
                        child: const Icon(Icons.search),
                      ),

                      // controller: model.partaiController,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: double.infinity,

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
                                        value: model.listAreaId.contains(
                                            model.listAreaModel[index].idArea!),
                                        onChanged: (value) {
                                          model.tambahHapusArea(
                                            model.listAreaModel[index].idArea!,
                                          );
                                        },
                                      ),
                                      Expanded(
                                        child: Text(
                                          model.listAreaModel[index].namaArea!,
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
                            model.addCaleg();
                          }
                        },
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
