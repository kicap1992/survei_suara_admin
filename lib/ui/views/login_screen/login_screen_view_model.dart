import '../../../app/app.router.dart';

import '../../../app/app.logger.dart';
import '../../../app/core/custom_base_view_model.dart';

class LoginScreenViewModel extends CustomBaseViewModel {
  final log = getLogger('LoginScreenViewModel');
  Future<void> init() async {
    globalVar.backPressed = 'backNormal';
  }

  login() async {
    easyLoading.customLoading('Login..');
    globalVar.backPressed = 'cantBack';
    await Future.delayed(const Duration(seconds: 2));
    easyLoading.dismissLoading();
    globalVar.backPressed = 'backNormal';
    // navigationService.pushNamedAndRemoveUntil('/home-screen');
    await navigationService.navigateToAdminIndexTrackingView();
  }
}
