import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../darkMode/dark.dart';

class FolderView extends StatefulWidget {
  const FolderView({super.key});

  @override
  State<FolderView> createState() => _FolderViewState();
}

class _FolderViewState extends State<FolderView> {
  final dark = Get.find<DarkMode>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: dark.darkMode.value ? Colors.white : Colors.black,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: dark.darkMode.value ? Colors.white : Colors.black,
          title: Text(
            'Folder',
            style: TextStyle(
              fontSize: 25,
              color: dark.darkMode.value ? Colors.black : Colors.white,
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
        ),
        body: Center(
          child: Text(
            "Folder",
            style: TextStyle(
              fontSize: 60,
              color: dark.darkMode.value ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
