// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:beats/Pages/Screen/nowplaying.dart';
import 'package:beats/Pages/homescreen.dart';
import 'package:beats/Pages/widgets/emptyscreen.dart';
import 'package:beats/Pages/widgets/favbutton.dart';
import 'package:beats/Pages/widgets/getsong.dart';
import 'package:beats/utilits/globalcolors.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<SongModel>> temp = ValueNotifier([]);

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [black, black.withOpacity(0.9)],
            stops: const [0.5, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        appBar: AppBar(
          toolbarHeight: 90,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: TextField(
              style: const TextStyle(color: white),
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: white),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  filled: true,
                  fillColor: Colors.transparent,
                  hintStyle: TextStyle(color: white),
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search, color: white)),
              onChanged: (String? value) {
                if (value != null && value.isNotEmpty) {
                  temp.value.clear();
                  for (SongModel item in HomeScreen.songs) {
                    if (item.title
                        .toLowerCase()
                        .contains(value.toLowerCase())) {
                      temp.value.add(item);
                    }
                  }
                }
                temp.notifyListeners();
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                temp.value.isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3.5),
                        child: emptyScreen(context, 3, 'Hey,Dude', 15.0,
                            'No Songs', 50.0, 'Founds Here', 23.0),
                      )
                    : ValueListenableBuilder(
                        valueListenable: temp,
                        builder: (BuildContext context,
                            List<SongModel> songData, Widget? child) {
                          return ListView.separated(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                final data = songData[index];
                                return Card(
                                  color: Colors.white10,
                                  // Colors.accents[index % Colors.accents.length],
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: ListTile(
                                      leading: QueryArtworkWidget(
                                          nullArtworkWidget: const Icon(
                                              Icons.music_note,
                                              color: Colors.white),
                                          artworkFit: BoxFit.cover,
                                          id: data.id,
                                          type: ArtworkType.AUDIO),
                                      title: Text(
                                        data.displayNameWOExt,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing:
                                          FavButton(song: songData[index]),
                                      onTap: () {
                                        final searchIndex =
                                            creatSearchIndex(data);
                                        FocusScope.of(context).unfocus();
                                        GetSong.player.setAudioSource(
                                            GetSong.createSongList(
                                                HomeScreen.songs),
                                            initialIndex: searchIndex);
                                        GetSong.player.play();
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (ctx) => NowPlayingScreen(
                                              playersong: HomeScreen.songs,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (ctx, index) {
                                return const SizedBox();
                              },
                              itemCount: temp.value.length);
                        }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int? creatSearchIndex(SongModel data) {
    for (int i = 0; i < HomeScreen.songs.length; i++) {
      if (data.id == HomeScreen.songs[i].id) {
        return i;
      }
    }
    return null;
  }
}
