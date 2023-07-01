import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:music/views/home/home.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(const RunApp());

class RunApp extends StatefulWidget {
  const RunApp({super.key});

  @override
  State<RunApp> createState() => _RunAppState();
}

class _RunAppState extends State<RunApp> {
  final _audioQuery = OnAudioQuery();
  bool _hasPermission = false;

  //permission in true ??
  @override
  void initState() {
    super.initState();

    LogConfig logConfig = LogConfig(logType: LogType.DEBUG);
    _audioQuery.setLogConfig(logConfig);

    requestPermission();
  }

  requestPermission({bool retry = false}) async {
    Permission.storage.request();
    _hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: retry,
    );
    _hasPermission ? setState(() {}) : null;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Center(
            child: !_hasPermission
                ? noAccessToLibraryWidget()
                : const HomeView()));
  }

  // noAccessToLibraryWidget()
  Widget noAccessToLibraryWidget() {
    return Center(
      child: ElevatedButton(
        onPressed: () => requestPermission(retry: true),
        child: const Text("Allow"),
      ),
    );
  }
}
