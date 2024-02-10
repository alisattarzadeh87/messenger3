import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:messenger/backend/models/user.dart';
import 'package:messenger/backend/repositories/chat_repository.dart';
import '../../../helpers/base_controller.dart';

class SelectContactController extends BaseController {
  List<Contact>? contacts;
  ChatRepository repository = ChatRepository();
  List<User>? users;
  List<User>? allUsers;

  Future<void> getContacts() async {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(withProperties: true);
      var mobiles = contacts?.map((e) => e.phones.first.number).toList();
      users = await repository.getUsersFromContacts(mobiles ?? []);
      allUsers = users;
      update();
    }
  }

  void search(String value) {
    if(value.isEmpty) {
      users = allUsers;
    } else {
      users = allUsers!.where((element) => element.name!.contains(value) || element.mobile!.contains(value)).toList();
    }
    update();
  }

  @override
  void onInit() {
    getContacts();
    super.onInit();
  }
}