import 'package:app_nghe_nhac/controller/song_provider.dart';
import 'package:app_nghe_nhac/view/AlbumScreen.dart';
import 'package:app_nghe_nhac/view/ArtistScreen.dart';
import 'package:app_nghe_nhac/view/MiniPlayer.dart';
import 'package:app_nghe_nhac/view/BaiHat.dart';
import 'package:app_nghe_nhac/view/ThuVien.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
 runApp(
    ChangeNotifierProvider(
      create: (context) => SongProvider(),
      child: MyApp(),
    ),
  );
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
    BaiHat(),     // Bài hát
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,     // Hiển thị giao diện tương ứng trong list screens
        children: screens,
      ),  
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


