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

          Text(
            currentSong['title'] ?? 'Không có tiêu đề',
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            "Không xác định",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          SizedBox(height: 20),

          
          Slider(
            value: 5, 
            min: 0,
            max: 150,
            onChanged: (value) {},
          ),

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
