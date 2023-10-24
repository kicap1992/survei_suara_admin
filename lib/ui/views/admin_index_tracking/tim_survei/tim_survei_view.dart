import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './tim_survei_view_model.dart';

class TimSurveiView extends StatelessWidget {
  const TimSurveiView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TimSurveiViewModel>.reactive(
      viewModelBuilder: () => TimSurveiViewModel(),
      onViewModelReady: (TimSurveiViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        TimSurveiViewModel model,
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
            child: const Center(
              child: Text(
                'TimSurveiView',
              ),
            ),
          ),
        );
      },
    );
  }
}
