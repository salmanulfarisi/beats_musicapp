// import 'package:beats/Db/favaroitedb.dart';
// import 'package:beats/Pages/Screen/nowplaying.dart';
// import 'package:beats/Pages/widgets/getsong.dart';
// import 'package:beats/Pages/widgets/textanimation.dart';
// import 'package:beats/utilits/globalcolors.dart';
// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class MiniPlayer extends StatefulWidget {
//   const MiniPlayer({Key? key}) : super(key: key);

//   @override
//   State<MiniPlayer> createState() => _MiniPlayerState();
// }

// class _MiniPlayerState extends State<MiniPlayer> {
//   @override
//   void initState() {
//     GetSong.player.currentIndexStream.listen((index) {
//       if (index != null && mounted) {
//         setState(() {});
//       }
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       color: Colors.black.withOpacity(0.5),
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//       height: GetSong.player.currentIndex != null ? 70 : 0,
//       width: MediaQuery.of(context).size.width,
//       // height: 70,
//       child: ListTile(
//         onTap: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => NowPlayingScreen(
//                 playersong: GetSong.playingSongs,
//               ),
//             ),
//           );
//         },
//         iconColor: white,
//         textColor: white,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 10),
//           child: Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width / 5,
//             // decoration: const BoxDecoration(color: Colors.black),
//             child: StreamBuilder<PlayerState>(
//                 stream: GetSong.player.playerStateStream,
//                 builder: (context, snapshot) {
//                   final playerState = snapshot.data;
//                   final processingState = playerState?.processingState;
//                   final playing = playerState?.playing;
//                   if (processingState == ProcessingState.loading ||
//                       processingState == ProcessingState.buffering) {
//                     return QueryArtworkWidget(
//                       artworkBorder: BorderRadius.circular(10),
//                       nullArtworkWidget: const Icon(
//                         Icons.music_note,
//                         size: 40,
//                       ),
//                       artworkHeight: 400,
//                       artworkWidth: 400,
//                       id: GetSong.playingSongs[GetSong.player.currentIndex!].id,
//                       type: ArtworkType.AUDIO,
//                     );
//                   } else {
//                     return QueryArtworkWidget(
//                       artworkBorder: BorderRadius.circular(10),
//                       nullArtworkWidget: const Icon(
//                         Icons.music_note,
//                         size: 40,
//                       ),
//                       artworkHeight: 400,
//                       artworkWidth: 400,
//                       id: GetSong.playingSongs[GetSong.player.currentIndex!].id,
//                       type: ArtworkType.AUDIO,
//                     );
//                   }
//                 }),
//             // child: QueryArtworkWidget(
//             //   artworkBorder: BorderRadius.circular(10),
//             //   nullArtworkWidget: const Icon(
//             //     Icons.music_note,
//             //     size: 40,
//             //   ),
//             //   artworkHeight: 400,
//             //   artworkWidth: 400,
//             //   id: GetSong.playingSongs[GetSong.player.currentIndex!].id,
//             //   type: ArtworkType.AUDIO,
//             // ),
//           ),
//         ),
//         title: StreamBuilder<PlayerState>(
//             stream: GetSong.player.playerStateStream,
//             builder: (context, snapshot) {
//               final playerState = snapshot.data;
//               final processingState = playerState?.processingState;
//               // final playing = playerState?.playing;
//               if (processingState == ProcessingState.loading ||
//                   processingState == ProcessingState.buffering) {
//                 return AnimatedText(
//                     text: GetSong.playingSongs[GetSong.player.currentIndex!]
//                         .displayNameWOExt,
//                     pauseAfterRound: const Duration(seconds: 3),
//                     showFadingOnlyWhenScrolling: false,
//                     fadingEdgeEndFraction: 0.1,
//                     fadingEdgeStartFraction: 0.1,
//                     style: const TextStyle(
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                       color: white,
//                     ));
//               }
//               return AnimatedText(
//                   text: GetSong.playingSongs[GetSong.player.currentIndex!]
//                       .displayNameWOExt,
//                   pauseAfterRound: const Duration(seconds: 3),
//                   showFadingOnlyWhenScrolling: false,
//                   fadingEdgeEndFraction: 0.1,
//                   fadingEdgeStartFraction: 0.1,
//                   style: const TextStyle(
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold,
//                     color: white,
//                   ));
//             }),
//         subtitle: StreamBuilder<PlayerState>(
//             stream: GetSong.player.playerStateStream,
//             builder: (context, snapshot) {
//               final playerState = snapshot.data;
//               final processingState = playerState?.processingState;
//               // final playing = playerState?.playing;
//               if (processingState == ProcessingState.loading ||
//                   processingState == ProcessingState.buffering) {
//                 return AnimatedText(
//                     text: GetSong
//                         .playingSongs[GetSong.player.currentIndex!].artist!,
//                     pauseAfterRound: const Duration(seconds: 3),
//                     showFadingOnlyWhenScrolling: false,
//                     fadingEdgeEndFraction: 0.1,
//                     fadingEdgeStartFraction: 0.1,
//                     style: const TextStyle(
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.bold,
//                       color: white,
//                     ));
//               }
//               return AnimatedText(
//                   text: GetSong
//                       .playingSongs[GetSong.player.currentIndex!].artist!,
//                   pauseAfterRound: const Duration(seconds: 3),
//                   showFadingOnlyWhenScrolling: false,
//                   fadingEdgeEndFraction: 0.1,
//                   fadingEdgeStartFraction: 0.1,
//                   style: const TextStyle(
//                     fontSize: 14.0,
//                     fontWeight: FontWeight.bold,
//                     color: white,
//                   ));
//             }),
//         // title: AnimatedText(
//         //     text: GetSong
//         //         .playingSongs[GetSong.player.currentIndex!].displayNameWOExt,
//         //     pauseAfterRound: const Duration(seconds: 3),
//         //     showFadingOnlyWhenScrolling: false,
//         //     fadingEdgeEndFraction: 0.1,
//         //     fadingEdgeStartFraction: 0.1,
//         //     style: const TextStyle(
//         //       fontSize: 16.0,
//         //       fontWeight: FontWeight.bold,
//         //       color: white,
//         //     )),
//         // subtitle: AnimatedText(
//         //     text: GetSong.playingSongs[GetSong.player.currentIndex!].artist!,
//         //     pauseAfterRound: const Duration(seconds: 3),
//         //     showFadingOnlyWhenScrolling: false,
//         //     fadingEdgeEndFraction: 0.1,
//         //     fadingEdgeStartFraction: 0.1,
//         //     style: const TextStyle(
//         //       fontSize: 14.0,
//         //       fontWeight: FontWeight.bold,
//         //       color: white,
//         //     )),
//         // title: SingleChildScrollView(
//         //   scrollDirection: Axis.horizontal,
//         //   child: Text(
//         //     GetSong.playingSongs[GetSong.currentIndes].displayNameWOExt,
//         //     style:
//         //         const TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis),
//         //   ),
//         // ),
//         // subtitle: SingleChildScrollView(
//         //   scrollDirection: Axis.horizontal,
//         //   child: Text(
//         //     "${GetSong.playingSongs[GetSong.currentIndes].artist}",
//         //     style:
//         //         const TextStyle(fontSize: 11, overflow: TextOverflow.ellipsis),
//         //   ),
//         // ),
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             StreamBuilder<PlayerState>(
//                 stream: GetSong.player.playerStateStream,
//                 builder: (context, snapshot) {
//                   final playerState = snapshot.data;
//                   final processingState = playerState?.processingState;
//                   final playing = playerState?.playing;
//                   if (processingState == ProcessingState.loading ||
//                       processingState == ProcessingState.buffering) {
//                     return IconButton(
//                         onPressed: () {
//                           GetSong.player.seekToPrevious();
//                         },
//                         icon: const Icon(Icons.skip_previous));
//                   } else if (playing != true) {
//                     return IconButton(
//                         onPressed: () {
//                           GetSong.player.seekToPrevious();
//                         },
//                         icon: const Icon(Icons.skip_previous));
//                   } else {
//                     return IconButton(
//                         onPressed: () {
//                           GetSong.player.seekToPrevious();
//                         },
//                         icon: const Icon(Icons.skip_previous));
//                   }
//                 }),
//             // IconButton(
//             //     onPressed: () {
//             //       GetSong.player.seekToPrevious();
//             //     },
//             //     icon: const Icon(Icons.skip_previous)),
//             StreamBuilder<PlayerState>(
//               stream: GetSong.player.playerStateStream,
//               builder: (context, snapshot) {
//                 final playerState = snapshot.data;
//                 final processingState = playerState?.processingState;
//                 final playing = playerState?.playing;
//                 if (processingState == ProcessingState.loading ||
//                     processingState == ProcessingState.buffering) {
//                   return Container(
//                     margin: const EdgeInsets.all(8.0),
//                     // width: 64.0,
//                     // height: 64.0,
//                     child: const CircularProgressIndicator(),
//                   );
//                 } else if (playing != true) {
//                   return IconButton(
//                     icon: const Icon(Icons.play_arrow, color: white),
//                     iconSize: 35.0,
//                     onPressed: GetSong.player.play,
//                   );
//                 } else if (processingState != ProcessingState.completed) {
//                   return IconButton(
//                     icon: const Icon(Icons.pause, color: white),
//                     iconSize: 35.0,
//                     onPressed: GetSong.player.pause,
//                   );
//                 } else {
//                   return IconButton(
//                     icon: const Icon(Icons.replay, color: white),
//                     iconSize: 35.0,
//                     onPressed: () =>
//                         GetSong.player.seek(Duration.zero, index: 0),
//                   );
//                 }
//               },
//             ),
//             StreamBuilder<PlayerState>(
//                 stream: GetSong.player.playerStateStream,
//                 builder: (context, snapshot) {
//                   final playerState = snapshot.data;
//                   final processingState = playerState?.processingState;
//                   final playing = playerState?.playing;
//                   if (processingState == ProcessingState.loading ||
//                       processingState == ProcessingState.buffering) {
//                     return IconButton(
//                         onPressed: () {
//                           GetSong.player.seekToNext();
//                         },
//                         icon: const Icon(Icons.skip_next));
//                   } else if (playing != true) {
//                     return IconButton(
//                         onPressed: () {
//                           GetSong.player.seekToNext();
//                         },
//                         icon: const Icon(Icons.skip_next));
//                   } else {
//                     return IconButton(
//                         onPressed: () {
//                           GetSong.player.seekToNext();
//                         },
//                         icon: const Icon(Icons.skip_next));
//                   }
//                 }),
//             // ElevatedButton(
//             //   style: ElevatedButton.styleFrom(
//             //       shape: const CircleBorder(),
//             //       primary: black,
//             //       onPrimary: Colors.amberAccent),
//             //   onPressed: () async {
//             //     setState(() {
//             //       if (GetSong.player.playing) {
//             //         GetSong.player.pause();
//             //       } else {
//             //         GetSong.player.play();
//             //       }

//             //     });
//             //   },
//             //   child: StreamBuilder<bool>(
//             //     stream: GetSong.player.playingStream,
//             //     builder: (context, snapshot) {
//             //       bool? playingStage = snapshot.data;
//             //       if (playingStage != null && playingStage) {
//             //         return const Icon(
//             //           Icons.pause_circle_outline,
//             //           size: 35,
//             //         );
//             //       } else {
//             //         return const Icon(
//             //           Icons.play_circle_outline,
//             //           size: 35,
//             //         );
//             //       }
//             //     },
//             //   ),
//             // ),
//             // IconButton(
//             //     onPressed: () {
//             //       GetSong.player.seekToNext();
//             //     },
//             //     icon: const Icon(Icons.skip_next)),
//           ],
//         ),
//       ),
//     );
//   }
// }
