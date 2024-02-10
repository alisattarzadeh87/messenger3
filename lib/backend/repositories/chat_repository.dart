import 'package:messenger/backend/models/conversation.dart';
import 'package:messenger/backend/models/message.dart';
import 'package:messenger/backend/models/user.dart';
import 'package:messenger/backend/repositories/base_repository.dart';
import 'package:messenger/backend/requests/conversation_request.dart';
import 'package:messenger/backend/responses/conversation_response.dart';
import 'package:messenger/backend/responses/messages_response.dart';
import 'package:messenger/backend/responses/user_response.dart';

class ChatRepository extends BaseRepository {
  Future<List<Conversation>> getConversations() async {
    var res = await dio.get("/conversations");
    return ConversationResponse.fromJson(res.data).data ?? [];
  }

  Future<List<Message>> getMessages(int id) async {
    var res = await dio.get("/conversation/$id/messages");
    return MessagesResponse.fromJson(res.data).data ?? [];
  }

  Future<List<User>> getUsersFromContacts(List<String> mobiles) async {
    var res = await dio.post("/contacts", data: {"mobiles": mobiles});
    return UsersResponse.fromJson(res.data).data ?? [];
  }

  Future<Conversation> createConversation(ConversationRequest request) async {
    var data = await request.data();
    var res = await dio.post("/create/conversation", data: data);
    print(res.data);
    return Conversation.fromJson(res.data["conversation"]);
  }
}
