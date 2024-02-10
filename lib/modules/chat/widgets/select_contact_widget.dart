import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/backend/models/user.dart';
import 'package:messenger/helpers/widgets/button_widget.dart';
import 'package:messenger/helpers/widgets/profile_name_widget.dart';
import 'package:messenger/modules/chat/controllers/select_contact_controller.dart';
import 'package:messenger/modules/chat/pages/create_group_page.dart';

import '../../../helpers/widgets/input_widget.dart';
import '../../../helpers/widgets/loading_widget.dart';
import '../../../helpers/widgets/sized_widgets.dart';

class SelectContactWidget extends StatefulWidget {
  const SelectContactWidget(
      {super.key, this.isMultiple = false, this.onSelect, this.onSelectMultiple});

  final bool isMultiple;
  final Function(User user)? onSelect;
  final Function(List<User> users)? onSelectMultiple;

  @override
  State<SelectContactWidget> createState() => _SelectContactWidgetState();
}

class _SelectContactWidgetState extends State<SelectContactWidget> {

  List<User> selectedUser = [];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectContactController>(
        init: SelectContactController(),
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InputWidget(hint: "جستجو کنید",
                  icon: FeatherIcons.search,
                  onChanged: controller.search,),
              ),
              H(15),
              Expanded(
                  child: controller.contacts == null ? Loading() : ListView
                      .builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.users!.length,
                    itemBuilder: (context, index) {
                      var user =  controller.users![index];
                      return ContactItem(
                        user: user,
                        isMultiple: widget.isMultiple,
                        isChecked: selectedUser.where((u) => u.id == user.id).isNotEmpty,
                        onTap: () {
                          if (!widget.isMultiple) {
                            if (widget.onSelect != null) {
                              widget.onSelect!(user);
                            }
                          } else {
                            setState(() {
                              if (selectedUser.where((u) => u.id == user.id).isEmpty) {
                                selectedUser.add(user);
                              } else {
                                selectedUser.removeWhere((u) => u.id == user.id);
                              }
                            });
                          }
                        },
                      );
                    }
                  )
              ),
              Visibility(
                visible: widget.isMultiple,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ButtonWidget(text: "ایجاد گروه", onPressed: () {
                    if(widget.onSelectMultiple != null) {
                      widget.onSelectMultiple!(selectedUser);
                    }
                  },),
                ),
              ),
              H(15),
            ],
          );
        }
    );
  }
}

class ContactItem extends StatelessWidget {
  const ContactItem(
      {super.key, required this.user, this.isMultiple = false, this.onTap, this.isChecked = false});

  final User user;
  final bool isMultiple;
  final VoidCallback? onTap;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(
              color: context.theme.dividerColor, width: 0.5)),
        ),
        child: Row(
          children: [
            user.avatar == null ? ProfileNameWidget(
              name: user.name ?? "", height: 55, width: 55,) :
            ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Image.network(
                user.avatar!, height: 55, width: 55, fit: BoxFit.cover,),
            ),
            W(10),
            Text(user.name ?? "", style: context.textTheme.titleSmall,),
            Spacer(),
            Visibility(
                visible: isMultiple,
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: isChecked ? context.iconColor! : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: context.iconColor!)),
                  child: Center(child: Icon(Icons.check, size: 14, color: context.theme.scaffoldBackgroundColor,),),
                )
            )
          ],
        ),
      ),
    );
  }
}
