import 'package:beats/Db/favaroitedb.dart';
import 'package:beats/model/playlistmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

const playlist_Db_Name = 'playlist_db';

abstract class Playlist {
  Future<void> playlistAdd(PlayListModel model);
  Future<void> getAllPlaylist();
  Future<void> playlistRemove(int index);
  Future<void> resetApp();
}

class PlayListDB implements Playlist {
  PlayListDB._internal();
  static final PlayListDB instance = PlayListDB._internal();
  factory PlayListDB() => instance;

  ValueNotifier<List<PlayListModel>> playListnotifier = ValueNotifier([]);

  @override
  Future<void> getAllPlaylist() async {
    final playListDB = await Hive.openBox<PlayListModel>(playlist_Db_Name);
    playListnotifier.value.clear();
    playListnotifier.value.addAll(playListDB.values);
  }

  @override
  Future<void> playlistAdd(PlayListModel model) async {
    final playListDB = await Hive.openBox<PlayListModel>(playlist_Db_Name);
    playListDB.add(model);
    getAllPlaylist();
    playListnotifier.value.add(model);
  }

  @override
  Future<void> playlistRemove(int index) async {
    final playListDB = Hive.box<PlayListModel>(playlist_Db_Name);
    playListDB.deleteAt(index);
    getAllPlaylist();
  }

  @override
  Future<void> resetApp() async {
    final playListDB = Hive.box<PlayListModel>(playlist_Db_Name);
    final favarDb = Hive.box<int>('favoriteDB');
    await playListDB.clear();
    await favarDb.clear();
    FavaroiteDb.favaroiteList.value.clear();
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (context) => const ScreenSplash()),
    //     (route) => false);
  }
}
