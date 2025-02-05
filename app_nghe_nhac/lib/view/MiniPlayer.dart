import 'package:app_nghe_nhac/controller/list_songs.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';
import 'package:flutter/services.dart';


class MiniPlayer extends StatefulWidget {
  @override
  _MiniPlayerState createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer>
    with SingleTickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  int currentIndex = 0;
  late AnimationController _rotationController;

  static List<Map<String, String>> songs = [];

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    _audioPlayer.onPlayerComplete.listen((event) {
      _nextSong(); // Tự động chuyển sang bài tiếp theo
    });
    _loadSongList();
    
  }

  void _loadSongList() async {
  List<Map<String, String>> loadedSongs = await ListSongs.loadSongs();
  setState(() {
    songs = loadedSongs;
  });
}

  @override
  void dispose() {
    _audioPlayer.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  void _playPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
      _rotationController.stop();
    } else {
      PlayerState state = _audioPlayer.state;
      if (state == PlayerState.paused) {
        await _audioPlayer.resume(); // Tiếp tục phát từ vị trí tạm dừng
      } else {
        await _audioPlayer.play(AssetSource(songs[currentIndex]['url']!.replaceFirst('assets/', '')));
      }
      _rotationController.repeat();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void _nextSong() {
    if (currentIndex < songs.length - 1) {
      currentIndex++;
    } else {
      currentIndex = 0;
    }
    _playNewSong();
  }

  void _previousSong() {
    if (currentIndex > 0) {
      currentIndex--;
    } else {
      currentIndex = songs.length - 1;
    }
    _playNewSong();
  }

  void _playNewSong() async {
    await _audioPlayer.stop();
    print('Playing: ${songs[currentIndex]['url']}');
    await _audioPlayer.play(AssetSource(songs[currentIndex]['url']!.replaceFirst('assets/', '')));
    _rotationController.repeat();
    setState(() {
      isPlaying = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 105, 105, 104),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        children: [
          // Icon album xoay tròn
          AnimatedBuilder(
            animation: _rotationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationController.value * 2 * pi,
                child: child,
              );
            },
            child: ClipOval(
              child: Image.asset(
                'assets/image/disc.jpg',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          // Tên bài hát
          Expanded(
            child: Text(
              songs.isNotEmpty ? songs[currentIndex]['title']! : "Không có bài hát",
              style: TextStyle(color: Colors.white, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Nút điều khiển
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.skip_previous, color: Colors.white),
                onPressed: _previousSong,
              ),
              IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white),
                onPressed: _playPause,
              ),
              IconButton(
                icon: Icon(Icons.skip_next, color: Colors.white),
                onPressed: _nextSong,
              ),
            ],
          ),
        ],
      ),
    );
  }
}


