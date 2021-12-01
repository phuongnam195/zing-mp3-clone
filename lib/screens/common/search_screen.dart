import 'package:flutter/material.dart';

import '../../data/recent_searchs.dart';
import '../../models/music.dart';
import '../../widgets/search/search_box.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/home/search';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recentSearchs = RecentSearchs.instance;

    // TODO: Hiện danh sách này lên body
    // Danh sách các bài hát tìm kiếm gần đây
    final List<Music> recentList = recentSearchs.list;

    // Sau khi nhập từ khóa và ấn Enter thì danh sách kết quả
    // hiện ra, đẩy danh sách tìm kiếm gần đây xuống dưới
    // Hàm lấy danh sách bài hát từ keyword nhập vào: AllMusic.instance.search(keyword)

    // Sử dụng widget MusicCard để thể hiện một bài hát (cả gần đây và kết quả): xem file widgets/common/music_card.dart

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.black,
          icon: const Icon(Icons.keyboard_backspace_rounded),
        ),
        titleSpacing: 0,
        title: const Padding(
          padding: EdgeInsets.only(right: 20),
          child: SearchBox(
            autofocus: true,
          ),
        ),
      ),
    );
  }
}
