import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/backend/models/conversation.dart';
import 'package:messenger/helpers/widgets/loading_widget.dart';
import 'package:messenger/modules/chat/controllers/chat_controllers.dart';
import 'package:messenger/modules/chat/widgets/chat_appbar_widget.dart';
import 'package:messenger/modules/chat/widgets/messages_list_widget.dart';
import 'package:messenger/modules/chat/widgets/send_box_widget.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.conversation});

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.secondaryContainer,
      body: GetBuilder<ChatController>(
          init: ChatController(conversation.id!),
          builder: (controller) {
            return SafeArea(
              child: Column(
                children: [
                  ChatAppbarWidget(
                    conversation: conversation,
                    isTyping: controller.isTyping,
                    typingUsers: controller.typingUsers,
                  ),
                  Expanded(
                      child: controller.messages == null ?
                      Loading() :
                      MessagesListWidget(
                              scrollController: controller.scrollController,
                              messages: controller.messages!.reversed.toList(),
                              isGroup: conversation.type == "GROUP",
                            )
                  ),
                  SendBoxWidget(
                    controller: controller.txtMessage,
                  )
                ],
              ),
            );
          }),
    );
  }
}
