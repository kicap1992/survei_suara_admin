// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedBottomsheetGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/views/admin_index_tracking/detail_suara_bottom_sheet/detail_suara_bottom_sheet_view.dart';
import '../ui/views/admin_index_tracking/detail_suara_pemilih_bottom_sheet/detail_suara_pemilih_bottom_sheet_view.dart';

enum BottomSheetType {
  detailSuaraBottomSheetView,
  detailSuaraPemilihBottomSheetView,
}

void setupBottomSheetUi() {
  final bottomsheetService = locator<BottomSheetService>();

  final Map<BottomSheetType, SheetBuilder> builders = {
    BottomSheetType.detailSuaraBottomSheetView: (context, request, completer) =>
        DetailSuaraBottomSheetView(request: request, completer: completer),
    BottomSheetType.detailSuaraPemilihBottomSheetView:
        (context, request, completer) => DetailSuaraPemilihBottomSheetView(
            request: request, completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
