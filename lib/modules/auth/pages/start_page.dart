import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/helpers/widgets/button_widget.dart';
import 'package:messenger/helpers/widgets/sized_widgets.dart';
import 'package:messenger/modules/auth/controllers/start_controller.dart';
import 'package:messenger/modules/auth/pages/register_page.dart';

import 'login_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartController>(
      init: StartController(),
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    Spacer(),
                    Image.asset(context.isDarkMode ? "assets/images/logo_dark.png" : "assets/images/logo_light.png"),
                    H(100),
                    ButtonWidget(text: 'ثبت نام', isSecondary: true, onPressed: () => Get.to (RegisterPage()),),
                    H(15),
                    ButtonWidget(text: 'ورود',onPressed: () => Get.to (LoginPage()),),
                    H(100),
                  ],
                ),
              ),
            ),
          )
        );
      }
    );
  }
}
