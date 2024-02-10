import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/modules/chat/controllers/chat_controllers.dart';
import 'package:messenger/modules/chat/controllers/socket_controller.dart';
import 'package:messenger/modules/chat/widgets/record_buttom_sheet.dart';
import '../../../helpers/widgets/sized_widgets.dart';

class SendBoxWidget extends StatefulWidget {
  const SendBoxWidget({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<SendBoxWidget> createState() => _SendBoxWidgetState();
}

class _SendBoxWidgetState extends State<SendBoxWidget> {

  bool _isTyping = false;

  int get conversationId => Get.find<ChatController>().id;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15))
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleIcon(icon: FeatherIcons.mic, onTap: () {
            showModalBottomSheet(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
              context: context,
              builder: (context) => RecordButtomSheet(),
            );
          },),
          W(10),
          CircleIcon(icon: FeatherIcons.paperclip, onTap: () {
            Get.find<ChatController>().selectImage();
          },),
          W(10),
          CircleIcon(icon: FeatherIcons.send, onTap: () {
            Get.find<ChatController>().sendMessage();
          },),
          W(15),
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              onChanged: (value) {
                if (!_isTyping) {
                  _isTyping = true;
                  setState(() {});
                  Get.find<SocketController>().startTyping(conversationId);
                  Future.delayed(Duration(seconds: 4)).then((value) {
                    _isTyping = false;
                    Get.find<SocketController>().stopTyping(conversationId);
                    setState(() {});
                  });
                }
              },
              decoration: InputDecoration(
                  isDense: true,
                  hintText: "پیام خود را بنویسید ..."
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RecordBottomSheet {
}

class CircleIcon extends StatelessWidget {
  const CircleIcon({super.key, required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: context.theme.colorScheme.secondaryContainer
          ),
          child: Center(child: Icon(icon, size: 18,),),
        ),
      ),
    );
  }
}
