import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:messenger/backend/models/conversation.dart';
import 'package:messenger/backend/models/message.dart';
import 'package:messenger/backend/repositories/auth_repositiory.dart';
import 'package:messenger/backend/repositories/chat_repository.dart';
import 'package:messenger/helpers/user_helper.dart';
import 'package:messenger/modules/chat/controllers/chat_controllers.dart';
import 'package:messenger/modules/chat/controllers/socket_controller.dart';

class HomeController extends GetxController {
  AuthRepository repository = AuthRepository();
  ChatRepository chatRepository = ChatRepository();

  List<Conversation>? conversations;
  List<Conversation>? allConversations;

  bool isSearchVisible = false;

  getProfile() async {
    var res = await repository.getProfile();
    if(res != null) {
      userHelper.setUser(res);
    }
  }

  void onTabChange(int tab) {
    if(tab ==0) {
      conversations = allConversations;
    } else if (tab ==1) {
      conversations = allConversations?.where((element) => element.type == 'PRIVATE"').toList();
    } else if (tab ==2) {
      conversations = allConversations?.where((element) => element.type == 'GROUP"').toList();
    }
  }

  void onSearchTap() {
    isSearchVisible = !isSearchVisible;
    update();
  }

  void search(String value){
    print(value);
    conversations = allConversations!.where((element) => element.name!.contains(value)).toList();
  }


  getConversation() async {
    conversations = await chatRepository.getConversations();
    joinCoversations();
    allConversations = conversations;
    update();
  }

  void joinCoversations() {
    for(var item in conversations!) {
      Get.find<SocketController>().joinConversation(item.id!);
    }
  }

  void updateConversation(Message message) {
    var conversation = allConversations?.firstWhereOrNull((c) => c.id == message.conversationId);
    if (conversation != null) {
      conversation.lastMessage = message;
       if (message.senderId != userHelper.user!.id!) {
         if (Get.isRegistered<ChatController>()) {
           conversation.unreadCount = conversation.unreadCount! + 1;
         }
       }
      update();
    } else {
      getConversation();
    }
  }

  @override
  void onInit() {
    getProfile();
    getConversation();
    Get.put(SocketController());
    super.onInit();
  }
}