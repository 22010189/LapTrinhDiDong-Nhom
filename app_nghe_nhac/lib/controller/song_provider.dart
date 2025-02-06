import 'package:flutter/material.dart';
import 'list_songs.dart';
// quản lý danh sách bài hát đã tải từ ListSongs
class SongProvider with ChangeNotifier {
  List<Map<String, String>> songs = [];

  Future<void> loadSongs() async {
    if (songs.isEmpty) {
      songs = await ListSongs.loadSongs();
      notifyListeners();
    }
  }
}
