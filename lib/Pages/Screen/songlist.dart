import 'package:beats/model/playlistmodel.dart';
import 'package:beats/utilits/globalcolors.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongsListPage extends StatefulWidget {
  const SongsListPage({Key? key, required this.playlist}) : super(key: key);

  final PlayListModel playlist;

  @override
  State<SongsListPage> createState() => _SongsListPageState();
}

class _SongsListPageState extends State<SongsListPage> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
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
          title: Text(
            'Add Songs to ${widget.playlist.name}',
            style: const TextStyle(color: white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder<List<SongModel>>(
                    future: audioQuery.querySongs(
                        sortType: SongSortType.DATE_ADDED,
                        orderType: OrderType.DESC_OR_GREATER,
                        uriType: UriType.EXTERNAL,
                        ignoreCase: true),
                    builder: (context, item) {
                      if (item.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (item.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            'NO Songs Found',
                            style: TextStyle(
                              color: white,
                            ),
                          ),
                        );
                      }
                      return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (ctx, index) {
                            return ListTile(
                              onTap: () {},
                              iconColor: white,
                              textColor: white,
                              leading: QueryArtworkWidget(
                                id: item.data![index].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget:
                                    const Icon(Icons.music_note_outlined),
                                artworkFit: BoxFit.fill,
                                artworkBorder:
                                    const BorderRadius.all(Radius.circular(30)),
                              ),
                              title: Text(item.data![index].displayNameWOExt),
                              subtitle: Text("${item.data![index].artist}"),
                              trailing: IconButton(
                                  onPressed: () {
                                    playlistCheck(item.data![index]);
                                    //     playlistnotifier.notifyListeners();
                                  },
                                  icon: const Icon(Icons.add)),
                            );
                          },
                          separatorBuilder: (ctx, index) {
                            return const Divider();
                          },
                          itemCount: item.data!.length);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void playlistCheck(SongModel data) {
    if (!widget.playlist.isValueInList(data.id)) {
      widget.playlist.add(data.id);
      const snackbar = SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            'Added to Playlist',
            style: TextStyle(color: Colors.white),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      const snackbar = SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            'Already in Playlist',
            style: TextStyle(color: Colors.white),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
