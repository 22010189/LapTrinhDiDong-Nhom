import 'package:app_nghe_nhac/controller/navigation_controller.dart';
import 'package:app_nghe_nhac/view/widgetsForBaiHat/Songs.dart';
import 'package:app_nghe_nhac/view/widgetsForThuVien/more_options.dart';
import 'package:flutter/material.dart';
import 'package:app_nghe_nhac/controller/list_songs.dart';

class SongScreen extends StatefulWidget {
  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  static List<Map<String, String>> songs = [];

  @override
  void initState() {
    super.initState();
    _loadSongs();
  }

  void _loadSongs() async {
    List<Map<String, String>> loadedSongs = await ListSongs.loadSongs();
    setState(() {
      songs = loadedSongs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 6, 79, 79),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 86, 84, 81),
        elevation: 0,
        title: Text(
          'Bài hát',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () => showMoreOptions(context),
          ),
        ],
      ),
      body: songs.isEmpty
          ? Center(child: CircularProgressIndicator()) 
          : ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                return Songs(
                  title: songs[index]['title']!,
                  ngheSi: "Không xác định - Download",
                  onMorePressed: () {
                    print("Nhấn vào nút more");
                  },
                  onTap: () => NavigationController.navigateTo(context, Placeholder()),
                );
              },
            ),
    );
  }
}
