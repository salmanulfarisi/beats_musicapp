import 'package:hive_flutter/adapters.dart';
part 'playlistmodel.g.dart';

@HiveType(typeId: 1)
class PlayListModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<int> songsId;
  PlayListModel({required this.name, required this.songsId});

  add(int id) async {
    songsId.add(id);
    save();
  }

  remove(int id) async {
    songsId.remove(id);
    save();
  }

  bool isValueInList(int id) {
    return songsId.contains(id);
  }
}
