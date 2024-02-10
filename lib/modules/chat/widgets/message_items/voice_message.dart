import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:messenger/backend/models/message.dart';
import 'package:messenger/helpers/user_helper.dart';
import 'package:messenger/helpers/widgets/profile_name_widget.dart';
import 'package:messenger/helpers/widgets/sized_widgets.dart';

class VoiceMessage extends StatefulWidget {
  const VoiceMessage({super.key, required this.message, required this.isGroup});

  final Message message;
  final bool isGroup;

  @override
  State<VoiceMessage> createState() => _VoiceMessageState();
}

class _VoiceMessageState extends State<VoiceMessage> {
  bool get isSentMessage => widget.message.senderId == userHelper.user?.id!;

  final player = AudioPlayer();
  Duration? duration;
  Duration? currentDuration;

  Future<void> initAudioPlayer() async {
    duration = await player.setUrl(widget.message!.file!);
    player.positionStream.listen((event) {
      currentDuration = event;
      if (currentDuration!.inSeconds == duration!.inSeconds) {
        player.stop();
        player.seek(Duration(seconds: 0));
      }
      setState(() {});
    });
    setState(() {});
  }

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
                    bottomLeft: Radius.circular(!isSentMessage ? 0 : 15)),
                color: isSentMessage ?
                context.theme.colorScheme.primaryContainer :
                context.theme.scaffoldBackgroundColor ),
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
                        widget.message.type == "IMAGE" ? Image.network(widget.message.file ?? "") :
                    Text("VOICE")),
                    W(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.message.date ?? "", style: context.textTheme.bodySmall,),
                        Visibility(
                          visible: isSentMessage,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 6,right: 6),
                            child: Icon(widget.message.isSeen! ?  Icons.done_all : Icons.check, size: 14, weight: 1,),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),

          ),
          Visibility(
            visible: !isSentMessage && widget.isGroup,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: widget.message.senderAvatar == null ? ProfileNameWidget(name: widget.message.senderName ?? "", height: 42, width: 42,) :
              ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: Image.network(widget.message.senderAvatar!, height: 42,width: 42, fit: BoxFit.cover,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
