import 'dart:developer';

import 'package:beats/Db/favaroitedb.dart';
import 'package:beats/Db/playlistdb.dart';
import 'package:beats/Pages/Screen/nowplaying.dart';
import 'package:beats/Pages/widgets/getsong.dart';
import 'package:beats/Pages/widgets/favbutton.dart';
import 'package:beats/splash.dart';
import 'package:beats/utilits/globalcolors.dart';
import 'package:beats/widgets/ratedialoge.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  final RateMyApp rateMyApp;
  const HomeScreen({
    Key? key,
    required this.rateMyApp,
  }) : super(key: key);
  static List<SongModel> songs = [];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    requestPermission();
    super.initState();
  }

  void requestPermission() async {
    await Permission.storage.request();
    setState(() {});
  }

  final _audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? appVersion;
  String? appPublisher = 'Salman';
  String? appName;

  // final RateMyApp rateMyApp = RateMyApp();

  @override
  Widget build(BuildContext context) {
    // FocusManager.instance.primaryFocus?.unfocus();
    PackageInfo.fromPlatform().then((info) {
      appVersion = info.version;

      appName = info.appName;
    });
    // FavaroiteDb.favaroiteList.notifyListeners();
    // setState(() {});
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.black,
        Colors.black.withOpacity(0.9),
      ])),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Scaffold(
          drawer: Drawer(
            child: Container(
              color: Colors.grey[900],
              child: CustomScrollView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    backgroundColor: transparent,
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    stretch: true,
                    expandedHeight: MediaQuery.of(context).size.height * 0.2,
                    flexibleSpace: FlexibleSpaceBar(
                      title: RichText(
                        text: TextSpan(
                          text: 'Beats',
                          style: const TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber),
                          children: <TextSpan>[
                            TextSpan(
                              text: appVersion == null ? '' : '\nv$appVersion',
                              style: const TextStyle(
                                  fontSize: 7.0,
                                  fontWeight: FontWeight.bold,
                                  color: white),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.end,
                      ),
                      titlePadding: const EdgeInsets.only(bottom: 40),
                      centerTitle: true,
                      background: ShaderMask(
                        shaderCallback: (rect) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              black.withOpacity(0.8),
                              black.withOpacity(0.1),
                            ],
                          ).createShader(
                              Rect.fromLTRB(0, 0, rect.width, rect.height));
                        },
                        blendMode: BlendMode.dstIn,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        ListTile(
                          title: const Text('Home'),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20.0),
                          leading: const Icon(Icons.home_rounded),
                          selected: true,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text('About App',
                              style: TextStyle(
                                color: white,
                              )),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20.0),
                          leading: const Icon(Icons.info_rounded, color: white),
                          onTap: () {
                            showAboutDialog(
                                context: context,
                                applicationName: 'Beats',
                                applicationVersion: appVersion,
                                applicationIcon: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/likebutton.json'),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: BoxShape.circle,
                                    )),
                                applicationLegalese:
                                    '© 2020-2021 All rights reserved.',
                                children: [
                                  const Text(' Beats is a music player app '
                                      'that plays music from your device.'),
                                  Text(
                                    'This app is made with ❤️ by '
                                    '${appPublisher ?? 'Salman'}',
                                  ),
                                ]);
                          },
                        ),
                        ListTile(
                          title: const Text('Share App',
                              style: TextStyle(
                                color: white,
                              )),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20.0),
                          leading:
                              const Icon(Icons.share_rounded, color: white),
                          onTap: () {
                            Share.share(
                                'https://play.google.com/store/apps/details?id=com.beats.beats');
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text('Feedback',
                              style: TextStyle(
                                color: white,
                              )),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20.0),
                          leading:
                              const Icon(Icons.feedback_rounded, color: white),
                          onTap: () {
                            mailToMe();
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text('Reset App',
                              style: TextStyle(
                                color: white,
                              )),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20.0),
                          leading:
                              const Icon(Icons.restore_rounded, color: white),
                          onTap: () {
                            showReset(context);
                          },
                        ),
                        RateDialogePage(
                          rateMyApp: widget.rateMyApp,
                        ),
                        ListTile(
                          title: const Text('About Developer',
                              style: TextStyle(
                                color: white,
                              )),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20.0),
                          leading: const Icon(Icons.person, color: white),
                          onTap: () {
                            aboutMe();
                          },
                        ),
                      ],
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: const <Widget>[
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 30, 5, 20),
                          child: Center(
                            child: Text(
                              '.madeBy',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: transparent,
          appBar: AppBar(
            // leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
            elevation: 0,
            backgroundColor: transparent,
            title: const Text(
              'Beats',
              style: TextStyle(
                  color: white, fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          body: FutureBuilder<List<SongModel>>(
            future: _audioQuery.querySongs(
              sortType: SongSortType.DATE_ADDED,
              orderType: OrderType.DESC_OR_GREATER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true,
            ),
            builder: (context, items) {
              if (items.data == null) {
                return const Center(child: CircularProgressIndicator());
              }
              if (items.data!.isEmpty) {
                return const Center(child: Text('No songs found'));
              }
              HomeScreen.songs = items.data!;
              if (!FavaroiteDb.isInitialized) {
                FavaroiteDb.initialise(items.data!);
              }
              GetSong.songscopy = items.data!;

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: transparent),
                        borderRadius: BorderRadius.circular(10)),
                    child: Card(
                      color: transparent,
                      child: InkWell(
                        onTap: () {
                          GetSong.player.setAudioSource(
                              GetSong.createSongList(items.data!),
                              initialIndex: index);
                          GetSong.player.play();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NowPlayingScreen(
                                playersong: items.data!,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                color: transparent,
                                child: QueryArtworkWidget(
                                    artworkHeight: double.infinity,
                                    artworkBorder: BorderRadius.circular(5),
                                    artworkWidth: double.infinity,
                                    artworkFit: BoxFit.fitWidth,
                                    nullArtworkWidget: const Icon(
                                      Icons.music_note,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                    id: items.data![index].id,
                                    type: ArtworkType.AUDIO),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: transparent,
                                  border: Border.all(color: transparent),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              items.data![index]
                                                  .displayNameWOExt,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "${items.data![index].artist}",
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  FavButton(
                                    song: HomeScreen.songs[index],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: items.data!.length,
              );
              // return ListView.builder(
              //   itemCount: items.data!.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     return Card(
              //       color: Colors.grey[500],
              //       child: ListTile(
              //         leading: QueryArtworkWidget(
              //             nullArtworkWidget: const IconWidget(
              //               color: Colors.indigoAccent,
              //               icon: Icons.music_note,
              //               size: 35,
              //             ),
              //             id: items.data![index].id,
              //             type: ArtworkType.AUDIO),
              //         title: Text(items.data![index].displayNameWOExt),
              //         subtitle: Text("${items.data![index].artist}"),
              //         trailing: IconButton(
              //           icon: const Icon(Icons.favorite),
              //           onPressed: () {
              //             FavaroiteDb.addSong(items.data![index]);
              //           },
              //         ),
              //         onTap: () {
              //           Navigator.of(context).push(MaterialPageRoute(
              //               builder: (context) => NowPlayingScreen(
              //                   songModel: items.data!,
              //                   audioPlayer: _audioPlayer,
              //                   index: index)));
              //         },
              //       ),
              //     );
              //   },
              // );
            },
          ),
        ),
      ),
    );
  }

  playSong(String? uri) {
    try {
      _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      _audioPlayer.play();
    } on Exception {
      log('Error playing song');
    }
  }

  showReset(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Reset App'),
            content: const Text('Are you sure you want to reset the app?'),
            actions: [
              ElevatedButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: const Text('Reset'),
                onPressed: () async {
                  PlayListDB.instance.resetApp();
                  GetSong.player.stop();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => ScreenSplash(
                                rateMyApp: widget.rateMyApp,
                              )),
                      (route) => false);
                },
              ),
            ],
          );
        });
  }

  Future<void> mailToMe() async {
    String urls =
        'mailto:salmanfarisi0027@gmail.com?subject=${Uri.encodeComponent('Feedback for Beats Music Player')}&body=${Uri.encodeComponent('Hi,\n\n')}';
    final parseurl = Uri.parse(urls);
    try {
      if (!await launchUrl(parseurl)) {
        throw 'could not launch';
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> aboutMe() async {
    String urls = 'https://salmanulfarisi.github.io/portfolio/';
    final parseurl = Uri.parse(urls);
    try {
      if (!await launchUrl(parseurl)) {
        throw 'could not launch';
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
