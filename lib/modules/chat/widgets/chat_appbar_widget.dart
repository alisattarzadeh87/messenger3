import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/backend/models/conversation.dart';
import 'package:messenger/backend/models/user.dart';
import 'package:messenger/helpers/widgets/sized_widgets.dart';

import '../../../helpers/widgets/profile_name_widget.dart';

class ChatAppbarWidget extends StatelessWidget {
  const ChatAppbarWidget({super.key, required this.conversation, this.isTyping = false, this.typingUsers});

  final Conversation conversation;
  final bool isTyping;
  final List<User>? typingUsers;

  String getTypingText() {
    if(typingUsers!.length == 1) {
      return "${typingUsers!.first.name} در حال نوشتن است";
    }
    return "${typingUsers!.length > 1} کاربران در حال نوشتن هستند";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      child: Row(
        children: [
          conversation.image == null ? ProfileNameWidget(name: conversation.name ?? "", height: 42, width: 42,) :
          ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: Image.network(conversation.image!, height: 42,width: 42, fit: BoxFit.cover,),
          ),
          W(10),
          Row(
            children: [
              Text(conversation.name ?? "", style: context.textTheme.titleMedium,),
              Visibility(
                visible: isTyping && conversation.type == "PRIVATE",
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text("در حال نوشتن ..." ?? "", style: context.textTheme.bodySmall,),
                ),
              ),
              Visibility(
                visible: typingUsers!.isNotEmpty && conversation.type == "GROUP",
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(getTypingText(), style: context.textTheme.bodySmall,),
                ),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
              onTap: Get.back,
              child: Icon(FeatherIcons.arrowRight))
        ],
      ),
    );
  }
}
