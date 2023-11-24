import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:validatorless/validatorless.dart';

import '../../../app/themes/app_colors.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_textformfield.dart';
import './login_screen_view_model.dart';

class LoginScreenView extends StatelessWidget {
  const LoginScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginScreenViewModel>.reactive(
      viewModelBuilder: () => LoginScreenViewModel(),
      onViewModelReady: (LoginScreenViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        LoginScreenViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          backgroundColor: warningColor,
          body: WillPopScope(
            onWillPop: () async {
              model.log.i('backPressed: ${model.globalVar.backPressed}');
              if (model.globalVar.backPressed == 'backNormal') {
                // model.back();
                model.quitApp(context);
              }
              return false;
            },
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: SingleChildScrollView(
                  child: Form(
                    key: model.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: Image.asset(
                            'assets/logo.png',
                            width: 200,
                            height: 200,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Halaman Login',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextFormField(
                          controller: model.usernameController,
                          hintText: 'Username',
                          validator: Validatorless.required(
                              'Username tidak boleh kosong'),
                          // prefixIcon: Icons.person,
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyTextFormField(
                          controller: model.passwordController,
                          hintText: 'Password',
                          validator: Validatorless.required(
                              'Password tidak boleh kosong'),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              model.isPasswordVisible =
                                  !model.isPasswordVisible;
                            },
                            child: Icon(
                              model.isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: fontColor,
                            ),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 250,
                          child: MyButton(
                            // theBackgroundColor: lightColor,
                            textColor: fontColor,
                            text: 'Login',
                            onPressed: () {
                              if (model.formKey.currentState!.validate()) {
                                model.login();
                              }
                              // model.login();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
