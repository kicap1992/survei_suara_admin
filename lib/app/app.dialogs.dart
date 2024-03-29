// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/views/admin_index_tracking/halaman_caleg/tambah_edit_caleg/tambah_edit_caleg_view.dart';
import '../ui/views/admin_index_tracking/tim_survei/tambah_detail_tim_survei/tambah_detail_tim_survei_view.dart';

enum DialogType {
  tambahEditCalegView,
  tambahDetailTimSurveiView,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.tambahEditCalegView: (context, request, completer) =>
        TambahEditCalegView(request: request, completer: completer),
    DialogType.tambahDetailTimSurveiView: (context, request, completer) =>
        TambahDetailTimSurveiView(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
