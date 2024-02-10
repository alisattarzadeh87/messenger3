import 'dart:async';
import 'dart:io';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:messenger/helpers/utils.dart';
import 'package:messenger/helpers/widgets/sized_widgets.dart';
import 'package:messenger/helpers/widgets/snakbars.dart';
import 'package:messenger/modules/chat/controllers/chat_controllers.dart';
import 'package:messenger/modules/chat/controllers/socket_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordButtomSheet extends StatefulWidget {
  const RecordButtomSheet({super.key});

  @override
  State<RecordButtomSheet> createState() => _RecordButtomSheetState();
}

class _RecordButtomSheetState extends State<RecordButtomSheet> {

  FlutterSoundRecorder recorder = FlutterSoundRecorder();

  bool isRecorderInited = false;

  bool isRecordingFinished = false;

  int recordedTime = 0;

  String path = "";

  Timer? timer;

  XFile? recordedFile;

  Future<void> initRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if(status != PermissionStatus.granted) {
        showErrorMessage("برای ارسال فایل صوتی لطفا دسترسی میکروفون را بدهید");
        return;
      }
    }
    await recorder.openRecorder();
    isRecorderInited = true;
    setState(() {});
  }

  Future<void> getTempPath() async {
    if (!kIsWeb) {
      var tempDir = await getTemporaryDirectory();
      path = "${tempDir.path}/${generateRandomName()}.aac";
    } else {
      path = "${generateRandomName()}.webm";
    }
  }

  Future<void> record() async {
    await recorder.startRecorder(toFile: path, codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS);
    startTimer();
    setState(() {});
  }

  Future<void> stopRecorder() async {
    var res = await recorder.stopRecorder();
    print(res);
    if(res != null) {
      recordedFile = XFile(res);
    }
    timer?.cancel();
    setState(() {
      isRecordingFinished = true;
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        recordedTime++;
      });
    });
  }

  @override
  void initState() {
    getTempPath();
    initRecorder();
    super.initState();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !isRecorderInited ? Container() :
    Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isRecordingFinished ? VoiceWidget(file: recordedFile!, duration: Duration(seconds: recordedTime),) : Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(onPressed: () => Get.back(), icon: Icon(FeatherIcons.x, size: 32,)),
            Center(
              child: GestureDetector(
                onTap: () {
                  if(recorder.isRecording) {
                    stopRecorder();
                  } else {
                    record();
                  }
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.theme.colorScheme.primary
                  ),
                  child: Center(
                    child: Icon(recorder.isRecording ? FeatherIcons.pause : FeatherIcons.mic, size: 45, color: Colors.white,),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: recordedTime != 0,
              child: Center(
                  child: Text(formatDuration(Duration(seconds: recordedTime)), style: context.textTheme.titleLarge,)
              ),
            ),
            H(40)
          ],
        ),
      ),
    );
  }
}

class VoiceWidget extends StatefulWidget {
  const VoiceWidget({super.key, required this.file, this.duration});

  final XFile file;
  final Duration? duration;

  @override
  State<VoiceWidget> createState() => _VoiceWidgetState();
}

class _VoiceWidgetState extends State<VoiceWidget> {
  final player = AudioPlayer();
  Duration? duration;
  Duration? currentDuration;


  Future<void> initAudioPlayer() async {
    if (!kIsWeb) {
      print(widget.file.path);
      duration = await player.setFilePath(widget.file.path);
    } else {
      await player.setUrl(widget.file.path);
      duration = widget.duration;
    }
    player.positionStream.listen((event) {
      currentDuration = event;
      if(currentDuration!.inSeconds == duration!.inSeconds) {
        player.stop();
        player.seek(Duration(seconds: 0));
      }
      setState(() {});
    });
    setState(() {});
  }

  @override
  void initState() {
    initAudioPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return duration == null ? Container() : Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Directionality(
            textDirection: TextDirection.ltr,
            child: SliderTheme(
              data: SliderThemeData(
                  inactiveTrackColor: context.theme.colorScheme.primaryContainer,
                  activeTrackColor: context.theme.colorScheme.secondary,
                  trackHeight: 6
              ),
              child: Slider(
                value: currentDuration!.inSeconds / duration!.inSeconds,
                onChanged: (value) {
                  player.seek(Duration(seconds: (value * duration!.inSeconds).round()));
                  setState(() {});
                },
              ),
            )
        ),
        Row(
          children: [
            W(20),
            Text(formatDuration(duration!), style: context.textTheme.bodySmall,),
            Spacer(),
            Text(formatDuration(currentDuration!), style: context.textTheme.bodySmall,),
            W(20),
          ],
        ),
        CircleButton(icon: player.playing ? FeatherIcons.pause : FeatherIcons.play, onTap: () {
          if(player.playing) {
            player.pause();
          } else {
            player.play();
          }
          setState(() {});
        },),
        Row(
          children: [
            W(20),
            CircleButton(icon: FeatherIcons.send, onTap: () async {
              Get.find<SocketController>().sendFileMessage(
                conversationId: Get.find<ChatController>().id,
                file: await convertFileToBase64(widget.file),
                fileType: kIsWeb ? "webm" : "aac",
                type: "VOICE",
                voiceDuration: duration?.inSeconds,
              );
              Get.back();
            },),
            Spacer(),
            CircleButton(icon: FeatherIcons.x, onTap: Get.back,),
            W(20),
          ],
        ),
        H(15)
      ],
    );
  }
}


class CircleButton extends StatelessWidget {
  const CircleButton({super.key, required this.icon, this.onTap, this.size});

  final IconData icon;
  final VoidCallback? onTap;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          height: size ?? 50,
          width: size ?? 50,
          decoration: BoxDecoration(
              color: context.theme.colorScheme.primary,
              shape: BoxShape.circle
          ),
          child: Center(child: Icon(icon, color: Colors.white,),),
        ),
      ),
    );
  }
}

class BytesSource extends StreamAudioSource {
  final Uint8List bytes;
  final String mimeTypes;

  BytesSource(this.bytes, this.mimeTypes) : super(tag: 'MyAudioSource');

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    // Returning the stream audio response with the parameters
    return StreamAudioResponse(
      sourceLength: bytes.length,
      contentLength: (end ?? bytes.length) - (start ?? 0),
      offset: start ?? 0,
      stream: Stream.fromIterable([bytes.sublist(start ?? 0, end)]),
      contentType: mimeTypes,
    );
  }
}