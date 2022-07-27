// import 'package:beats/Pages/Screen/nowplaying.dart';
// import 'package:beats/Pages/homescreen.dart';
// import 'package:beats/Pages/widgets/getsong.dart';
// import 'package:beats/utilits/globalcolors.dart';
// import 'package:beats/widgets/iconwidgets.dart';
// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class ScreenSearch extends StatefulWidget {
//   const ScreenSearch({Key? key}) : super(key: key);

//   @override
//   State<ScreenSearch> createState() => _ScreenSearchState();
// }

// class _ScreenSearchState extends State<ScreenSearch> {
//   // This holds a list of fiction users
//   // You can use data fetched from a database or a server as well
//   final AudioPlayer audioPlayer = AudioPlayer();
//   final OnAudioQuery _audioQuery = OnAudioQuery();
//   List<SongModel> searchSongs = [];
//   Future getSongs() async {
//     searchSongs = await Future.value(_audioQuery.querySongs(
//         sortType: null,
//         orderType: OrderType.ASC_OR_SMALLER,
//         uriType: UriType.EXTERNAL,
//         ignoreCase: true));
//   }

//   List<SongModel> allsongs = [];

//   @override
//   initState() {
//     // at the beginning, all users are shown
//     allsongs = searchSongs;
//     super.initState();
//   }

//   // This function is called whenever the text field changes
//   void _runFilter(String enteredKeyword) {
//     List<SongModel> results = [];

//     if (enteredKeyword.isEmpty) {
//       // if the search field is empty or only contains white-space, we'll display all users
//       results = searchSongs;
//     } else {
//       results = searchSongs
//           .where((name) => name.displayNameWOExt
//               .toLowerCase()
//               .contains(enteredKeyword.toLowerCase()))
//           .toList();
//       // we use the toLowerCase() method to make it case-insensitive
//     }

//     // Refresh the UI
//     setState(() {
//       allsongs = results;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     getSongs();
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//           gradient: LinearGradient(colors: [
//         Colors.black,
//         Colors.black.withOpacity(0.9),
//       ])),
//       child: Scaffold(
//         backgroundColor: transparent,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: transparent,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               TextField(
//                 style: const TextStyle(color: white),
//                 onChanged: (value) => _runFilter(value),
//                 decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: const BorderSide(color: white)),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     labelStyle: const TextStyle(color: white),
//                     labelText: 'Search',
//                     suffixIcon: const Icon(
//                       Icons.search,
//                       color: white,
//                     )),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Expanded(
//                 child: allsongs.isNotEmpty
//                     ? ListView.builder(
//                         itemCount: allsongs.length,
//                         itemBuilder: (context, index) {
//                           final data = allsongs[index];
//                           return GestureDetector(
//                             onTap: () {
//                               final searchIndex = creatSearchIndex(data);
//                               FocusScope.of(context).unfocus();
//                               GetSong.player.setAudioSource(
//                                   GetSong.createSongList(HomeScreen.songs),
//                                   initialIndex: searchIndex);
//                               GetSong.player.play();
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => NowPlayingScreen(
//                                             songModel: HomeScreen.songs,
//                                           )));
//                             },
//                             child: Card(
//                               // key: ValueKey(allsongs[index]),
//                               color:
//                                   Colors.accents[index % Colors.accents.length],
//                               margin: const EdgeInsets.symmetric(vertical: 10),
//                               child: ListTile(
//                                 leading: QueryArtworkWidget(
//                                   id: allsongs[index].id,
//                                   type: ArtworkType.AUDIO,
//                                   nullArtworkWidget: const IconWidget(
//                                       color: Colors.indigo,
//                                       icon: Icons.music_note),
//                                   artworkFit: BoxFit.cover,
//                                 ),
//                                 title: Text(
//                                   allsongs[index].displayNameWOExt,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 subtitle: Text(
//                                     allsongs[index].artist.toString(),
//                                     overflow: TextOverflow.ellipsis),
//                               ),
//                             ),
//                           );
//                         })
//                     : const Text(
//                         'No results found',
//                         style: TextStyle(fontSize: 24, color: white),
//                       ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   int? creatSearchIndex(SongModel data) {
//     for (int i = 0; i < HomeScreen.songs.length; i++) {
//       if (data.id == HomeScreen.songs[i].id) {
//         return i;
//       }
//     }
//     return null;
//   }
// }
