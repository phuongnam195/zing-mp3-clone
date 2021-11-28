import 'package:flutter/material.dart';
import 'package:zing_mp3_clone/widgets/search/search_box.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/home/search';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
