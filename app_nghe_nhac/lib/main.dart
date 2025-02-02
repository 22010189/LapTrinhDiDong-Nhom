import 'package:app_nghe_nhac/view/AlbumScreen.dart';
import 'package:app_nghe_nhac/view/ArtistScreen.dart';
import 'package:app_nghe_nhac/view/MiniPlayer.dart';
import 'package:app_nghe_nhac/view/SongScreen.dart';
import 'package:app_nghe_nhac/view/ThuVien.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppMusic(),
    );
  }
}

class AppMusic extends StatefulWidget {
  @override
  AppMusicState createState() => AppMusicState();
}

class AppMusicState extends State<AppMusic> {
  int currentIndex = 0; // Chỉ mục của tab hiện tại

  // Danh sách các giao diện cho từng tab
  final List<Widget> screens = [
    ThuVien(), // Thư viện (Mặc định)
    ArtistScreen(),   // Nghệ sĩ
    AlbumScreen(),    // Album
    SongScreen(),     // Bài hát
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex], // Hiển thị giao diện tương ứng
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MiniPlayer(),
          BottomNavigationBar(
            currentIndex: currentIndex,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.purple,
            unselectedItemColor: Colors.black,
            onTap: (index) {
              setState(() {
                currentIndex = index; // Cập nhật giao diện
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_music), label: 'Thư viện'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Nghệ sĩ'),
              BottomNavigationBarItem(icon: Icon(Icons.album), label: 'Album'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.audio_file), label: 'Bài hát'),
            ],
          ),
        ],
      ),
    );
  }
}


