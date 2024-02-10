import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeTabBarWidget extends StatefulWidget {
  const HomeTabBarWidget({super.key, required this.onChange});

  final Function(int tab) onChange;

  @override
  State<HomeTabBarWidget> createState() => _HomeTabBarWidgetState();
}

class _HomeTabBarWidgetState extends State<HomeTabBarWidget> {
  int currentTab = 0;

  List<String> tabs = ['همه پیام ها', 'شخصی', 'گروه ها'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Positioned(
            bottom: 2.5,
            left: 0,
            right: 0,
            child: Container(
              height: 0.5,
              color: context.theme.dividerColor,
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(tabs.length, (index) {
                return TabBarItam(
                    text: tabs[index],
                    isActive: currentTab == index,
                    onTap: () {
                      setState(() {
                        currentTab = index;
                      });
                      widget.onChange(currentTab);
                    }
                    );
              }),
          )
        ],
      ),
    );
  }
}

class TabBarItam extends StatelessWidget {
  const TabBarItam(
      {super.key,
      required this.text,
      this.isActive = false,
      required this.onTap});

  final String text;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        child: Column(
          children: [
            Spacer(),
            Text(
              text,
              style: context.textTheme.titleSmall,
            ),
            Spacer(),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: isActive
                      ? context.theme.colorScheme.primary
                      : Colors.transparent),
            )
          ],
        ),
      ),
    );
  }
}
