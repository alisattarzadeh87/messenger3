import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/helpers/widgets/profile_name_widget.dart';
import 'package:messenger/helpers/widgets/sized_widgets.dart';
import 'package:messenger/modules/chat/pages/chat_page.dart';

import '../../../backend/models/conversation.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({super.key, required this.conversations});

  final List<Conversation> conversations;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      itemCount: conversations.length,
      itemBuilder: (context, index) =>
          ChatItem(conversation: conversations[index]),
    );
  }
}

class ChatItem extends StatelessWidget {
  const ChatItem({super.key, required this.conversation});

  final Conversation conversation;

  String getMessageText() {
    if (conversation.lastMessage?.type == "TEXT") {
      return conversation.lastMessage?.text ?? ""; // اگر متن باشه، متن اون پیغامو بر میگردونه
    } else if (conversation.lastMessage?.type == "IMAGE") {
      return "عکس";
    } else {
      return "پیغام صوتی";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(ChatPage(
        conversation: conversation,
      )),
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: context.theme.dividerColor, width: 0.5)),
        ),
        child: Row(
          children: [
            conversation.image == null
                ? ProfileNameWidget(
                    name: conversation.name ?? "",
                    width: 55,
                    height: 55,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Image.network(
                      conversation.image!,
                      height: 55,
                      width: 55,
                      fit: BoxFit.cover,
                    ),
                  ),
            W(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    conversation.name ?? "",
                    style: context.textTheme.titleSmall,
                  ),
                  H(4),
                  Visibility(
                    visible: conversation.lastMessage != null,
                    child: Row(
                      children: [
                        Visibility(
                            visible: conversation.type == "GROUP",
                            child: Text(
                                "${conversation.lastMessage?.senderName} : ")),
                        Expanded(
                            child: Text(
                          conversation.lastMessage?.text ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodySmall,
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 55,
              width: 55,
              child: Column(
                children: [
                  Text(
                    conversation.lastMessage?.date ?? "",
                    style: context.textTheme.bodySmall,
                  ),
                  Spacer(),
                  Visibility(
                    visible: conversation.unreadCount! > 0,
                    child: Container(
                      width: 19,
                      height: 19,
                      decoration: BoxDecoration(
                          color: context.theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                          child: Text(conversation.unreadCount.toString(),
                              style: context.textTheme.bodySmall
                                  ?.apply(color: Colors.white))),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
