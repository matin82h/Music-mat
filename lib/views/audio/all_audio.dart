import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/views/audio/play_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../darkMode/dark.dart';
import 'audioClass/controller.dart';

class AllAudioView extends StatefulWidget {
  const AllAudioView({super.key});

  @override
  State<AllAudioView> createState() => _AllAudioViewState();
}

class _AllAudioViewState extends State<AllAudioView> {
 final dataController = Get.put(GetMusic());
  final dark = Get.find<DarkMode>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: dark.darkMode.value ? Colors.white : Colors.black,
        body: FutureBuilder<List<SongModel>>(
          future: dataController.audioQuery.querySongs(
            sortType: null,
            ignoreCase: true,
            uriType: UriType.EXTERNAL,
            orderType: OrderType.ASC_OR_SMALLER,
          ),
          builder: (context, item) {
            if (item.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (item.data!.isEmpty) {
              return const Center(
                child: Text("No Music Found"),
              );
            }

            return ListView.builder(
              itemCount: item.data!.length,
              itemBuilder: (context, index) => Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        top: 8, right: 14, left: 14, bottom: 12.5),
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    decoration: BoxDecoration(
                      color: dark.darkMode.value ? Colors.white : Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            child: ClipRRect(
                              child: QueryArtworkWidget(
                                controller: dataController.audioQuery,
                                id: item.data![index].id,
                                type: ArtworkType.AUDIO,
                                artworkQuality: FilterQuality.high,
                                nullArtworkWidget: Icon(
                                  Icons.music_note_rounded,
                                  size: 50,
                                  color: dark.darkMode.value
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                artworkWidth: 50,
                                artworkHeight: 50,
                                artworkBorder: const BorderRadius.horizontal(
                                    left: Radius.circular(6),
                                    right: Radius.circular(6)),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                if (true) {
                                  if (true == dataController.isPlay.value) {
                                    if (dataController.playIndex() == index) {
                                      dataController.audioPlayer.pause();
                                      dataController.isPlay(false);
                                    } else if (dataController.isPlay(true)) {
                                      dataController.isPlay(true);
                                      dataController.playMusic(
                                          item.data![index].uri, index);
                                    }
                                  } else {
                                    if (dataController.playIndex() == index) {
                                      dataController.audioPlayer.play();
                                      dataController.isPlay(true);
                                    } else {
                                      dataController.audioPlayer.play();
                                      dataController.isPlay(true);
                                      dataController.playMusic(
                                          item.data![index].uri, index);
                                    }
                                  }
                                }
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 220,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    Get.to(PlayAudioView(getData: item.data!));
                                  });
                                  setState(() {
                                    dataController.playMusic(
                                        item.data![index].uri, index);
                                  });
                                },
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    item.data![index].title,
                                    style: TextStyle(
                                      color: dark.darkMode.value
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 220,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        Get.to(PlayAudioView(getData: item.data!));
                                      });
                                      setState(() {
                                        dataController.playMusic(
                                            item.data![index].uri, index);
                                      });
                                    },
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                        item.data![index].artist != '<unknown>'
                                            ? item.data![index].artist
                                                .toString()
                                            : '',
                                        style: TextStyle(
                                          color: dark.darkMode.value
                                              ? Colors.black
                                              : Colors.white,
                                          fontSize: 15.5,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        Container(
                          height: 37.5,
                          width: 37.5,
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(30)),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if (true) {
                                  if (true == dataController.isPlay.value) {
                                    if (dataController.playIndex() == index) {
                                      dataController.audioPlayer.pause();
                                      dataController.isPlay(false);
                                    } else if (dataController.isPlay(true)) {
                                      dataController.isPlay(true);
                                      dataController.playMusic(
                                          item.data![index].uri, index);
                                    }
                                  } else {
                                    if (dataController.playIndex() == index) {
                                      dataController.audioPlayer.play();
                                      dataController.isPlay(true);
                                    } else {
                                      dataController.audioPlayer.play();
                                      dataController.isPlay(true);
                                      dataController.playMusic(
                                          item.data![index].uri, index);
                                    }
                                  }
                                }
                              });
                            },
                            child: dataController.playIndex.value == index &&
                                    dataController.isPlay.value
                                ? const Icon(Icons.pause,
                                    size: 27.5, color: Colors.black)
                                : const Icon(Icons.play_arrow,
                                    size: 27.5, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
