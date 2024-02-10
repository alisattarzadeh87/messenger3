import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:messenger/helpers/widgets/input_widget.dart';
import 'package:messenger/modules/home/controller/home_controller.dart';
import 'package:messenger/modules/home/widgets/chats_list.dart';
import 'package:messenger/modules/home/widgets/drawer_widget.dart';
import 'package:messenger/modules/home/widgets/home_appbar_widget.dart';
import 'package:messenger/modules/home/widgets/home_fab_widget.dart';
import 'package:messenger/modules/home/widgets/home_tabbar_widget.dart';

import '../../../helpers/widgets/loading_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          drawer: DrawerWidget(),
          body: HomeFabWidget(
            body: SafeArea(
              child: Column(
                children: [
                  HomeAppbarWidget(onSearchTap: controller.onSearchTap),
                  AnimatedCrossFade(
                    duration: Duration(milliseconds: 300),
                    firstCurve: Curves.easeInOut,
                    secondCurve: Curves.easeInOut,
                    crossFadeState: controller.isSearchVisible ?
                    CrossFadeState.showSecond : CrossFadeState.showFirst,
                    firstChild: Container(),
                    secondChild: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7.0),
                      child: InputWidget(hint: "جستجو کنید ...", onChanged: controller.search),
                    ),
                  ),
                  HomeTabBarWidget(onChange: controller.onTabChange),
                  Expanded(
                      child: controller.conversations == null ?
                      Loading() :
                      ChatsList(conversations: controller.conversations!,))
                ],
              ),
            ),
          )
        );
      }
    );
  }
}
