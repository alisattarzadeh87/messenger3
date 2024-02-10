import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/helpers/user_helper.dart';
import 'package:messenger/helpers/widgets/button_widget.dart';
import 'package:messenger/helpers/widgets/sized_widgets.dart';

class logoutDialog extends StatelessWidget {
  const logoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("آیا برای خروج مطمئنید؟", style: context.textTheme.titleMedium,),
            H(20),
            Row(
              children: [
                Expanded(child: ButtonWidget(text: "خیر", onPressed: () => Get.back(), isSecondary: true,)),
                W(10),
                Expanded(child: ButtonWidget(text: "بله", onPressed: () => userHelper.logout())),
              ],
            )
          ],
        ),
      ),
    );
  }
}
