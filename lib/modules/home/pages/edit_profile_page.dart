import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:messenger/helpers/widgets/appbar_widget.dart';

import '../../../helpers/widgets/button_widget.dart';
import '../../../helpers/widgets/input_widget.dart';
import '../../../helpers/widgets/sized_widgets.dart';
import 'home_page.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppbarWidget(title: "ویرایش پروفایل"),
            SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  InputWidget(hint: 'نام و نام خانوادگی'),
                  H(15),
                  InputWidget(hint: 'شماره موبایل'),
                  H(15),
                  InputWidget(hint: 'رمز عبور', type: TextInputType.visiblePassword,),
                  H(15),
                  InputWidget(hint: 'تکرار رمز عبور',type: TextInputType.visiblePassword,),
                  H(15),
                  InputWidget(hint: 'انتخاب عکس پروفایل', disabled: true,),
                  H(25),
                  ButtonWidget(text: 'ویرایش', onPressed: () => Get.to(HomePage()))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
