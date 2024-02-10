import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({super.key, required this.title, this.hasPadding = true});

  final String title;
  final bool hasPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: hasPadding ? 16 : 0),
      child: Stack(
        children: [
          Center(
            child: Text(title, style: context.textTheme.titleMedium,),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                  onTap: Get.back,
                  child: Icon(FeatherIcons.arrowRight)))
        ],
      ),
    );
  }
}
