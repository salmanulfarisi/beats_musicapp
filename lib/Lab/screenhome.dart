// import 'dart:developer';
// import 'package:beats/Db/favaroitedb.dart';
// import 'package:beats/Pages/Screen/nowplaying.dart';
// import 'package:beats/Pages/widgets/favbutton.dart';
// import 'package:beats/utilits/globalcolors.dart';
// import 'package:beats/widgets/iconwidgets.dart';
// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// import 'package:permission_handler/permission_handler.dart';

// class ScreenHome extends StatefulWidget {
//   const ScreenHome({Key? key}) : super(key: key);
//   static List<SongModel> songs = [];

//   @override
//   State<ScreenHome> createState() => _ScreenHomeState();
// }

// class _ScreenHomeState extends State<ScreenHome> {
//   @override
//   void initState() {
//     requestPermission();
//     super.initState();
//   }

//   void requestPermission() async {
//     await Permission.storage.request();
//     setState(() {});
//   }

//   final _audioQuery = OnAudioQuery();
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   @override
//   Widget build(BuildContext context) {
//     FavaroiteDb.favaroiteList.notifyListeners();
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 218, 214, 214),
//       extendBody: true,
//       appBar: AppBar(
//         backgroundColor: Colors.white30,
//         elevation: 0,
//         title: const Text(
//           'Beats',
//           style: TextStyle(
//               color: black, fontSize: 30, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(left: 16, right: 16),
//         child: FutureBuilder<List<SongModel>>(
//           future: _audioQuery.querySongs(
//             sortType: null,
//             orderType: OrderType.ASC_OR_SMALLER,
//             uriType: UriType.EXTERNAL,
//             ignoreCase: true,
//           ),
//           builder: (context, items) {
//             if (items.data == null) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             if (items.data!.isEmpty) {
//               return const Center(child: Text('No songs found'));
//             }
//             ScreenHome.songs = items.data!;
//             if (!FavaroiteDb.isInitialized) {
//               FavaroiteDb.initialise(items.data!);
//             }
//             return ListView.builder(
//               itemCount: items.data!.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   color: Colors.grey[500],
//                   child: ListTile(
//                     leading: QueryArtworkWidget(
//                         nullArtworkWidget: const IconWidget(
//                           color: Colors.indigo,
//                           icon: Icons.music_note,
//                           size: 35,
//                         ),
//                         id: items.data![index].id,
//                         type: ArtworkType.AUDIO),
//                     // leading: const Icon(Icons.music_note),
//                     title: Text(items.data![index].displayNameWOExt),
//                     subtitle: Text("${items.data![index].artist}"),
//                     trailing: FavButton(song: ScreenHome.songs[index]),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => NowPlayingScreen(
//                             songModel: items.data!,
//                             audioPlayer: _audioPlayer,
//                             index: index,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }

//   playSong(String? uri) {
//     try {
//       _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
//       _audioPlayer.play();
//     } on Exception {
//       log('Error playing song');
//     }
//   }
// }
