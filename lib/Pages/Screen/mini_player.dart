import 'package:beats/Pages/Screen/nowplaying.dart';
import 'package:beats/Pages/widgets/getsong.dart';
import 'package:beats/Pages/widgets/textanimation.dart';
import 'package:beats/utilits/globalcolors.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  void initState() {
    GetSong.player.currentIndexStream.listen((index) {
      if (index != null) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: black.withOpacity(0.5),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      //height: MediaQuery.of(context).size.height * 0.2,
      width: double.infinity,
      height: 70,
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NowPlayingScreen(
                playersong: GetSong.playingSongs,
              ),
            ),
          );
        },
        iconColor: white,
        textColor: const Color.fromARGB(255, 255, 255, 255),
        leading: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: QueryArtworkWidget(
              artworkQuality: FilterQuality.high,
              artworkFit: BoxFit.fill,
              artworkBorder: BorderRadius.circular(5),
              nullArtworkWidget: const Icon(Icons.music_note),
              id: GetSong.playingSongs[GetSong.player.currentIndex!].id,
              type: ArtworkType.AUDIO,
            ),
          ),
        ),
        title: AnimatedText(
          text: GetSong
              .playingSongs[GetSong.player.currentIndex!].displayNameWOExt,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        subtitle: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            "${GetSong.playingSongs[GetSong.player.currentIndex!].artist}",
            style:
                const TextStyle(fontSize: 11, overflow: TextOverflow.ellipsis),
          ),
        ),
        trailing: FittedBox(
          fit: BoxFit.fill,
          child: Row(
            children: [
              IconButton(
                  onPressed: () async {
                    if (GetSong.player.hasPrevious) {
                      await GetSong.player.seekToPrevious();
                      await GetSong.player.play();
                    } else {
                      await GetSong.player.play();
                    }
                  },
                  icon: const Icon(
                    Icons.skip_previous,
                    size: 35,
                  )),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    primary: Colors.black,
                    onPrimary: Colors.amber),
                onPressed: () async {
                  if (GetSong.player.playing) {
                    await GetSong.player.pause();
                    setState(() {});
                  } else {
                    await GetSong.player.play();
                    setState(() {});
                  }
                },
                child: StreamBuilder<bool>(
                  stream: GetSong.player.playingStream,
                  builder: (context, snapshot) {
                    bool? playingStage = snapshot.data;
                    if (playingStage != null && playingStage) {
                      return const Icon(
                        Icons.pause_circle_outline,
                        size: 35,
                      );
                    } else {
                      return const Icon(
                        Icons.play_circle_outline,
                        size: 35,
                      );
                    }
                  },
                ),
              ),
              IconButton(
                  onPressed: (() async {
                    if (GetSong.player.hasNext) {
                      await GetSong.player.seekToNext();
                      await GetSong.player.play();
                    } else {
                      await GetSong.player.play();
                    }
                  }),
                  icon: const Icon(
                    Icons.skip_next,
                    size: 35,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}



























// // class Mini extends StatefulWidget {
// //   const Mini({Key? key}) : super(key: key);

// //   @override
// //   State<Mini> createState() => _MiniState();
// // }

// // class _MiniState extends State<Mini> {
// //   @override
// //   void initState() {
// //     GetSong.player.currentIndexStream.listen((index) {
// //       if (index != null && mounted) {
// //         setState(() {});
// //       }
// //     });
// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return AnimatedContainer(
// //       color: black.withOpacity(0.7),
// //       duration: const Duration(milliseconds: 500),
// //       curve: Curves.easeInOut,
// //       //height: MediaQuery.of(context).size.height * 0.2,
// //       width: double.infinity,
// //       height: 70,
// //       child: ListTile(
// //         onTap: () {
// //           Navigator.of(context).push(
// //             MaterialPageRoute(
// //               builder: (context) => NowPlayingScreen(
// //                 playersong: GetSong.playingSongs,
// //               ),
// //             ),
// //           );
// //         },
// //         iconColor: white,
// //         textColor: const Color.fromARGB(255, 255, 255, 255),
// //         leading: Padding(
// //           padding: const EdgeInsets.all(0),
// //           child: Container(
// //             height: MediaQuery.of(context).size.height * 0.2,
// //             width: MediaQuery.of(context).size.width * 0.2,
// //             decoration: BoxDecoration(color: black.withOpacity(0.10)),
// //             child: QueryArtworkWidget(
// //               artworkQuality: FilterQuality.high,
// //               artworkFit: BoxFit.fill,
// //               artworkBorder: BorderRadius.circular(5),
// //               nullArtworkWidget: const Icon(
// //                 Icons.music_note,
// //                 color: white,
// //               ),
// //               id: GetSong.playingSongs[GetSong.player.currentIndex!].id,
// //               type: ArtworkType.AUDIO,
// //             ),
// //           ),
// //         ),
// //         title: AnimatedText(
// //           text: GetSong
// //               .playingSongs[GetSong.player.currentIndex!].displayNameWOExt,
// //           style: const TextStyle(
// //             fontWeight: FontWeight.bold,
// //             fontSize: 15,
// //           ),
// //         ),
// //         subtitle: SingleChildScrollView(
// //           scrollDirection: Axis.horizontal,
// //           child: Text(
// //             "${GetSong.playingSongs[GetSong.player.currentIndex!].artist}",
// //             style:
// //                 const TextStyle(fontSize: 11, overflow: TextOverflow.ellipsis),
// //           ),
// //         ),
// //         trailing: FittedBox(
// //           fit: BoxFit.fill,
// //           child: Row(
// //             children: [
// //               IconButton(
// //                   onPressed: () async {
// //                     if (GetSong.player.hasPrevious) {
// //                       await GetSong.player.seekToPrevious();
// //                       await GetSong.player.play();
// //                     } else {
// //                       await GetSong.player.play();
// //                     }
// //                   },
// //                   icon: const Icon(
// //                     Icons.skip_previous,
// //                     size: 35,
// //                   )),
// //               ElevatedButton(
// //                 style: ElevatedButton.styleFrom(
// //                     shape: const CircleBorder(),
// //                     primary: Colors.black,
// //                     onPrimary: Colors.amberAccent),
// //                 onPressed: () async {
// //                   if (GetSong.player.playing) {
// //                     await GetSong.player.pause();
// //                     setState(() {});
// //                   } else {
// //                     await GetSong.player.play();
// //                     setState(() {});
// //                   }
// //                 },
// //                 child: StreamBuilder<bool>(
// //                   stream: GetSong.player.playingStream,
// //                   builder: (context, snapshot) {
// //                     bool? playingStage = snapshot.data;
// //                     if (playingStage != null && playingStage) {
// //                       return const Icon(
// //                         Icons.pause_circle_outline,
// //                         size: 35,
// //                       );
// //                     } else {
// //                       return const Icon(
// //                         Icons.play_circle_outline,
// //                         size: 35,
// //                       );
// //                     }
// //                   },
// //                 ),
// //               ),
// //               IconButton(
// //                   onPressed: (() async {
// //                     if (GetSong.player.hasNext) {
// //                       await GetSong.player.seekToNext();
// //                       await GetSong.player.play();
// //                     } else {
// //                       await GetSong.player.play();
// //                     }
// //                   }),
// //                   icon: const Icon(
// //                     Icons.skip_next,
// //                     size: 35,
// //                   )),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
