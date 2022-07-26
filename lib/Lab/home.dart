// import 'package:beats/Pages/widgets/getsong.dart';
// import 'package:flutter/material.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class LocalPlaylists extends StatefulWidget {
//   final List<PlaylistModel> playlistDetails;
//   final OfflineAudioQuery offlineAudioQuery;
//   const LocalPlaylists({
//     required this.playlistDetails,
//     required this.offlineAudioQuery,
//   });
//   @override
//   _LocalPlaylistsState createState() => _LocalPlaylistsState();
// }

// class _LocalPlaylistsState extends State<LocalPlaylists> {
//   List<PlaylistModel> playlistDetails = [];
//   @override
//   Widget build(BuildContext context) {
//     if (playlistDetails.isEmpty) {
//       playlistDetails = widget.playlistDetails;
//     }
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const SizedBox(height: 5),
//           ListTile(
//             title: Text(GetSong.createPlaylist()),
//             leading: Card(
//               elevation: 0,
//               color: Colors.transparent,
//               child: SizedBox.square(
//                 dimension: 50,
//                 child: Center(
//                   child: Icon(
//                     Icons.add_rounded,
//                     color: Theme.of(context).iconTheme.color,
//                   ),
//                 ),
//               ),
//             ),
//             onTap: () async {
//               await showTextInputDialog(
//                 context: context,
//                 title: AppLocalizations.of(context)!.createNewPlaylist,
//                 initialText: '',
//                 keyboardType: TextInputType.name,
//                 onSubmitted: (String value) async {
//                   if (value.trim() != '') {
//                     Navigator.pop(context);
//                     await widget.offlineAudioQuery.createPlaylist(
//                       name: value,
//                     );
//                     widget.offlineAudioQuery.getPlaylists().then((value) {
//                       playlistDetails = value;
//                       setState(() {});
//                     });
//                   }
//                 },
//               );
//               setState(() {});
//             },
//           ),
//           if (playlistDetails.isEmpty)
//             const SizedBox()
//           else
//             ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: playlistDetails.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: Card(
//                     elevation: 5,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(7.0),
//                     ),
//                     clipBehavior: Clip.antiAlias,
//                     child: QueryArtworkWidget(
//                       id: playlistDetails[index].id,
//                       type: ArtworkType.PLAYLIST,
//                       keepOldArtwork: true,
//                       artworkBorder: BorderRadius.circular(7.0),
//                       nullArtworkWidget: ClipRRect(
//                         borderRadius: BorderRadius.circular(7.0),
//                         child: const Image(
//                           fit: BoxFit.cover,
//                           height: 50.0,
//                           width: 50.0,
//                           image: AssetImage('assets/cover.jpg'),
//                         ),
//                       ),
//                     ),
//                   ),
//                   title: Text(
//                     playlistDetails[index].playlist,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   subtitle: Text(
//                     '${playlistDetails[index].numOfSongs} ${AppLocalizations.of(context)!.songs}',
//                   ),
//                   trailing: PopupMenuButton(
//                     icon: const Icon(Icons.more_vert_rounded),
//                     shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(15.0),
//                       ),
//                     ),
//                     onSelected: (int? value) async {
//                       if (value == 0) {
//                         if (await widget.offlineAudioQuery.removePlaylist(
//                           playlistId: playlistDetails[index].id,
//                         )) {
//                           ShowSnackBar().showSnackBar(
//                             context,
//                             '${AppLocalizations.of(context)!.deleted} ${playlistDetails[index].playlist}',
//                           );
//                           playlistDetails.removeAt(index);
//                           setState(() {});
//                         } else {
//                           ShowSnackBar().showSnackBar(
//                             context,
//                             AppLocalizations.of(context)!.failedDelete,
//                           );
//                         }
//                       }
//                       // if (value == 3) {
//                       //   TextInputDialog().showTextInputDialog(
//                       //       context: context,
//                       //       keyboardType: TextInputType.text,
//                       //       title: AppLocalizations.of(context)!
//                       //           .rename,
//                       //       initialText:
//                       //           playlistDetails[index].playlist,
//                       //       onSubmitted: (value) async {
//                       //         Navigator.pop(context);
//                       //         await offlineAudioQuery
//                       //             .renamePlaylist(
//                       //                 playlistId:
//                       //                     playlistDetails[index].id,
//                       //                 newName: value);
//                       //         offlineAudioQuery
//                       //             .getPlaylists()
//                       //             .then((value) {
//                       //           playlistDetails = value;
//                       //           setState(() {});
//                       //         });
//                       //       });
//                       // }
//                     },
//                     itemBuilder: (context) => [
//                       // PopupMenuItem(
//                       //   value: 3,
//                       //   child: Row(
//                       //     children: [
//                       //       const Icon(Icons.edit_rounded),
//                       //       const SizedBox(width: 10.0),
//                       //       Text(AppLocalizations.of(context)!
//                       //           .rename),
//                       //     ],
//                       //   ),
//                       // ),
//                       PopupMenuItem(
//                         value: 0,
//                         child: Row(
//                           children: [
//                             const Icon(Icons.delete_rounded),
//                             const SizedBox(width: 10.0),
//                             Text(
//                               AppLocalizations.of(context)!.delete,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   onTap: () async {
//                     final songs =
//                         await widget.offlineAudioQuery.getPlaylistSongs(
//                       playlistDetails[index].id,
//                     );
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DownloadedSongs(
//                           title: playlistDetails[index].playlist,
//                           cachedSongs: songs,
//                           playlistId: playlistDetails[index].id,
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             )
//         ],
//       ),
//     );
//   }
// }
