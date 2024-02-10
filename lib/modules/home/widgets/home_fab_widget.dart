import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:messenger/modules/chat/pages/create_message_page.dart';
import 'package:messenger/modules/chat/pages/select_group_members_page.dart';

class HomeFabWidget extends StatelessWidget {
  const HomeFabWidget({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: HawkFabMenu(
        closeIcon: FeatherIcons.edit,
        openIcon: FeatherIcons.edit3,
        fabColor: context.theme.colorScheme.secondary,
        iconColor: Colors.white,
        backgroundColor: Colors.transparent,
        blur: 0,
        items: [
          HawkFabMenuItem(
            label: 'پیام جدید',
            ontap: () => Get.to(CreateMessagePage()),
            icon: const Icon(FeatherIcons.user, size: 18,),
            color: context.theme.colorScheme.primary,
            labelBackgroundColor: Color(0xFFD4E5FF),
            labelColor:Colors.black
          ),
          HawkFabMenuItem(
            label: 'گروه جدید',
              ontap: () => Get.to(SelectGroupMembersPage()),
            icon: const Icon(FeatherIcons.users, size: 18,),
            color: context.theme.colorScheme.primary,
            labelBackgroundColor: Color(0xFFD4E5FF),
            labelColor:Colors.black
          ),
        ],
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: body,
        ),
      ),
    );
  }
}
