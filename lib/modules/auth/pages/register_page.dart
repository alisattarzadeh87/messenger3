import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/helpers/widgets/button_widget.dart';
import 'package:messenger/helpers/widgets/input_widget.dart';
import 'package:messenger/helpers/widgets/sized_widgets.dart';
import 'package:messenger/modules/auth/controllers/register_controller.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.primaryContainer,
      body: GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (controller) {
          return SafeArea(
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
                    "ثبت نام",
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
                                  hint: 'نام و نام خانوادگی',
                                  icon: FeatherIcons.user,
                                  controller: controller.request.name,
                                  validator: controller.request.nameValidator,
                                ),
                                H(15),
                                InputWidget(
                                    hint: 'شماره موبایل',
                                    icon: FeatherIcons.smartphone,
                                    type: TextInputType.phone,
                                    controller: controller.request.mobile,
                                  validator: controller.request.mobileValidator,

                                ),
                                H(15),
                                InputWidget(
                                  hint: 'رمز عبور',
                                  type: TextInputType.visiblePassword,
                                  controller: controller.request.password,
                                  validator: controller.request.passwordValidator,

                                ),
                                H(15),
                                InputWidget(
                                  hint: 'تکرار رمز عبور',
                                  type: TextInputType.visiblePassword,
                                  controller: controller.request.passwordConfirm,
                                  validator: controller.request.passwordConfirmValidator,
                                ),
                                H(15),
                                InputWidget(
                                  onTap: controller.selectImage,
                                  hint: 'انتخاب عکس پروفایل',
                                  icon: FeatherIcons.image,
                                  disabled: true,),
                                   Center(
                                       child: controller.request.avatar == null ?
                                       Container() :
                                       Padding(
                                         padding: const EdgeInsets.all(10.0),
                                         child: ClipRRect(
                                           borderRadius: BorderRadius.circular(100),
                                             child: Image.file(controller.request.avatar!, height: 90,width: 90, fit: BoxFit.cover,)),
                                       )),
                                H(25),
                                ButtonWidget(
                                    text: 'ثبت نام',
                                    loading: controller.loading,
                                    onPressed: controller.register,
                                )
                              ],
                            ),
                          ),
                        ),
                  )),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
