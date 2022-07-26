import 'package:beats/Db/playlistdb.dart';
import 'package:beats/Pages/Screen/nowplaying.dart';
import 'package:beats/Pages/Screen/songlist.dart';
import 'package:beats/Pages/widgets/emptyscreen.dart';
import 'package:beats/Pages/widgets/favbutton.dart';
import 'package:beats/Pages/widgets/getsong.dart';
import 'package:beats/model/playlistmodel.dart';
import 'package:beats/utilits/globalcolors.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistFolder extends StatefulWidget {
  final PlayListModel playlistModel;
  final int folderindex;

  const PlaylistFolder({
    Key? key,
    required this.playlistModel,
    required this.folderindex,
  }) : super(key: key);

  @override
  State<PlaylistFolder> createState() => _PlaylistFolderState();
}

late List<SongModel> playlistSong;

class _PlaylistFolderState extends State<PlaylistFolder> {
  @override
  Widget build(BuildContext context) {
    PlayListDB.instance.getAllPlaylist();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        black,
        black.withOpacity(0.9),
      ])),
      child: Scaffold(
        backgroundColor: transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.playlistModel.name),
          elevation: 0,
          backgroundColor: transparent,
          // automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                emptyScreen(context, 3, 'Hey,Dude', 15.0, 'Do You Want', 50.0,
                    'Add New Song', 23.0),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 1.5),
                  child: FloatingActionButton(
                    backgroundColor: Colors.amberAccent,
                    foregroundColor: Colors.black,
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (context, animation, _) {
                        return SongsListPage(playlist: widget.playlistModel);
                      }));
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>
                      //         SongsListPage(playlist: widget.playlistModel)));
                    },
                    child: const Icon(
                      Icons.add,
                      size: 50,
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable:
                      Hive.box<PlayListModel>('playlist_db').listenable(),
                  builder: (BuildContext context, Box<PlayListModel> value,
                      Widget? child) {
                    playlistSong = listPlaylist(
                        value.values.toList()[widget.folderindex].songsId);
                    // final length = value.length;
                    // PlaylistFolder.playlistcount = playlistSong.toList();
                    return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              List<SongModel> newList = [...playlistSong];
                              GetSong.player.setAudioSource(
                                  GetSong.createSongList([newList[index]]));
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NowPlayingScreen(
                                        songModel: [playlistSong[index]],
                                      )));
                              GetSong.player.play();
                            },
                            leading: QueryArtworkWidget(
                              id: playlistSong[index].id,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: const Icon(
                                Icons.music_note,
                                color: white,
                              ),
                              errorBuilder: (context, exception, gdb) {
                                setState(() {});
                                return Image.asset('');
                              },
                            ),
                            title: Text(
                              playlistSong[index].displayNameWOExt,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: white,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              playlistSong[index].artist!,
                              style: const TextStyle(
                                  color: white,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (builder) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  black,
                                                  black.withOpacity(0.9),
                                                ],
                                                stops: const [0.5, 1],
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(25.0),
                                                      topRight: Radius.circular(
                                                          25.0))),
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2.3,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      25.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      25.0)),
                                                      color:
                                                          Colors.transparent),
                                                  child: QueryArtworkWidget(
                                                      artworkQuality:
                                                          FilterQuality.high,
                                                      artworkBlendMode:
                                                          BlendMode.dstATop,
                                                      artworkFit:
                                                          BoxFit.fitWidth,
                                                      artworkBorder:
                                                          BorderRadius.circular(
                                                              20),
                                                      artworkHeight: 300,
                                                      nullArtworkWidget:
                                                          const Icon(
                                                        Icons.music_note,
                                                        size: 100,
                                                      ),
                                                      id: playlistSong[index]
                                                          .id,
                                                      type: ArtworkType.AUDIO),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              playlistSong[
                                                                      index]
                                                                  .displayNameWOExt,
                                                              style: const TextStyle(
                                                                  color: white,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              playlistSong[
                                                                      index]
                                                                  .artist!,
                                                              style: const TextStyle(
                                                                  color: white,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            widget.playlistModel
                                                                .remove(
                                                                    playlistSong[
                                                                            index]
                                                                        .id);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          icon: const Icon(
                                                            Icons.delete,
                                                            color: Colors.red,
                                                          )),
                                                      FavButton(
                                                          song: playlistSong[
                                                              index])
                                                    ],
                                                  ),
                                                ),
                                                // Padding(
                                                //   padding: const EdgeInsets.all(
                                                //       18.0),
                                                //   child: Column(
                                                //     mainAxisAlignment:
                                                //         MainAxisAlignment.start,
                                                //     crossAxisAlignment:
                                                //         CrossAxisAlignment
                                                //             .start,
                                                //     children: [
                                                //       ElevatedButton.icon(
                                                //           style: ElevatedButton
                                                //               .styleFrom(
                                                //                   primary: Colors
                                                //                       .white),
                                                //           onPressed: () {
                                                //             widget.playlistModel
                                                //                 .remove(
                                                //                     playlistSong[
                                                //                             index]
                                                //                         .id);
                                                //             Navigator.of(
                                                //                     context)
                                                //                 .pop();
                                                //           },
                                                //           icon: const Icon(
                                                //             Icons
                                                //                 .delete_outline_outlined,
                                                //             size: 25,
                                                //           ),
                                                //           label: const Text(
                                                //             'Remove Song',
                                                //             style: TextStyle(
                                                //               color:
                                                //                   Colors.black,
                                                //               fontSize: 20,
                                                //             ),
                                                //           )),
                                                //       Row(
                                                //         children: [
                                                //           FavButton(
                                                //             song: playlistSong[
                                                //                 index],
                                                //           ),
                                                //           const Text(
                                                //             'Add to Favorite',
                                                //             style: TextStyle(
                                                //                 color: Colors
                                                //                     .black,
                                                //                 fontSize: 20),
                                                //           )
                                                //         ],
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.more_horiz,
                                  color: white,
                                )),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(
                              color: Colors.grey,
                            ),
                        itemCount: playlistSong.length);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<SongModel> listPlaylist(List<int> data) {
    List<SongModel> plsongs = [];
    for (int i = 0; i < GetSong.songscopy.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (GetSong.songscopy[i].id == data[j]) {
          plsongs.add(GetSong.songscopy[i]);
        }
      }
    }
    return plsongs;
  }
}
