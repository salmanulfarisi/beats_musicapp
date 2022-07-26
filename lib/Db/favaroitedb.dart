// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavaroiteDb {
  static bool isInitialized = false;
  static final playerDB = Hive.box<int>('favoriteDB');
  static ValueNotifier<List<SongModel>> favaroiteList = ValueNotifier([]);
  static initialise(List<SongModel> songs) {
    for (SongModel song in songs) {
      if (isFavor(song)) {
        favaroiteList.value.add(song);
      }
    }
    isInitialized = true;
  }

  static addSong(SongModel song) async {
    playerDB.add(song.id);
    favaroiteList.value.add(song);
    FavaroiteDb.favaroiteList.notifyListeners();
  }

  // static removeSong(SongModel song)async{
  //   playerDB.delete(song.id);
  //   favaroiteList.value.remove(song);
  //   FavaroiteDb.favaroiteList.notifyListeners();
  // }
  static removeSong(int id) async {
    int deleteIndex = 0;
    if (!playerDB.values.contains(id)) {
      return;
    }
    final Map<dynamic, int> favaroiteMap = playerDB.toMap();
    favaroiteMap.forEach((key, value) {
      if (value == id) {
        deleteIndex = key;
      }
    });
    playerDB.delete(deleteIndex);
    favaroiteList.value.removeWhere((song) => song.id == id);
    // FavaroiteDb.favaroiteList.notifyListeners();
  }

  static bool isFavor(SongModel song) {
    if (playerDB.values.contains(song.id)) {
      return true;
    }
    return false;
  }
}
