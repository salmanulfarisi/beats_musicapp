import 'package:beats/Db/favaroitedb.dart';
import 'package:beats/Pages/Screen/nowplaying.dart';
import 'package:beats/Pages/widgets/emptyscreen.dart';
import 'package:beats/Pages/widgets/getsong.dart';
import 'package:beats/utilits/globalcolors.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenFavaroit extends StatefulWidget {
  const ScreenFavaroit({Key? key}) : super(key: key);

  @override
  State<ScreenFavaroit> createState() => _ScreenFavaroitState();
}

class _ScreenFavaroitState extends State<ScreenFavaroit> {
  // final OnAudioQuery audioQuery = OnAudioQuery();
  // final AudioPlayer audioPlayer = AudioPlayer();
  static ConcatenatingAudioSource createSongList(List<SongModel> song) {
    List<AudioSource> source = [];
    for (var songs in song) {
      source.add(AudioSource.uri(Uri.parse(songs.uri!)));
    }
    return ConcatenatingAudioSource(children: source);
  }

  // playSong(String? uri) {
  //   try {
  //     audioPlayer.setAudioSource(
  //       AudioSource.uri(
  //         Uri.parse(uri!),
  //       ),
  //     );
  //     audioPlayer.play();
  //   } on Exception {
  //     log('Error parsing song');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: FavaroiteDb.favaroiteList,
      builder: (BuildContext context, List<SongModel> favaorSong, Widget? _) {
        return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  title: const Text("Favaorites",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                ),
                body: FavaroiteDb.favaroiteList.value.isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.1),
                        child: emptyScreen(context, 3, 'nothing To', 15.0,
                            'show Here', 50, 'Go and Add Something', 23.0),
                      )
                    // ? Center(
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: const [
                    //         Icon(
                    //           Icons.heart_broken,
                    //           color: white,
                    //         ),
                    //         Text(
                    //           "No Favorites Yet",
                    //           style: TextStyle(
                    //               color: white,
                    //               fontSize: 20,
                    //               fontWeight: FontWeight.bold),
                    //         )
                    //       ],
                    //     ),
                    //   )

                    : ListView(
                        children: [
                          ValueListenableBuilder(
                            valueListenable: FavaroiteDb.favaroiteList,
                            builder: (BuildContext context,
                                List<SongModel> favorSong, Widget? child) {
                              GetSong.playingSongs = favaorSong;
                              return ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: favaorSong.length,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const Divider(
                                    color: Colors.white,
                                  );
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    onTap: () {
                                      List<SongModel> newList = [...favaorSong];
                                      setState(() {});
                                      GetSong.player.setAudioSource(
                                          createSongList(newList),
                                          initialIndex: index);
                                      GetSong.player.play();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  NowPlayingScreen(
                                                    songModel: newList,
                                                  )));
                                    },
                                    leading: QueryArtworkWidget(
                                      id: favaorSong[index].id,
                                      type: ArtworkType.AUDIO,
                                      nullArtworkWidget: const Icon(
                                        Icons.music_note_outlined,
                                        color: white,
                                        size: 35,
                                      ),
                                    ),
                                    title: Text(
                                      favaorSong[index].displayNameWOExt,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      favaorSong[index].artist!,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    trailing: IconButton(
                                      icon: Lottie.asset(
                                          'assets/likebutton.json'),
                                      onPressed: () {
                                        FavaroiteDb.removeSong(
                                            favaorSong[index].id);

                                        setState(() {});
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
              ),
            ));
      },
    );
  }
}
