import 'package:flutter/material.dart';

import '../../../app/app.router.dart';

import '../../../app/app.logger.dart';
import '../../../app/core/custom_base_view_model.dart';

class LoginScreenViewModel extends CustomBaseViewModel {
  bool isPasswordVisible = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final log = getLogger('LoginScreenViewModel');
  Future<void> init() async {
    globalVar.backPressed = 'backNormal';
  }

  login() async {
    easyLoading.customLoading('Login..');
    if (usernameController.text == 'admin' &&
        passwordController.text == 'admin123') {
      await Future.delayed(const Duration(seconds: 2));
      easyLoading.dismissLoading();
      globalVar.backPressed = 'backNormal';
      // navigationService.pushNamedAndRemoveUntil('/home-screen');
      await navigationService.navigateToAdminIndexTrackingView();
    } else {
      await Future.delayed(const Duration(seconds: 2));
      easyLoading.dismissLoading();
      globalVar.backPressed = 'backNormal';
      snackbarService.showSnackbar(
        message: 'Username atau Password salah',
        title: 'Login Gagal',
        duration: const Duration(seconds: 2),
      );
    }
  }
}
