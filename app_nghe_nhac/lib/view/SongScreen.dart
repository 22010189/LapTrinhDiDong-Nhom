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
      body: Consumer<SongProvider>(
        builder: (context, songProvider, child) {
          if (songProvider.songs.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        if (songProvider.songs.isNotEmpty) {
                           Provider.of<SongProvider>(context, listen: false).playFromIndex(0);
                        }
                      },
                      child: Row(
                        children: [
                          Icon(Icons.play_arrow, color: Colors.white, size: 28),
                          SizedBox(width: 8),
                          Text(
                            'Phát tất cả',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${songProvider.songs.length} bài hát',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: songProvider.songs.length,
                  itemBuilder: (context, index) {
                    return Songs(
                      title: songProvider.songs[index]['title']!,
                      ngheSi: "Không xác định - Download",
                      onMorePressed: () {
                        print("Nhấn vào nút more");
                      },
                      onTap: () {
                        Provider.of<SongProvider>(context, listen: false).playFromIndex(index); 
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
