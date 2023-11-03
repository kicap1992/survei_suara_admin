import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import './coba_bottom_sheet_view_model.dart';

class CobaBottomSheetView extends StatelessWidget {
  final SheetRequest? request;
  final Function(SheetResponse)? completer;

  const CobaBottomSheetView({
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CobaBottomSheetViewModel>.reactive(
      viewModelBuilder: () => CobaBottomSheetViewModel(),
      onViewModelReady: (CobaBottomSheetViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        CobaBottomSheetViewModel model,
        Widget? child,
      ) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: const Text('Coba Bottom Sheet'),
          ),
        );
      },
    );
  }
}
