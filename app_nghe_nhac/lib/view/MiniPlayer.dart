import 'package:app_nghe_nhac/controller/song_provider.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    _audioPlayer.onPlayerComplete.listen((event) {
      _nextSong();
    });
  }

  void _playPause() async {
    var songProvider = Provider.of<SongProvider>(context, listen: false);
    if (songProvider.songs.isEmpty) return;

    if (isPlaying) {
      await _audioPlayer.pause();
      _rotationController.stop();
    } else {
      PlayerState state = _audioPlayer.state;
      if (state == PlayerState.paused) {
        await _audioPlayer.resume();
      } else {
        await _audioPlayer.play(AssetSource(
            songProvider.songs[currentIndex]['url']!.replaceFirst('assets/', '')));
      }
      _rotationController.repeat();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void _nextSong() {
    var songProvider = Provider.of<SongProvider>(context, listen: false);
    if (songProvider.songs.isEmpty) return;

    currentIndex = (currentIndex + 1) % songProvider.songs.length;
    _playNewSong();
  }

  void _previousSong() {
    var songProvider = Provider.of<SongProvider>(context, listen: false);
    if (songProvider.songs.isEmpty) return;

    currentIndex = (currentIndex - 1 + songProvider.songs.length) % songProvider.songs.length;
    _playNewSong();
  }

  void _playNewSong() async {
    var songProvider = Provider.of<SongProvider>(context, listen: false);
    if (songProvider.songs.isEmpty) return;

    await _audioPlayer.stop();
    print('Playing: ${songProvider.songs[currentIndex]['url']}');
    await _audioPlayer.play(AssetSource(
        songProvider.songs[currentIndex]['url']!.replaceFirst('assets/', '')));
    _rotationController.repeat();
    setState(() {
      isPlaying = true;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SongProvider>(
      builder: (context, songProvider, child) {
        if (songProvider.songs.isEmpty) {
          return Container(
            color: const Color.fromARGB(255, 105, 105, 104),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Center(
              child: Text(
                "Không có bài hát",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          );
        }

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
                  songProvider.songs[currentIndex]['title']!,
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
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
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
      },
    );
  }
}
