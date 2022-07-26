import 'package:beats/Db/playlistdb.dart';
import 'package:beats/Pages/Screen/playlistfolder.dart';
import 'package:beats/Pages/widgets/emptyscreen.dart';
import 'package:beats/model/playlistmodel.dart';
import 'package:beats/utilits/globalcolors.dart';
import 'package:beats/widgets/iconwidgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenPlaylist extends StatefulWidget {
  const ScreenPlaylist({Key? key}) : super(key: key);

  @override
  State<ScreenPlaylist> createState() => _ScreenPlaylistState();
}

final _formKey = GlobalKey<FormState>();
final _newPlaylistController = TextEditingController();
final playlistBox = Hive.box<PlayListModel>('Playlist_db').listenable();
List<PlaylistModel> playlistDetails = [];
late List<SongModel> playlistSong;

class _ScreenPlaylistState extends State<ScreenPlaylist> {
  @override
  Widget build(BuildContext context) {
    if (playlistDetails.isEmpty) {
      playlistDetails = playlistDetails;
    }
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
          backgroundColor: transparent,
          elevation: 0,
          title: const Text(
            'Playlist',
            style: TextStyle(color: white),
          ),
        ),
        body: ListView(
          children: [
            InkWell(
              onTap: () {
                // Fluttertoast.showToast(msg: "Ready to Create Playlist");
                newPlaylistDialog(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: white, width: 1.0, style: BorderStyle.solid),
                  ),
                  child: Row(
                    children: const [
                      Flexible(
                          child: Icon(
                        Icons.add,
                        color: Colors.deepOrange,
                        size: 30,
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          child: Text(
                        'Create Playlist',
                        style: TextStyle(
                            color: white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                    ],
                  ),
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: playlistBox,
              builder: (BuildContext context, Box<PlayListModel> playlist,
                  Widget? child) {
                return playlist.values.isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 4),
                        child: emptyScreen(context, 3, 'nothing To', 15.0,
                            'show Here', 50, 'Go and Add Something', 23.0),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: playlist.length,
                        itemBuilder: (BuildContext context, int index) {
                          final data = playlist.values.toList()[index];
                          return Card(
                            shadowColor: Colors.white,
                            elevation: 5,
                            color: Colors.grey[900],
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PlaylistFolder(
                                          folderindex: index,
                                          playlistModel: data,
                                          // playlistSong: playlistSong,
                                        )));
                              },
                              leading: const Icon(Icons.folder,
                                  color: Colors.deepOrange),
                              title: Text(
                                data.name,
                                style: const TextStyle(
                                    color: white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              // subtitle: Text(PlayListModel.} songs',
                              //     style: const TextStyle(
                              //         color: white,
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.bold)),
                              trailing: IconButton(
                                  onPressed: () {
                                    showDeleteDialog(context, index);
                                  },
                                  icon: const IconWidget(
                                      color: Colors.redAccent,
                                      icon: Icons.delete)),
                            ),
                          );
                          // return InkWell(
                          //   onTap: () {
                          //     Navigator.pushNamed(context, '/playlist',
                          //         arguments: playlist[index]);
                          //   },
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(16.0),
                          //     child: Container(
                          //       padding: const EdgeInsets.symmetric(
                          //           vertical: 16.0, horizontal: 8.0),
                          //       decoration: BoxDecoration(
                          //         border: Border.all(
                          //             color: white, width: 1.0, style: BorderStyle.solid),
                          //       ),
                          //       child: Row(
                          //         children: const [
                          //           Flexible(
                          //               child: Icon(
                          //             Icons.playlist_play,
                          //             color: Colors.deepOrange,
                          //             size: 30,
                          //           )),
                          //           Flexible(
                          //               child: Text(
                          //             'Playlist',
                          //             style: TextStyle(
                          //                 color: white,
                          //                 fontSize: 18,
                          //                 fontWeight: FontWeight.bold),
                          //           )),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // );
                        },
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  void newPlaylistDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('New Playlist'),
            content: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _newPlaylistController,
                  decoration: const InputDecoration(
                    labelText: 'Playlist Name',
                    labelStyle: TextStyle(color: black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: black),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter playlist name';
                    } else if (value.trim().isEmpty) {
                      return 'Please enter playlist name';
                    }
                    return null;
                  },
                ),
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Create'),
                onPressed: () {
                  createButton();
                  // if (_formKey.currentState!.validate()) {
                  //   _playlistBox.put(_newPlaylistController.text,
                  //       _newPlaylistController.text);
                  //   _newPlaylistController.clear();
                  //   Navigator.of(context).pop();
                  // }
                },
              ),
            ],
          );
        });
  }

  Future<void> createButton() async {
    final playlistName = _newPlaylistController.text.trim();
    if (playlistName.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter playlist name');
      return;
    } else {
      final listPlaylist = PlayListModel(name: playlistName, songsId: []);
      PlayListDB.instance.playlistAdd(listPlaylist);
      PlayListDB.instance.getAllPlaylist();
      _newPlaylistController.clear();
      Navigator.of(context).pop();
    }
  }

  void showDeleteDialog(BuildContext context, index) {
    showDialog(
        context: context,
        builder: (
          context,
        ) {
          return AlertDialog(
            title: const Text('Delete Playlist'),
            content:
                const Text('Are you sure you want to delete this playlist?'),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Delete'),
                onPressed: () {
                  PlayListDB.instance.playlistRemove(index);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
