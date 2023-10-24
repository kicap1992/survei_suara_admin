import '../../../../app/core/custom_base_view_model.dart';

class TimSurveiViewModel extends CustomBaseViewModel {
  Future<void> init() async {
    globalVar.backPressed = 'exitApp';
  }
}
