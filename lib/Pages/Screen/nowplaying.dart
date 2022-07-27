import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:beats/Db/favaroitedb.dart';
import 'package:beats/Pages/widgets/favbutton.dart';
import 'package:beats/Pages/widgets/getsong.dart';
import 'package:beats/Pages/widgets/textanimation.dart';
import 'package:beats/utilits/globalcolors.dart';
import 'package:beats/widgets/iconwidgets.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';

// ignore: must_be_immutable
class NowPlayingScreen extends StatefulWidget {
  const NowPlayingScreen({
    Key? key,
    required this.playersong,
  }) : super(key: key);
  final List<SongModel> playersong;

  // int index;

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  Duration _duration = const Duration();
  Duration _position = const Duration();
  bool _isPlaying = false;
  int currentIndex = 0;

  @override
  void initState() {
    // playsong();
    GetSong.player.currentIndexStream.listen((index) {
      if (index != null && mounted) {
        setState(() {
          currentIndex = index;
        });
        GetSong.currentIndes = index;
      }
    });
    _isPlaying = true;

    super.initState();
  }

  // @override
  // void dispose() {
  //   GetSong.player.dispose();
  //   super.dispose();
  // }

  // void playsong() async {
  //   await GetSong.player.setAudioSource(
  //     AudioSource.uri(
  //       Uri.parse(widget.songModel[currentIndex].uri!),
  //       tag: MediaItem(
  //         id: '${widget.songModel[currentIndex].id}',
  //         album: '${widget.songModel[currentIndex].album}',
  //         title: widget.songModel[currentIndex].displayNameWOExt,
  //         artUri: Uri.parse('https://example.com/albumart.jpg'),
  //       ),
  //     ),
  //   );
  //   GetSong.player.play();

