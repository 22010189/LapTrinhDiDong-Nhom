import 'package:app_nghe_nhac/controller/navigation_controller.dart';
import 'package:app_nghe_nhac/controller/song_provider.dart';
import 'package:app_nghe_nhac/view/widgetsForBaiHat/Songs.dart';
import 'package:app_nghe_nhac/view/widgetsForThuVien/more_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongScreen extends StatefulWidget {
  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>      //tránh lỗi Provider.of() bị gọi quá sớm
        Provider.of<SongProvider>(context, listen: false).loadSongs());
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
      body: Consumer<SongProvider>(     // cập nhật UI khi thay đổi dữ liệu
        builder: (context, songProvider, child) {
          if (songProvider.songs.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: songProvider.songs.length,
            itemBuilder: (context, index) {
              return Songs(
                title: songProvider.songs[index]['title']!,
                ngheSi: "Không xác định - Download",
                onMorePressed: () {
                  print("Nhấn vào nút more");
                },
                onTap: () =>
                    NavigationController.navigateTo(context, Placeholder()),
              );
            },
          );
        },
      ),
    );
  }
}
