import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/helpers/theme_helper.dart';
import 'package:messenger/helpers/user_helper.dart';
import 'package:messenger/helpers/widgets/profile_name_widget.dart';
import 'package:messenger/helpers/widgets/sized_widgets.dart';
import 'package:messenger/modules/chat/pages/create_message_page.dart';
import 'package:messenger/modules/chat/pages/select_group_members_page.dart';

import '../pages/edit_profile_page.dart';
import 'logout_dialog.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: GetBuilder<UserHelper>(
              // no need to be init, it is initialized in "main" before.
              builder: (controller) {
                return controller.user == null ? Container(): Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            ThemeHelper.changeTheme();
                            Navigator.pop(context); // Close the drawer
                          },
                            child: Icon(context.isDarkMode ? FeatherIcons.sun : FeatherIcons.moon),
                        )
                    ),
                    controller.user!.avatar == null ?
                    ProfileNameWidget(name: controller.user!.name!) :
                    ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.network(controller.user!.avatar!,
                        height: 95,width: 95, fit: BoxFit.cover,),
                    ),
                    H(10),
                    Text(controller.user!.name!, style: context.textTheme.titleSmall,),
                    H(30),
                    DrawerItem(text: "ایجاد پیام جدید", icon: FeatherIcons.user, onPressed: () => Get.to(CreateMessagePage()),),
                    DrawerItem(text: "ایجاد گروه جدید", icon: FeatherIcons.users, onPressed: () => Get.to(SelectGroupMembersPage()),),
                    DrawerItem(text: "ویرایش پروفایل", icon: FeatherIcons.edit3, onPressed: () => Get.to(EditProfilePage()),),
                    DrawerItem(text: "خروج از جساب", icon: FeatherIcons.logOut, hasBorder: false, onPressed: () {
                      showDialog(context: context, builder: (context) => logoutDialog(),);
                    },)
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}


class DrawerItem extends StatelessWidget {
  const DrawerItem({super.key, required this.text, required this.icon,  this.hasBorder = true, required this.onPressed});

  final String text;
  final IconData icon;
  final bool hasBorder;
  final VoidCallback onPressed;
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: hasBorder ? Border(bottom: BorderSide(width: 0.75, color: context.theme.dividerColor)) : null,
        ),
        child: Row(
          children: [
            Text(text, style:  context.textTheme.bodyMedium,),
            Spacer(),
            Icon(icon),
          ],
        ),
      ),
    );
  }
}
