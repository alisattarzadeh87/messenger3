import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/backend/models/message.dart';
import 'package:messenger/helpers/user_helper.dart';
import 'package:messenger/helpers/widgets/profile_name_widget.dart';
import 'package:messenger/helpers/widgets/sized_widgets.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({super.key, required this.message, required this.isGroup});

  final Message message;
  final bool isGroup; // for removing avatar in private chat

  bool get isSentMessage => message.senderId == userHelper.user?.id!;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(isSentMessage ? 0 : 15),
                    bottomLeft: Radius.circular(!isSentMessage ? 0 : 15)
                ),
                color: isSentMessage ?
                context.theme.colorScheme.primaryContainer : context.theme.scaffoldBackgroundColor),
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        constraints: BoxConstraints(maxWidth: 200), // for making 2 lines for long text
                        child:
                        message.type == "IMAGE" ? Image.network(message.file ?? "") :
                        Text(message.text ?? "")),
                    W(10),
                    Text(message.date ?? "", style: context.textTheme.bodySmall,),
                    Visibility(
                      visible: isSentMessage,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6,right: 6),
                        child: Icon(message.isSeen! ?  Icons.done_all : Icons.check, size: 14,),
                      ),
                    )

                  ],
                ),
              ],
            ),

          ),
          Visibility(
            visible: !isSentMessage && isGroup,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: message.senderAvatar == null
                  ? ProfileNameWidget(
                name: message.senderName ?? "",
                height: 42,
                width: 42,)
                  : ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: Image.network(message.senderAvatar!,
                  height: 42,
                  width: 42,
                  fit: BoxFit.cover,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
