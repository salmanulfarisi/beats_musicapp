import 'package:beats/Db/favaroitedb.dart';
import 'package:beats/Pages/Screen/mini_player.dart';
import 'package:beats/Pages/favaroties.dart';
import 'package:beats/Pages/playlists.dart';
import 'package:beats/Pages/homescreen.dart';
import 'package:beats/Pages/screensearch.dart';
import 'package:beats/Pages/widgets/getsong.dart';
import 'package:beats/utilits/globalcolors.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rate_my_app/rate_my_app.dart';

class ScreenNavigatioin extends StatefulWidget {
  final RateMyApp rateMyApp;
  const ScreenNavigatioin({Key? key, required this.rateMyApp})
      : super(key: key);

  @override
  State<ScreenNavigatioin> createState() => _ScreenNavigatioinState();
}

class _ScreenNavigatioinState extends State<ScreenNavigatioin> {
  int currentinde = 0;
  final inactiveColor = white;
  final activeColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(
        rateMyApp: widget.rateMyApp,
      ),
      const SearchScreen(),
      const ScreenFavaroit(),
      const ScreenPlaylist(),
    ];
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: currentinde,
        children: screens,
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: FavaroiteDb.favaroiteList,
        builder: (BuildContext context, List<SongModel> value, Widget? child) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (GetSong.player.currentIndex != null)
                  const MiniPlayer()
                else
                  const SizedBox(),

                buildBottomNavigation(),
                // if(GetSong.player.currentIndex != null){
                //   const MiniPlayer(),
                // }else{
                //   const SizedBox(),

                // }
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget buildBody() {
  //   switch (index) {
  //     case 1:
  //       return const SearchScreen();
  //     case 2:
  //       return const ScreenFavaroit();
  //     case 3:
  //       return const ScreenPlaylist();
  //     case 0:
  //     default:
  //       return HomeScreen(
  //         rateMyApp: widget.rateMyApp,
  //       );
  //   }
  // }

  Widget buildBottomNavigation() {
    return BottomNavyBar(
      backgroundColor: black,
      showElevation: false,
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            icon: const Icon(Icons.apps),
            title: const Text(
              'Home',
              textAlign: TextAlign.center,
            )),
        BottomNavyBarItem(
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            icon: const Icon(Icons.search),
            title: const Text(
              'Search',
              textAlign: TextAlign.center,
            )),
        BottomNavyBarItem(
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            icon: const Icon(Icons.favorite),
            title: const Text(
              'Favorites',
              textAlign: TextAlign.center,
            )),
        BottomNavyBarItem(
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            icon: const Icon(Icons.playlist_add),
            title: const Text(
              'Playlist',
              textAlign: TextAlign.center,
            )),
      ],
      onItemSelected: (index) => setState(() {
        currentinde = index;
        FavaroiteDb.favaroiteList.notifyListeners();
      }),
      selectedIndex: currentinde,
    );
  }
}
