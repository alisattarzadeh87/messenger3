import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/modules/home/controller/home_controller.dart';

class HomeAppbarWidget extends StatelessWidget {
  const HomeAppbarWidget({super.key, this.onSearchTap});

  final VoidCallback? onSearchTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Icon(FeatherIcons.menu)),
          Image.asset("assets/images/logo_horiz_${context.isDarkMode ? "dark" : "light"}.png", height: 30,),
          GestureDetector(
              onTap: onSearchTap,
              child: Icon(Get.find<HomeController>().isSearchVisible ?
              FeatherIcons.x :
              FeatherIcons.search)),
        ],
      ),
    );
  }
}
