import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

import '../../../../../app/app.logger.dart';
import '../../../../../app/core/custom_base_view_model.dart';

class DetailSuaraPemilihBottomSheetViewModel extends CustomBaseViewModel {
  final log = getLogger('DetailSuaraPemilihBottomSheetViewModel');
  Future<void> init() async {}

  showImage(BuildContext context, String? url) async {
    log.i(url);
    showImageViewer(
      context,
      Image.network(
        url!,
        fit: BoxFit.fill,
      ).image,
      swipeDismissible: true,
      doubleTapZoomable: true,
    );
  }
}
