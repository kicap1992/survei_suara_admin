// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedBottomsheetGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/views/admin_index_tracking/halaman_caleg/coba_bottom_sheet/coba_bottom_sheet_view.dart';

enum BottomSheetType {
  cobaBottomSheetView,
}

void setupBottomSheetUi() {
  final bottomsheetService = locator<BottomSheetService>();

  final Map<BottomSheetType, SheetBuilder> builders = {
    BottomSheetType.cobaBottomSheetView: (context, request, completer) =>
        CobaBottomSheetView(request: request, completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
