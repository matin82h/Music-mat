import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/views/home/home.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:just_audio/just_audio.dart';
import '../darkMode/dark.dart';
import 'audioClass/controller.dart';

class PlayAudioView extends StatefulWidget {
  final List<SongModel> getData;
  const PlayAudioView({super.key, required this.getData});

  @override
  State<PlayAudioView> createState() => _PlayAudioViewState();
}

class _PlayAudioViewState extends State<PlayAudioView> {
  var dataController = Get.find<GetMusic>();
  final dark = Get.find<DarkMode>();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: dark.darkMode.value ? Colors.white : Colors.black,
        child: Obx(
          () => Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 27, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          Get.to(const HomeView());
                        });
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color:
                            dark.darkMode.value ? Colors.black : Colors.white,
                        size: 30,
                      ),
                    ),
                    IconButton(
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
                  ],
                ),
              ),
              const SizedBox(height: 70),
              Obx(
                () => QueryArtworkWidget(
                  id: widget.getData[dataController.playIndex.value].id,
                  type: ArtworkType.AUDIO,
                  artworkWidth: 250,
                  artworkHeight: 250,
                  artworkQuality: FilterQuality.high,
                  nullArtworkWidget: Icon(
                    Icons.music_note_rounded,
                    size: 250,
                    color: dark.darkMode.value ? Colors.black : Colors.white,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.4,
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 21),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 250,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    widget
                                        .getData[dataController.playIndex.value]
                                        .title,
                                    style: TextStyle(
                                      color: dark.darkMode.value
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    widget
                                                .getData[dataController
                                                    .playIndex.value]
                                                .artist !=
                                            '<unknown>'
                                        ? widget
                                            .getData[
                                                dataController.playIndex.value]
                                            .artist
                                            .toString()
                                        : '',
                                    style: TextStyle(
                                      color: dark.darkMode.value
                                          ? Colors.black.withOpacity(0.9)
                                          : Colors.white.withOpacity(0.9),
                                      fontSize: 19,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (dataController.favorite.value == false) {
                                dataController.favorite(true);
                              } else {
                                dataController.favorite(false);
                              }
                            },
                            icon: dataController.favorite.value
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 35,
                                  )
                                : Icon(
                                    Icons.favorite,
                                    color: dark.darkMode.value
                                        ? Colors.black
                                        : Colors.white,
                                    size: 35,
                                  ),
                          )
                        ],
                      ),
                    ),
                    Obx(
                      () => Column(
                        children: [
                          Slider(
                            activeColor: dark.darkMode.value
                                ? Colors.black
                                : Colors.white,
                            inactiveColor: dark.darkMode.value
                                ? Colors.black
                                : Colors.white54,
                            min:
                                const Duration(seconds: 0).inSeconds.toDouble(),
                            max: dataController.max.value,
                            value: dataController.vp.value,
                            onChanged: (value) {
                              dataController
                                  .changeDurationToSeconds(value.toInt());
                              value = value;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dataController.position.value,
                                  style: TextStyle(
                                    color: dark.darkMode.value
                                        ? Colors.black
                                        : Colors.white.withOpacity(0.6),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  dataController.duration.value,
                                  style: TextStyle(
                                    color: dark.darkMode.value
                                        ? Colors.black
                                        : Colors.white.withOpacity(0.6),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 17, left: 25, right: 15),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if (dataController.loop_.value == false) {
                                  dataController.audioPlayer
                                      .setLoopMode(LoopMode.one);
                                  dataController.loop_(true);
                                } else {
                                  dataController.audioPlayer
                                      .setLoopMode(LoopMode.all);

                                  dataController.loop_(false);
                                }
                              });
                            },
                            child: dataController.loop_.value
                                ? const Icon(
                                    Icons.loop,
                                    color: Colors.greenAccent,
                                    size: 33,
                                  )
                                : Icon(
                                    Icons.loop,
                                    color: dark.darkMode.value
                                        ? Colors.black
                                        : Colors.white,
                                    size: 33,
                                  ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (dataController.playIndex.value > 0) {
                                dataController.playMusic(
                                    widget
                                        .getData[
                                            dataController.playIndex.value - 1]
                                        .uri,
                                    dataController.playIndex.value - 1);
                              } else {
                                dataController.playMusic(
                                    widget
                                        .getData[dataController.playIndex(
                                            widget.getData.length - 1)]
                                        .uri,
                                    dataController
                                        .playIndex(widget.getData.length - 1));
                              }
                            });
                          },
                          icon: Icon(
                            Icons.skip_previous,
                            color: dark.darkMode.value
                                ? Colors.black
                                : Colors.white,
                            size: 50,
                          ),
                        ),
                        const SizedBox(width: 17),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 9, left: 45, right: 45),
                          width: 57,
                          height: 57,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (dataController.isPlay.value) {
                                  dataController.audioPlayer.pause();
                                  dataController.isPlay(false);
                                } else {
                                  dataController.audioPlayer.play();
                                  dataController.isPlay(true);
                                }
                              });
                            },
                            icon: dataController.isPlay.value
                                ? const Icon(
                                    Icons.pause,
                                    color: Colors.black,
                                    size: 43,
                                  )
                                : const Icon(
                                    Icons.play_arrow,
                                    color: Colors.black,
                                    size: 43,
                                  ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (dataController.playIndex.value + 1 <
                                  widget.getData.length) {
                                dataController.playMusic(
                                    widget
                                        .getData[
                                            dataController.playIndex.value + 1]
                                        .uri,
                                    dataController.playIndex.value + 1);
                              } else {
                                dataController.playMusic(
                                    widget.getData[dataController.playIndex(0)]
                                        .uri,
                                    dataController.playIndex(0));
                              }
                            });
                          },
                          icon: Icon(
                            Icons.skip_next,
                            color: dark.darkMode.value
                                ? Colors.black
                                : Colors.white,
                            size: 50,
                            weight: 6,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
