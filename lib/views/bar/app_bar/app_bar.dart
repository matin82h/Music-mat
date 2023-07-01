import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/views/bar/app_bar/search.dart';
import '../../darkMode/dark.dart';

class AppBarView extends StatefulWidget {
  const AppBarView({super.key});

  @override
  State<AppBarView> createState() => _AppBarViewState();
}

class _AppBarViewState extends State<AppBarView> {
  final dark = Get.put(DarkMode());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: dark.darkMode.value ? Colors.white : Colors.black,
        title: Text(
          'Music Player',
          style: TextStyle(
            color: dark.darkMode.value ? Colors.black : Colors.white,
            fontSize: 25,
          ),
        ),
        leading: IconButton(
          icon: dark.darkMode.value
              ? const Icon(
                  Icons.light_mode_outlined,
                  color: Colors.black,
                )
              : const Icon(
                  Icons.dark_mode_outlined,
                  color: Colors.white,
                ),
          onPressed: () {
            setState(() {
              if (dark.darkMode.value) {
                dark.darkMode(false);
              } else {
                dark.darkMode(true);
              }
            });
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: dark.darkMode.value ? Colors.black : Colors.white,
            ),
            onPressed: () {
              setState(() {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const SearchView(),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
