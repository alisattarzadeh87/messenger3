import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger/backend/models/user.dart';
import 'package:messenger/backend/repositories/chat_repository.dart';
import 'package:messenger/backend/requests/conversation_request.dart';
import 'package:messenger/modules/chat/controllers/socket_controller.dart';
import 'package:messenger/modules/chat/pages/chat_page.dart';

class CreateGroupController extends GetxController {
  ConversationRequest request = ConversationRequest();
  ChatRepository repository = ChatRepository();

  final List<User> users;

  CreateGroupController(this.users);

  Future<void> selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      request.image = File(image.path);
      update();
    }
  }

  Future<void> createConversation() async {
    request.type = "GROUP";
    request.participants = users.map((e) => e.id!).toList();
    var res = await repository.createConversation(request);
    Get.find<SocketController>().joinConversation(res.id!);
    Get.to(ChatPage(conversation: res));
  }
}