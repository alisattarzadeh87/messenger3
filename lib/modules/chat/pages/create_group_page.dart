import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/helpers/widgets/appbar_widget.dart';
import 'package:messenger/helpers/widgets/input_widget.dart';
import 'package:messenger/helpers/widgets/sized_widgets.dart';
import 'package:messenger/modules/chat/controllers/create_group_controller.dart';
import 'package:messenger/modules/chat/widgets/select_contact_widget.dart';

import '../../../backend/models/user.dart';

class CreateGroupPage extends StatelessWidget {
  const CreateGroupPage({super.key, required this.users});

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateGroupController>(
      init: CreateGroupController(users),
      builder: (controller) {
        return Scaffold(
          floatingActionButton: Directionality(
            textDirection: TextDirection.ltr,
            child: FloatingActionButton(
              backgroundColor: context.theme.colorScheme.secondary,
              onPressed: controller.createConversation,
              child: Icon(FeatherIcons.check),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  AppbarWidget(title: "", hasPadding: false),
                  H(20),
                  GestureDetector(
                    onTap: () => controller.selectImage(),
                    child: controller.request.image == null ? Container(
                      height: 88,
                      width: 88,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: context.theme.colorScheme.secondaryContainer),
                      child: Center(child: Icon(FeatherIcons.camera, size: 32,)),
                    ) : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.file(controller.request.image!, height: 88,width: 88, fit: BoxFit.cover,),
                    ),
                  ),
                  H(20),
                  InputWidget(hint: "نام گروه را وارد کنید", controller: controller.request.name,),
                  H(10),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("${users.length } عضو", style: context.textTheme.titleSmall,)),
                  H(5),
                  Expanded(child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: users.length,
                    itemBuilder: (context, index) => ContactItem(user: users[index]),
                  )
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
