import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:get/get.dart';
import 'package:messenger/helpers/widgets/appbar_widget.dart';
import 'package:messenger/helpers/widgets/input_widget.dart';
import 'package:messenger/helpers/widgets/loading_widget.dart';
import 'package:messenger/helpers/widgets/profile_name_widget.dart';
import 'package:messenger/helpers/widgets/sized_widgets.dart';
import 'package:messenger/modules/chat/controllers/create_message_controller.dart';
import 'package:messenger/modules/chat/widgets/select_contact_widget.dart';

import '../../../backend/models/user.dart';
import '../controllers/select_contact_controller.dart';

class CreateMessagePage extends StatelessWidget {
  const CreateMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateMessageController>(
        init: CreateMessageController(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: Column(children: [
                AppbarWidget(title: "پیام جدید"),
                H(15),
                Expanded(
                  child: SelectContactWidget(
                    onSelect: (user) {
                      controller.createMessage(user.id!);
                    },
                  ),
                )
              ]),
            ),
          );
        });
  }
}
