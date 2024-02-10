import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/modules/auth/controllers/login_controller.dart';

import '../../../helpers/widgets/button_widget.dart';
import '../../../helpers/widgets/input_widget.dart';
import '../../../helpers/widgets/sized_widgets.dart';
import '../../home/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: context.theme.colorScheme.primaryContainer,
          body: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  H(40),
                  Image.asset(
                    context.isDarkMode
                        ? "assets/images/logo_dark.png"
                        : "assets/images/logo_light.png",
                    height: 130,
                  ),
                  H(40),
                  Text(
                    "ورود",
                    style: context.textTheme.titleLarge,
                  ),
                  H(15),
                  Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                          color: context.theme.scaffoldBackgroundColor,
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(24.0),
                          child: Form(
                            key: controller.formkey,
                            child: Column(
                              children: [
                                InputWidget(
                                    hint: 'شماره موبایل',
                                    icon: FeatherIcons.phone,
                                    type: TextInputType.phone,
                                controller: controller.request.mobile,
                                validator: controller.request.mobileValidator,),
                                H(15),
                                InputWidget(
                                  hint: 'رمز عبور',
                                  type: TextInputType.visiblePassword,
                                  controller: controller.request.password,
                                  validator: controller.request.passwordValidator,),
                                H(35),
                                ButtonWidget(
                                    text: 'ورود',
                                    onPressed: controller.login,
                                loading: controller.loading,)
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
