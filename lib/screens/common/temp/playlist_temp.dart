import 'package:flutter/material.dart';
import 'package:zing_mp3_clone/controller/player_controller.dart';
import 'package:zing_mp3_clone/models/music.dart';
import 'package:zing_mp3_clone/models/playlist.dart';
import 'package:zing_mp3_clone/providers/playlist_provider.dart';
import 'package:zing_mp3_clone/widgets/common/music_card.dart';

import '../../auth/login_screen.dart';
import '../home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  // Ảnh nền: AssetImage('assets/images/auth/welcome_background.jpg')
  // Answer thứ 2: https://stackoverflow.com/questions/54241753/background-image-for-scaffold
  Widget build(BuildContext context) {
    // //final allMusics = MusicProvider.instance.list;
    final playerController = PlayerController.instance;

    // Dữ liệu giả
    final Playlist playlist = PlaylistProvider.instance.list[0];
    final String title = playlist.title;
    final int numberOfMusic = playlist.musicIDs.length;
    final String backgroundImageUrl = playlist.getMusicAtIndex(0).thumbnailUrl;

    return Stack(
      children: <Widget>[
        Image.network(
      "https://images.unsplash.com/photo-1471180625745-944903837c22?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8bmF0dXJlfGVufDB8MnwwfHw%3D&auto=format&fit=crop&w=500&q=60",
        fit:BoxFit.cover,
           height: MediaQuery.of(context).size.height,
           width: MediaQuery.of(context).size.width,
          // fit: BoxFit.cover,
       
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.white,
                icon: const Icon(Icons.keyboard_backspace_rounded),
              ),
              titleSpacing: 0,
              title: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
                    "Trai tim anh se danh mai cho em va luon ben em tron doi" +
                        ' (' +
                        
                        ')',
                    overflow: TextOverflow.fade,
                  )
                  // elevation:0.0,
                  // toolbarHeight: 100.0,
                  ),
            ),
            body: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,

              // crossAxisAlignment: CrossAxisAlignment.start,
              //     mainAxisAlignment:MainAxisAlignment.center,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    color: Colors.yellow,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        left: 100,
                        right: 100,
                        //bottom: 600,
                      ),
                      child: ElevatedButton(
                        child: Container(
                          color: Colors.red,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              left: 30,
                              right: 30,
                              bottom: 10,
                            ),
                            child: Text(
                              "Phát ngẫu nhiên",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple,
                          shape: StadiumBorder(side: BorderSide(width: 2)),
                        ),
                      ),
                    ),
                  ),
   
        
 
                  Expanded(
                    child: FutureBuilder<List<Music>>(
                      future: playlist.getMusicList(),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                         return Center(child: CircularProgressIndicator());
                       }
                        final musicList = snapshot.data!;
                        return ListView.builder(
                          itemCount: numberOfMusic,
                          itemBuilder: (ctx, index) {
                            final music = musicList[index];
                            return MusicCard(
                              title: music.title,
                              artists: music.artists,
                              thumbnailUrl: music.thumbnailUrl,
                              onTap: () {
                                PlayerController.instance.setMusic(music);
                              },
                            );
                          },
                        );
                       },
                     ),
                  ),
                ],
              ),
            
      
              ),
            ),
      ],

    );
  }
}
