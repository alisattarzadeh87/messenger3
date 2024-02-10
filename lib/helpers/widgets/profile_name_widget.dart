import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileNameWidget extends StatelessWidget {
  const ProfileNameWidget({super.key, required this.name, this.height = 90, this.width = 90});

  final String name;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: context.theme.colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(100)
      ),
      child: Center(child: Text(name.split("")[0], style: TextStyle(fontSize: 25),)),
    );
  }
}
