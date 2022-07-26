// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:beats/Db/favaroitedb.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavButton extends StatefulWidget {
  final SongModel song;
  const FavButton({
    Key? key,
    required this.song,
  }) : super(key: key);

  @override
  State<FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: FavaroiteDb.favaroiteList,
      builder: (BuildContext context, List<SongModel> favorSong, Widget? _) {
        return IconButton(
          onPressed: () {
            if (FavaroiteDb.isFavor(widget.song)) {
              FavaroiteDb.removeSong(widget.song.id);
              FavaroiteDb.favaroiteList.notifyListeners();
              // } else {
              //   FavaroiteDb.addSong(widget.song);
              const snackBar = SnackBar(
                content: Text('Removed from Favorites'),
                duration: Duration(seconds: 1),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              FavaroiteDb.addSong(widget.song);
              FavaroiteDb.favaroiteList.notifyListeners();
              const snackBar = SnackBar(
                content: Text('Added to Favorites'),
                duration: Duration(seconds: 1),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            FavaroiteDb.favaroiteList.notifyListeners();
          },
          icon: FavaroiteDb.isFavor(widget.song)
              ? Lottie.asset('assets/likebutton.json')
              // ? const Icon(
              //     Icons.favorite,
              //     color: Colors.redAccent,
              //   )
              : const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
        );
      },
    );
  }
}
