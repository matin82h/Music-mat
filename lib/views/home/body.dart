import 'package:flutter/material.dart';
import 'package:music/views/bar/app_bar/app_bar.dart';
import 'package:music/views/bar/tab_bar/tab_bar.dart';

class BodyView extends StatelessWidget {
  const BodyView({super.key});
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const AppBarView(),
      ),
      body: const TabBarViews(),
    );
  }
}
