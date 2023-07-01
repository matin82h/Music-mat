import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../audio/all_audio.dart';
import '../../darkMode/dark.dart';

class TabBarViews extends StatefulWidget {
  const TabBarViews({super.key});

  @override
  State<TabBarViews> createState() => _TabBarViewsState();
}

class _TabBarViewsState extends State<TabBarViews> {
  final dark = Get.put(DarkMode());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: dark.darkMode.value ? Colors.white : Colors.black,
          body: Column(
            children: [
              Material(
                color: dark.darkMode.value ? Colors.white : Colors.black,
                child: TabBar(
                  labelColor: dark.darkMode.value ? Colors.black : Colors.white,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                  indicator: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color:
                            dark.darkMode.value ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                  tabs: const [
                    Tab(text: "Songs"),
                    Tab(text: "Artist"),
                    Tab(text: "Album"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    const AllAudioView(),
                    Center(
                      child: Text(
                        "Artist",
                        style: TextStyle(
                          fontSize: 60,
                          color:
                              dark.darkMode.value ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Album",
                        style: TextStyle(
                          fontSize: 60,
                          color:
                              dark.darkMode.value ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
