import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:get/get.dart';
import '../darkMode/dark.dart';
import '../folder/folder.dart';
import 'body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int activeTab = 0;
  final dark = Get.put(DarkMode());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: dark.darkMode.value ? Colors.white : Colors.black,
        bottomNavigationBar: getFooter(),
        body: getBody(),
      ),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: activeTab,
      children: const [
        BodyView(),
        FolderView(),
      ],
    );
  }

  Widget getFooter() {
    List items = [
      FeatherIcons.home,
      FeatherIcons.folder,
    ];

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: dark.darkMode.value ? Colors.white : Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 80, right: 80),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(items.length, (index) {
            return IconButton(
                onPressed: () {
                  setState(() {
                    activeTab = index;
                  });
                },
                icon: dark.darkMode.value
                    ? Icon(items[index],
                        color: activeTab == index
                            ? Colors.greenAccent
                            : Colors.black)
                    : Icon(items[index],
                        color: activeTab == index
                            ? Colors.greenAccent
                            : Colors.white));
          }),
        ),
      ),
    );
  }
}
