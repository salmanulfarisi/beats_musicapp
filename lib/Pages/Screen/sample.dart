import 'package:beats/Db/playlistdb.dart';
import 'package:beats/Pages/Screen/nowplaying.dart';
import 'package:beats/Pages/Screen/songlist.dart';
import 'package:beats/Pages/widgets/emptyscreen.dart';
import 'package:beats/Pages/widgets/favbutton.dart';
import 'package:beats/Pages/widgets/getsong.dart';
import 'package:beats/model/playlistmodel.dart';
import 'package:beats/utilits/globalcolors.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistData extends StatefulWidget {
  const PlaylistData(
      {Key? key, required this.playlist, required this.folderindex})
      : super(key: key);
  final PlayListModel playlist;
  final int folderindex;
  // static List<SongModel> playlistSongid = [];
  @override
  State<PlaylistData> createState() => _PlaylistDataState();
}

class _PlaylistDataState extends State<PlaylistData> {
  late List<SongModel> playlistsong;
  @override
  Widget build(BuildContext context) {
    PlayListDB.instance.getAllPlaylist();
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          black,
          black.withOpacity(0.9),
        ], stops: const [
          0.5,
          1
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back)),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: SafeArea(
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => SongsListPage(
                                playlist: widget.playlist,
                              )));
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
                // Text(widget.playlist.name,
                //     style: const TextStyle(
                //         color: Colors.white,
                //         fontSize: 30,
                //         fontWeight: FontWeight.bold)),
                // ElevatedButton(
                //     style: ElevatedButton.styleFrom(primary: Colors.white),
                //     onPressed: () {
                //       Navigator.of(context).push(MaterialPageRoute(
                //           builder: (ctx) => SongsListPage(
                //                 playlist: widget.playlist,
                //               )));
                //     },
                //     child: const Text('Add Songs')),
                ValueListenableBuilder(
                  valueListenable:
                      Hive.box<PlayListModel>('playlist_db').listenable(),
                  builder: (BuildContext context, Box<PlayListModel> value,
                      Widget? child) {
                    playlistsong = listPlaylist(
                        value.values.toList()[widget.folderindex].songsId);
                    //  PlaylistData.playlistSongid = playlistsong;

                    return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (ctx, index) {
                          return ListTile(
                              onTap: () {
                                List<SongModel> newlist = [...playlistsong];

                                GetSong.player.stop();
                                GetSong.player.setAudioSource(
                                    GetSong.createSongList(newlist),
                                    initialIndex: index);
                                GetSong.player.play();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => NowPlayingScreen(
                                          playersong: playlistsong,
                                        )));
                              },
                              leading: QueryArtworkWidget(
                                id: playlistsong[index].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: const Icon(
                                  Icons.music_note,
                                  color: Colors.white,
                                ),
                                errorBuilder: (context, excepion, gdb) {
                                  setState(() {});
                                  return Image.asset('');
                                },
                              ),
                              title: Text(
                                playlistsong[index].title,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              subtitle: Text(
                                playlistsong[index].artist!,
                                style: const TextStyle(color: Colors.white),
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
                                                  Colors.amberAccent,
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
                                            height: 350,
                                            child: Column(
                                              children: [
                                                Stack(
                                                  children: [
                                                    Container(
                                                      height: 350,
                                                      width: double.infinity,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: transparent,
                                                      ),
                                                      child: QueryArtworkWidget(
                                                          artworkBorder:
                                                              BorderRadius
                                                                  .circular(25),
                                                          artworkWidth: 100,
                                                          artworkHeight: 400,
                                                          nullArtworkWidget:
                                                              const Icon(
                                                            Icons.music_note,
                                                            size: 100,
                                                          ),
                                                          id: playlistsong[
                                                                  index]
                                                              .id,
                                                          type: ArtworkType
                                                              .AUDIO),
                                                    ),
                                                    Positioned(
                                                      bottom: 0,
                                                      child: Container(
                                                        width: 360,
                                                        height: 350,
                                                        decoration:
                                                            BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 30,
                                                              blurRadius: 5,
                                                              offset: const Offset(
                                                                  8,
                                                                  15), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 50,
                                                                  left: 10),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Expanded(
                                                                flex: 2,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Text(
                                                                      playlistsong[
                                                                              index]
                                                                          .displayNameWOExt,
                                                                      style: const TextStyle(
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              20),
                                                                    ),
                                                                    Text(
                                                                      playlistsong[
                                                                              index]
                                                                          .artist!,
                                                                      style: const TextStyle(
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              10),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  // ignore: prefer_const_literals_to_create_immutables
                                                                  children: [
                                                                    FavButton(
                                                                        song: playlistsong[
                                                                            index]),
                                                                    IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        widget
                                                                            .playlist
                                                                            .remove(playlistsong[index].id);
                                                                      },
                                                                      icon: Lottie
                                                                          .asset(
                                                                              'assets/Delete.json'),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                              // const Expanded(
                                                              //   flex: 1,
                                                              //   child: Icon(
                                                              //       Icons
                                                              //           .abc),
                                                              // ),
                                                              // const Expanded(
                                                              //   flex: 1,
                                                              //   child: Icon(
                                                              //       Icons
                                                              //           .abc),
                                                              // ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // Container(
                                                    //   alignment: Alignment
                                                    //       .bottomLeft,
                                                    //   child: Column(
                                                    //     children: [
                                                    //       Text(
                                                    //         playlistsong[
                                                    //                 index]
                                                    //             .title,
                                                    //         style: const TextStyle(
                                                    //             color: Colors
                                                    //                 .white,
                                                    //             fontSize: 20),
                                                    //       ),
                                                    //     ],
                                                    //   ),
                                                    // )
                                                  ],
                                                ),

                                                // Expanded(
                                                //   child: Text(
                                                //     playlistsong[index].title,
                                                //     style: const TextStyle(
                                                //         color: Colors.black,
                                                //         fontSize: 20,
                                                //         fontWeight:
                                                //             FontWeight.bold),
                                                //   ),
                                                // ),
                                                // Padding(
                                                //   padding:
                                                //       const EdgeInsets.all(
                                                //           18.0),
                                                //   // child: Column(
                                                //   //   mainAxisAlignment:
                                                //   //       MainAxisAlignment
                                                //   //           .start,
                                                //   //   crossAxisAlignment:
                                                //   //       CrossAxisAlignment
                                                //   //           .start,
                                                //   //   children: [
                                                //   //     ElevatedButton.icon(
                                                //   //         style: ElevatedButton
                                                //   //             .styleFrom(
                                                //   //                 primary: Colors
                                                //   //                     .white),
                                                //   //         onPressed: () {
                                                //   //           widget.playlist.remove(
                                                //   //               playlistsong[
                                                //   //                       index]
                                                //   //                   .id);
                                                //   //           Navigator.of(
                                                //   //                   context)
                                                //   //               .pop();
                                                //   //         },
                                                //   //         icon: const Icon(
                                                //   //           Icons
                                                //   //               .delete_outline_outlined,
                                                //   //           size: 25,
                                                //   //         ),
                                                //   //         label: const Text(
                                                //   //           'Remove Song',
                                                //   //           style: TextStyle(
                                                //   //             color: Colors
                                                //   //                 .black,
                                                //   //             fontSize: 20,
                                                //   //           ),
                                                //   //         )),
                                                //   //     // Row(
                                                //   //     //   children: [
                                                //   //     //     FavButton(
                                                //   //     //       song:
                                                //   //     //           playlistsong[
                                                //   //     //               index],
                                                //   //     //     ),
                                                //   //     //     // const Text(
                                                //   //     //     //   'Add to Favorite',
                                                //   //     //     //   style: TextStyle(
                                                //   //     //     //       color: Colors
                                                //   //     //     //           .white,
                                                //   //     //     //       fontSize: 20),
                                                //   //     //     // )
                                                //   //     //   ],
                                                //   //     // ),
                                                //   //   ],
                                                //   // ),
                                                // )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.more_vert_sharp,
                                    color: Colors.white,
                                  )));
                        },
                        separatorBuilder: (ctx, index) {
                          return const Divider();
                        },
                        itemCount: playlistsong.length);
                  },
                ),
              ],
            )),
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
