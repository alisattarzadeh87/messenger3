import 'package:get/get.dart';
import 'package:messenger/backend/models/message.dart';
import 'package:messenger/backend/models/user.dart';
import 'package:messenger/helpers/user_helper.dart';
import 'package:messenger/helpers/widgets/constants.dart';
import 'package:messenger/modules/chat/controllers/chat_controllers.dart';
import 'package:messenger/modules/home/controller/home_controller.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketController extends GetxController {
  late Socket socket;

  ChatController get chatController => Get.find<ChatController>();

  @override
  void onInit() {
    socket = io(baseUrl, OptionBuilder().setTransports(['websocket']).build());
    socket.connect();

    listenToMessage();
    listenToSeenMessages();
    listenToTyping();

    socket.onConnect((_) {
      print('connect');
    });
    super.onInit();
  }

  void joinConversation(int id) {
    socket.emit("joinConversation", id);
  }

  void listenToMessage() {
    socket.on("receiveMessage", (data) {
      var message = Message.fromJson(data["message"]);
      if(Get.isRegistered<ChatController>()) {
        chatController.addMessage(message);
        seenMessages(message.conversationId!);
      }
      Get.find<HomeController>().updateConversation(message);
    });
  }

  void sendMessage({ required int conversationId, required String text }) {
    socket.emit("sendMessage", {
      "userId": userHelper.user?.id,
      "conversationId": conversationId,
      "text": text,
    });
  }

  void sendFileMessage(
      {required int conversationId,
        required String file,
        required String fileType,
        int? voiceDuration,
        required String type}) {

    socket.emit("sendFile", {
      "userId": userHelper.user?.id,
      "conversationId": conversationId,
      "file": file,
      "voiceDuration": voiceDuration,
      "fileType": fileType,
      "type": type,
    });
  }

  void listenToSeenMessages() {
    socket.on("seenMessage", (data) {
      if(Get.isRegistered<ChatController>()) {
        if(chatController.id == data["conversationId"]) {
          chatController.updateSeenMessage();
        }
      }
    });
  }

  void listenToTyping() {
    socket.on("userTyping", (data) {
      var user  = User.fromJson(data["user"]);
      if(Get.isRegistered<ChatController>()) {
        if(chatController.id == data["conversationId"]) {
          chatController.changeTypingStatus(true);
          chatController.addTypingUser(user);
        }
      }
    });

    socket.on("userStoppedTyping", (data) {
      print(data);
      if(Get.isRegistered<ChatController>()) {
        if(chatController.id == data["conversationId"]) {
          chatController.changeTypingStatus(false);
          chatController.removeTypingUser(data["userId"]);
        }
      }
    });
  }

  void seenMessages(int id) {
    socket.emit("seenMessages", {
      "userId": userHelper.user?.id,
      "conversationId": id,
    });
  }


  void startTyping(int id) {
    socket.emit("startTyping", {
      "userId": userHelper.user?.id,
      "conversationId": id,
    });
  }

  void stopTyping(int id) {
    socket.emit("stopTyping", {
      "userId": userHelper.user?.id,
      "conversationId": id,
    });
  }



}
