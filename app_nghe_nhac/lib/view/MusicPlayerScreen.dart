import 'package:app_nghe_nhac/controller/song_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 


class MusicPlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var songProvider = Provider.of<SongProvider>(context);
    var currentSong = songProvider.songs[songProvider.currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          currentSong['title'] ?? 'Không có tiêu đề',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ảnh bài hát (có thể dùng NetworkImage nếu có URL ảnh)
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(Icons.music_note, color: Colors.white, size: 100),
          ),
          SizedBox(height: 20),

          // Tiêu đề bài hát
          Text(
            currentSong['title'] ?? 'Không có tiêu đề',
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            "Không xác định",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          SizedBox(height: 20),

          // Thanh thời gian
          Slider(
            value: 5, // Giá trị tạm thời, cần cập nhật theo trạng thái bài hát
            min: 0,
            max: 150,
            onChanged: (value) {},
          ),

          // Điều khiển nhạc
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.skip_previous, color: Colors.white, size: 40),
                onPressed: () {
                  songProvider.previousSong();
                },
              ),
              IconButton(
                icon: Icon(
                  songProvider.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                  color: Colors.white,
                  size: 60,
                ),
                onPressed: () {
                  songProvider.playPause();
                },
              ),
              IconButton(
                icon: Icon(Icons.skip_next, color: Colors.white, size: 40),
                onPressed: () {
                  songProvider.nextSong();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