  //   GetSong.player.durationStream.listen((duration) {
  //     setState(() {
  //       _duration = duration!;
  //     });
  //   });
  //   GetSong.player.positionStream.listen((position) {
  //     setState(() {
  //       _position = position;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (GetSong.playingSongs.last.id != widget.playersong.last.id) {
      GetSong.player.stop();
    }
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black,
            Colors.black.withOpacity(0.9),
          ],
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: transparent,
        appBar: AppBar(
          backgroundColor: transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                // setState(() {});
                Navigator.pop(context);
                FavaroiteDb.favaroiteList.notifyListeners();
              },
              icon: const Icon(
                Icons.expand_more_rounded,
                color: white,
              )),
          title: const Text(
            'Now Playing',
            style: TextStyle(fontWeight: FontWeight.bold, color: black),
          ),
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: MediaQuery.of(context).size.height / 60),
              Center(
                child: Column(children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.width / 1.5,
                    decoration: const BoxDecoration(
                        // shape: BoxShape.circle,
                        ),
                    child: QueryArtworkWidget(
                      nullArtworkWidget: const IconWidget(
                        color: Colors.indigo,
                        icon: Icons.music_note,
                        size: 100,
                      ),
                      id: widget.playersong[currentIndex].id,
                      type: ArtworkType.AUDIO,
                      artworkBorder: BorderRadius.circular(200.0),
                      keepOldArtwork: true,
                    ),
                  ),
                  // const CircleAvatar(
                  //   radius: 100,
                  //   child: Icon(
                  //     Icons.music_note,
                  //     size: 88,
                  //   ),
                  //   // child: QueryArtworkWidget(
                  //   //     artworkFit: BoxFit.cover,
                  //   //     size: 100,
                  //   //     id: widget.songModel.id,
                  //   //     type: ArtworkType.AUDIO),
                  // ),
                  SizedBox(height: MediaQuery.of(context).size.height / 20),
                  AnimatedText(
                    text: widget.playersong[currentIndex].displayNameWOExt
                        .split('(')[0]
                        .split('|')[0]
                        .trim(),
                    pauseAfterRound: const Duration(seconds: 3),
                    showFadingOnlyWhenScrolling: false,
                    fadingEdgeEndFraction: 0.1,
                    fadingEdgeStartFraction: 0.1,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: white,
                    ),
                  ),
                  const SizedBox(height: 18.0),
                  AnimatedText(
                      text:
                          widget.playersong[currentIndex].artist ?? "Unkonown",
                      pauseAfterRound: const Duration(seconds: 3),
                      showFadingOnlyWhenScrolling: false,
                      fadingEdgeEndFraction: 0.1,
                      fadingEdgeStartFraction: 0.1,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: white,
                      )),

                  // Text(widget.songModel[currentIndex].displayNameWOExt,
                  //     overflow: TextOverflow.fade,
                  //     maxLines: 1,
                  //     style: const TextStyle(
                  //         fontSize: 30,
                  //         fontWeight: FontWeight.bold,
                  //         color: white)),
                  // const SizedBox(height: 18.0),
                  // Text(
                  //     widget.songModel[currentIndex].artist.toString() ==
                  //             "<unkown>"
                  //         ? "Unknown Artist"
                  //         : widget.songModel[currentIndex].artist.toString(),
                  //     overflow: TextOverflow.fade,
                  //     maxLines: 1,
                  //     style: const TextStyle(
                  //         fontSize: 20,
                  //         fontWeight: FontWeight.bold,
                  //         color: white)),
                  SizedBox(height: height / 50),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showSliderDialog(
                              context: context,
                              title: 'Adjust Volume',
                              divisions: 10,
                              min: 0.0,
                              max: 1.0,
                              value: GetSong.player.volume,
                              stream: GetSong.player.volumeStream,
                              onChanged: GetSong.player.setVolume);
                        },
                        icon: GetSong.player.volume == 0.0
                            ? const Icon(
                                Icons.volume_off,
                                color: white,
                              )
                            : const Icon(
                                Icons.volume_up,
                                color: white,
                              ),
                      ),
                      StreamBuilder(
                          stream: GetSong.player.speedStream,
                          builder: (context, snapshot) {
                            return IconButton(
                              onPressed: () {
                                showSliderDialog(
                                    context: context,
                                    title: 'Adjust Speed',
                                    divisions: 10,
                                    min: 0.5,
                                    max: 1.5,
                                    value: GetSong.player.speed,
                                    stream: GetSong.player.speedStream,
                                    onChanged: GetSong.player.setSpeed);
                              },
                              icon: snapshot.data == 1.0
                                  ? Text(
                                      '${snapshot.data ?? 1.0}x',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: white),
                                    )
                                  : Text(
                                      '${snapshot.data ?? 1.0}x',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amber),
                                    ),
                              // icon: snapshot.data == 1.0
                              //     ? const Icon(
                              //         Icons.fast_forward,
                              //         color: white,
                              //       )
                              //     : const Icon(
                              //         Icons.fast_forward,
                              //         color: Colors.amberAccent,
                              //       ),
                            );
                          }),
                      FavButton(song: widget.playersong[currentIndex]),
                    ],
                  ),
                  SizedBox(height: height / 25),
                  // Container(
                  //     child: FavButton(song: widget.songModel[currentIndex])),

                  Row(
                    children: [
                      // Text(_position.toString().split('.')[0],
                      //     style: const TextStyle(color: white)),
                      Expanded(
                        child: StreamBuilder<DurationState>(
                            stream: _durationStateStream,
                            builder: (context, snapshot) {
                              final durationState = snapshot.data;
                              final progress =
                                  durationState?.position ?? Duration.zero;
                              final total =
                                  durationState?.total ?? Duration.zero;
                              return ProgressBar(
                                progress: progress,
                                total: total,
                                barHeight: 3.0,
                                thumbRadius: 5,
                                progressBarColor: Colors.white,
                                thumbColor: Colors.white,
                                baseBarColor: Colors.grey,
                                bufferedBarColor: Colors.grey,
                                buffered: const Duration(milliseconds: 2000),
                                timeLabelTextStyle:
                                    const TextStyle(color: white),
                                onSeek: (duration) {
                                  GetSong.player.seek(duration);
                                },
                              );
                            }),

                        //     child: Slider.adaptive(
                        //       activeColor: white,
                        //       inactiveColor: Colors.grey,
                        //       value: _position.inSeconds.toDouble(),
                        //       onChanged: (value) {
                        //         setState(() {
                        //           changeToSecond(value.toInt());
                        //           value = value;
                        //         });
                        //       },
                        //       max: _duration.inSeconds.toDouble(),
                        //       min: const Duration(microseconds: 0)
                        //           .inSeconds
                        //           .toDouble(),
                        //     ),
                        //   ),
                        //   Text(
                        //     _duration.toString().split('.')[0],
                        //     style: const TextStyle(color: white),
                        //   ),
                        // ],
                      ),
                      // Text(
                      //   _duration.toString().split('.')[0],
                      //   style: const TextStyle(color: white),
                      // ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StreamBuilder<bool>(
                        stream: GetSong.player.shuffleModeEnabledStream,
                        builder: (context, snapshot) {
                          final shuffleModeEnabled = snapshot.data ?? false;
                          return IconButton(
                            icon: shuffleModeEnabled
                                ? const Icon(Icons.shuffle,
                                    size: 40, color: Colors.orange)
                                : const Icon(
                                    Icons.shuffle,
                                    color: white,
                                    size: 40,
                                  ),
                            onPressed: () {
                              GetSong.player
                                  .setShuffleModeEnabled(!shuffleModeEnabled);
                            },
                          );
                        },
                      ),

                      // ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //         elevation: 0,
                      //         padding: const EdgeInsets.all(15.0),
                      //         primary: transparent,
                      //         onPrimary: white),
                      //     onPressed: () {
                      //       GetSong.player.setShuffleModeEnabled(true);
                      //       GetSong.player.setShuffleModeEnabled(false);
                      //       const ScaffoldMessenger(
                      //           child:
                      //               SnackBar(content: Text('Shuffle Enabled')));
                      //     },
                      //     child: StreamBuilder<bool>(
                      //       stream: GetSong.player.shuffleModeEnabledStream,
                      //       builder: (context, snapshot) {
                      //         bool? shuffle = snapshot.data;
                      //         if (shuffle != null && shuffle) {
                      //           return const Icon(
                      //             Icons.shuffle,
                      //             color: Colors.grey,
                      //             size: 25,
                      //           );
                      //         } else {
                      //           return const Icon(
                      //             Icons.shuffle,
                      //             color: white,
                      //             size: 30,
                      //           );
                      //         }
                      //       },
                      //     )),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (GetSong.player.hasPrevious) {
                                GetSong.player.seekToPrevious();
                                GetSong.player.play();
                              } else {
                                GetSong.player.play();
                              }
                            });
                          },
                          icon: const Icon(Icons.skip_previous,
                              color: white, size: 40)),
                      // StreamBuilder<PlayerState>(
                      //   stream: GetSong.player.playerStateStream,
                      //   builder: (context, snapshot) {
                      //     final playerState = snapshot.data;
                      //     final processingState = playerState?.processingState;
                      //     final playing = playerState?.playing;
                      //     if (processingState == ProcessingState.loading ||
                      //         processingState == ProcessingState.buffering) {
                      //       return Container(
                      //         margin: const EdgeInsets.all(8.0),
                      //         width: 64.0,
                      //         height: 64.0,
                      //         child: const CircularProgressIndicator(),
                      //       );
                      //     } else if (playing != true) {
                      //       return IconButton(
                      //         icon: const Icon(Icons.play_arrow, color: white),
                      //         iconSize: 64.0,
                      //         onPressed: GetSong.player.play,
                      //       );
                      //     } else if (processingState !=
                      //         ProcessingState.completed) {
                      //       return IconButton(
                      //         icon: const Icon(Icons.pause, color: white),
                      //         iconSize: 64.0,
                      //         onPressed: GetSong.player.pause,
                      //       );
                      //     } else {
                      //       return IconButton(
                      //         icon: const Icon(Icons.replay, color: white),
                      //         iconSize: 64.0,
                      //         onPressed: () =>
                      //             GetSong.player.seek(Duration.zero, index: 0),
                      //       );
                      //     }
                      //   },
                      // ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (_isPlaying) {
                                GetSong.player.pause();
                              } else {
                                GetSong.player.play();
                              }
                              _isPlaying = !_isPlaying;
                            });
                          },
                          icon: Icon(
                              _isPlaying ? Icons.pause : Icons.play_arrow,
                              color: white,
                              size: 40)),
                      IconButton(
                          onPressed: () {
                            setState(() async {
                              if (GetSong.player.hasNext) {
                                await GetSong.player.seekToNext();
                                await GetSong.player.play();
                              } else {
                                await GetSong.player.play();
                              }
                            });
                          },
                          icon: const Icon(Icons.skip_next,
                              color: white, size: 40)),
                      StreamBuilder<LoopMode>(
                        stream: GetSong.player.loopModeStream,
                        builder: (context, snapshot) {
                          final loopMode = snapshot.data ?? LoopMode.off;
                          const icons = [
                            Icon(Icons.repeat, color: white, size: 35),
                            Icon(Icons.repeat, color: Colors.amber, size: 35),
                            Icon(Icons.repeat_one,
                                color: Colors.amber, size: 35),
                          ];
                          const cycleModes = [
                            LoopMode.off,
                            LoopMode.all,
                            LoopMode.one,
                          ];
                          final index = cycleModes.indexOf(loopMode);
                          return IconButton(
                            icon: icons[index],
                            onPressed: () {
                              GetSong.player.setLoopMode(cycleModes[
                                  (cycleModes.indexOf(loopMode) + 1) %
                                      cycleModes.length]);
                            },
                          );
                        },
                      ),
                      // ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //         elevation: 0,
                      //         primary: Colors.transparent,
                      //         onPrimary: Colors.white),
                      //     onPressed: () {
                      //       GetSong.player.loopMode == LoopMode.one
                      //           ? GetSong.player.setLoopMode(LoopMode.all)
                      //           : GetSong.player.setLoopMode(LoopMode.one);
                      //     },
                      //     child: StreamBuilder<LoopMode>(
                      //       stream: GetSong.player.loopModeStream,
                      //       builder: (context, snapshot) {
                      //         final loopMode = snapshot.data;
                      //         if (LoopMode.one == loopMode) {
                      //           return const Icon(
                      //             Icons.repeat_one,
                      //             color: Colors.white,
                      //             size: 25,
                      //           );
                      //         } else {
                      //           return const Icon(
                      //             Icons.repeat,
                      //             size: 30,
                      //           );
                      //         }
                      //       },
                      //     )),
                      // InkWell(
                      //   onTap: () {
                      //     final loopMode = GetSong.player.loopMode;
                      //     final shuffle = GetSong.player.shuffleModeEnabled;
                      //     if (LoopMode.all == loopMode && !shuffle) {
                      //       GetSong.player.setLoopMode(LoopMode.one);
                      //     } else if (LoopMode.one == loopMode && !shuffle) {
                      //       GetSong.player.setLoopMode(LoopMode.all);
                      //       GetSong.player.setShuffleModeEnabled(true);
                      //     } else {
                      //       GetSong.player.setLoopMode(LoopMode.all);
                      //       GetSong.player.setShuffleModeEnabled(false);
                      //     }
                      //   },
                      //   child: StreamBuilder<LoopMode>(
                      //     stream: GetSong.player.loopModeStream,
                      //     builder: (context, snapshot) {
                      //       final loopMode = snapshot.data;
                      //       final shuffle = GetSong.player.shuffleModeEnabled;
                      //       if (LoopMode.all == loopMode && !shuffle) {
                      //         return const Icon(
                      //           Icons.repeat,
                      //           color: white,
                      //         );
                      //       } else if (LoopMode.one == loopMode && !shuffle) {
                      //         return const Icon(
                      //           Icons.repeat_one,
                      //           color: white,
                      //         );
                      //       } else if (LoopMode.all == loopMode && shuffle) {
                      //         return const Icon(
                      //           Icons.shuffle,
                      //           color: white,
                      //         );
                      //       }
                      //       return const Icon(
                      //         Icons.shuffle,
                      //         color: white,
                      //         size: 40,
                      //       );
                      //     },
                      //   ),
                      // ),
                      // InkWell(
                      //   onTap: () {
                      //     setState(() {
                      //       if (currentIndex > 0) {
                      //         currentIndex--;
                      //       } else {
                      //         currentIndex = widget.songModel.length - 1;
                      //       }
                      //       playsong();
                      //     });
                      //   },
                      //   child: const Icon(
                      //     Icons.skip_previous,
                      //     color: white,
                      //     size: 40,
                      //   ),
                      // ),
                      // InkWell(
                      //   onTap: () {
                      //     if (GetSong.player.playing) {
                      //       GetSong.player.pause();
                      //     } else {
                      //       if (GetSong.player.currentIndex != null) {
                      //         GetSong.player.play();
                      //       }
                      //     }
                      //   },
                      //   child: Container(
                      //     padding: const EdgeInsets.all(20),
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       border: Border.all(
                      //         color: white,
                      //         width: 2,
                      //         style: BorderStyle.solid,
                      //       ),
                      //     ),
                      //     child: StreamBuilder<bool>(
                      //       stream: GetSong.player.playingStream,
                      //       builder: (context, snapshot) {
                      //         bool? playing = snapshot.data;
                      //         if (playing != null && playing) {
                      //           return const Icon(
                      //             Icons.pause,
                      //             color: white,
                      //             size: 40,
                      //         }
                      //         return const Icon(Icons.play_arrow,
                      //             color: white, size: 40);
                      //       },
                      //     ),
                      //   ),
                      // ),
                      // InkWell(
                      //   onTap: () {
                      //     setState(() {
                      //       if (currentIndex < widget.songModel.length - 1) {
                      //         currentIndex++;
                      //       } else {
                      //         currentIndex = 0;
                      //       }
                      //       playsong();
                      //     });
                      //   },
                      //   child: const Icon(
                      //     Icons.skip_next,
                      //     color: white,
                      //     size: 40,
                      //   ),
                      // ),
                      // FavButton(song: HomeScreen.songs[currentIndex]),
                      // IconButton(
                      //     onPressed: () {
                      //       setState(() {
                      //         if (widget.index > 0) {
                      //           widget.index--;
                      //         } else {
                      //           widget.index = widget.songModel.length - 1;
                      //         }
                      //         playsong();
                      //       });
                      //     },
                      //     icon: const Icon(
                      //       Icons.skip_previous,
                      //       color: white,
                      //       size: 40,
                      //     )),
                      // IconButton(
                      //     onPressed: () {
                      //       setState(() {
                      //         if (_isPlaying) {
                      //           widget.audioPlayer.pause();
                      //         } else {
                      //           widget.audioPlayer.play();
                      //         }
                      //         _isPlaying = !_isPlaying;
                      //       });
                      //     },
                      //     icon: Icon(
                      //       _isPlaying ? Icons.pause : Icons.play_arrow,
                      //       size: 40,
                      //       color: white,
                      //     )),
                      // IconButton(
                      //     onPressed: () {
                      //       setState(() {
                      //         if (widget.index <
                      //             widget.songModel.length - 1) {
                      //           widget.index++;
                      //         } else {
                      //           widget.index = 0;
                      //         }
                      //         playsong();
                      //       });
                      //     },
                      //     icon: const Icon(
                      //       Icons.skip_next,
                      //       color: white,
                      //       size: 40,
                      //     )),
                      // IconButton(
                      //     onPressed: () {
                      //       widget.audioPlayer.shuffle();
                      //     },
                      //     icon: Icon(
                      //       _isSelecting
                      //           ? Icons.shuffle_on
                      //           : Icons.shuffle_on,
                      //       color: Colors.yellow,
                      //       size: 40,
                      //     )),
                    ],
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  // void changeToSec(int sec) {
  //   Duration duration = Duration(seconds: sec);
  //   widget.audioPlayer.seek(duration);
  // }

  Stream<DurationState> get _durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
          GetSong.player.positionStream,
          GetSong.player.durationStream,
          (position, duration) => DurationState(
              position: position, total: duration ?? Duration.zero));
  void changeToSecond(int seconds) {
    Duration duration = Duration(seconds: seconds);
    GetSong.player.seek(duration);
  }

  void showSliderDialog({
    required BuildContext context,
    required String title,
    required int divisions,
    required double min,
    required double max,
    String valueSuffix = '',
    // TODO: Replace these two by ValueStream.
    required double value,
    required Stream<double> stream,
    required ValueChanged<double> onChanged,
  }) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, textAlign: TextAlign.center),
        content: StreamBuilder<double>(
          stream: stream,
          builder: (context, snapshot) => SizedBox(
            height: 100.0,
            child: Column(
              children: [
                Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                    style: const TextStyle(
                        fontFamily: 'Fixed',
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0)),
                Slider(
                  divisions: divisions,
                  min: min,
                  max: max,
                  value: snapshot.data ?? value,
                  onChanged: onChanged,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}
