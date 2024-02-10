import 'package:get/get.dart';
import 'package:messenger/backend/repositories/chat_repository.dart';
import 'package:messenger/backend/requests/conversation_request.dart';
import 'package:messenger/modules/chat/controllers/socket_controller.dart';
import 'package:messenger/modules/chat/pages/chat_page.dart';

class CreateMessageController extends GetxController {
  ConversationRequest request = ConversationRequest();
  ChatRepository repository = ChatRepository();

  Future<void> createMessage(int userId) async {
    request.participants = [userId];
    var res = await repository.createConversation(request);
    Get.find<SocketController>().joinConversation(res.id!);
    Get.to(ChatPage(conversation: res));
  }
}
