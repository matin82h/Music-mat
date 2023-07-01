import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/views/home/home.dart';

import '../../darkMode/dark.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  Size get preferredSize => const Size.fromHeight(70);
  final dark = Get.find<DarkMode>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark.darkMode.value ? Colors.black : Colors.white,
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: AppBar(
          elevation: 0,
          backgroundColor: dark.darkMode.value ? Colors.white : Colors.black,
          title: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search Music",
              hintStyle: TextStyle(
                  color: dark.darkMode.value
                      ? Colors.black
                      : const Color.fromARGB(255, 185, 185, 185)),
            ),
            style: TextStyle(
                color: dark.darkMode.value ? Colors.black : Colors.white),
          ),
          actions: [
            Icon(Icons.search,
                color: dark.darkMode.value ? Colors.black : Colors.white),
          ],
          leading: IconButton(
            onPressed: () {
              setState(() {
                Get.to(const HomeView());
              });
            },
            icon: Icon(
              Icons.arrow_back,
              color: dark.darkMode.value ? Colors.black : Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
