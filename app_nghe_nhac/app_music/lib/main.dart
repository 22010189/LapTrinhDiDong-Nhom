import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyMusicApp());
}

class MyMusicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicPlayer(),
    );
  }
}

class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<String> _songs = [
    'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
  ];
  final List<String> _songNames = [
    'Song 1 - Relaxing',
    'Song 2 - Chill Vibes',
    'Song 3 - Acoustic',
  ];
  int _currentSongIndex = 0;
  bool _isPlaying = false;

  void _playPauseMusic() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      await _audioPlayer.play(_songs[_currentSongIndex]);
      setState(() {
        _isPlaying = true;
      });
    }
  }

  void _playNextSong() async {
    _currentSongIndex = (_currentSongIndex + 1) % _songs.length;
    await _audioPlayer.play(_songs[_currentSongIndex]);
    setState(() {
      _isPlaying = true;
    });
  }

  void _playPreviousSong() async {
    _currentSongIndex = (_currentSongIndex - 1 + _songs.length) % _songs.length;
    await _audioPlayer.play(_songs[_currentSongIndex]);
    setState(() {
      _isPlaying = true;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Music Player'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Hiển thị tên bài hát hiện tại
          Text(
            _songNames[_currentSongIndex],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          // Các nút điều khiển
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _playPreviousSong,
                child: Icon(Icons.skip_previous),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _playPauseMusic,
                child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _playNextSong,
                child: Icon(Icons.skip_next),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Danh sách bài hát
          Expanded(
            child: ListView.builder(
              itemCount: _songNames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.music_note),
                  title: Text(_songNames[index]),
                  onTap: () async {
                    setState(() {
                      _currentSongIndex = index;
                    });
                    await _audioPlayer.play(_songs[_currentSongIndex]);
                    setState(() {
                      _isPlaying = true;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
