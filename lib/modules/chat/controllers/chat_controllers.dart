import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger/backend/models/message.dart';
import 'package:messenger/backend/models/user.dart';
import 'package:messenger/backend/repositories/chat_repository.dart';
import 'package:messenger/helpers/utils.dart';
import 'package:messenger/modules/chat/controllers/socket_controller.dart';
import 'package:messenger/modules/home/controller/home_controller.dart';

class ChatController extends GetxController {

  final int id;

  ChatRepository repository = ChatRepository();
  List<Message>? messages;

  TextEditingController txtMessage = TextEditingController();
  ScrollController scrollController = ScrollController();
  File? selectedImage;

  bool isTyping = false;
  List<User> typingUsers = [];

  ChatController(this.id);

  Future<void> selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
      Get.find<SocketController>().sendFileMessage(
          conversationId: id,
          file: await convertFileToBase64(image),
          fileType: image.mimeType == null ? image.path.split(".").last : image.mimeType!.split("/").last, // image/png
          type: "IMAGE");
      update();
    }
  }

  getMessage() async {
    messages = await repository.getMessages(id);
    Get.find<HomeController>().getConversation();
    Get.find<SocketController>().seenMessages(id);
    update();
  }

  void sendMessage() {
    if (txtMessage.text.isNotEmpty) {
      Get.find<SocketController>().sendMessage(conversationId: id, text: txtMessage.text);
      txtMessage.clear(); // For cleaning textfield after sending a message
      Get.focusScope?.unfocus(); // For closing keyboard after sending a message
    }
  }

  void changeTypingStatus(bool value) {
    isTyping = value;
    update();
  }

  void addMessage(Message message) {
    messages?.add(message);
    scrollController.jumpTo(scrollController.position.minScrollExtent);
    update();
  }

  // void scrollToDown() {
  //   scrollController.jumpTo(scrollController.position.minScrollExtent);
  // }

  void updateSeenMessage() {
    messages?.forEach((element) {
      element.isSeen = true;
    });
    update();
  }

  void addTypingUser(User user) {
    if (typingUsers.where((e) => e.id == user.id).isEmpty) {
      typingUsers.add(user);
      update();
    }
  }

  void removeTypingUser(int id) {
    typingUsers.removeWhere((element) => element.id == id);
    update();
  }

  @override
  void onInit() {
    getMessage();
    super.onInit();
  }

  @override
  void onClose() {
    Get.find<SocketController>().stopTyping(id);
    super.onClose();
  }

}
