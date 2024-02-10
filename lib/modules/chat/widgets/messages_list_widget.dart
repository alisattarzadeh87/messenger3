import 'package:flutter/material.dart';
import 'package:messenger/backend/models/message.dart';
import 'package:messenger/modules/chat/widgets/message_items/image_message.dart';
import 'package:messenger/modules/chat/widgets/message_items/text_message.dart';
import 'package:messenger/modules/chat/widgets/message_items/voice_message.dart';

class MessagesListWidget extends StatelessWidget {
  const MessagesListWidget({super.key, required this.messages, required this.isGroup, required this.scrollController});

  final List<Message> messages;
  final bool isGroup;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.all(18),
      itemCount: messages.length,
      reverse: true,
      itemBuilder: (context, index) {
        var message =  messages[index];
        if(message.type == "TEXT"){
          return TextMessage(message: message, isGroup: isGroup,);
        } else if(message.type == "IMAGE"){
          return ImageMessage(message: message, isGroup: isGroup);
        } else {
          return VoiceMessage(message: message, isGroup: isGroup,);
        }
      },
    );
  }
}


