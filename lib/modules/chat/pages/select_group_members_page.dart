import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/helpers/widgets/appbar_widget.dart';
import 'package:messenger/helpers/widgets/button_widget.dart';

import 'package:messenger/helpers/widgets/sized_widgets.dart';
import 'package:messenger/helpers/widgets/snakbars.dart';
import 'package:messenger/modules/chat/pages/create_group_page.dart';

import '../widgets/select_contact_widget.dart';

class SelectGroupMembersPage extends StatelessWidget {
  const SelectGroupMembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            children: [
              AppbarWidget(title: "اعضای گروه را انتخاب کنید"),
              H(15),
              Expanded(
                  child: SelectContactWidget(isMultiple: true,onSelectMultiple: (users) {
                    if (users.isNotEmpty) {
                      Get.to(CreateGroupPage(users: users));
                    } else {
                      showErrorMessage("لطفا حداقل یک عضو را انتخاب کند"); 
                    }
                  })),
              H(15),
            ]
        ),
      ),
    );
  }
}