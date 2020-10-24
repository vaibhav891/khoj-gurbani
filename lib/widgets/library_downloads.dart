import 'dart:io';
import 'package:flutter/material.dart';
import 'package:khojgurbani_music/models/Downloads.dart';
import 'package:khojgurbani_music/screens/podcast_on_three_dots.dart';
import 'package:khojgurbani_music/screens/three_dots_on_song.dart';
import 'package:khojgurbani_music/services/Database.dart';
import 'dart:async';

class UserDownloaded {
  final int id;
  final int shabadId;
  final String title;
  final String author;
  final String type;
  final String duration;
  final String attachmentName;
  final String image;
  final int is_media;
  final int page;
  final int author_id;

  UserDownloaded(this.id, this.shabadId, this.title, this.author, this.type, this.duration, this.attachmentName,
      this.image, this.is_media, this.page, this.author_id);
}

class LibraryDownloads extends StatefulWidget {
  final Function showOverlay;
  final Function showOverlayTrue;
  final Function showOverlayFalse;
  bool show;
  final Function play;
  final Function setListLinks;
  final Function setPropertiesForFullScreen;
  final currentSong;

  LibraryDownloads(
      {Key key,
      this.showOverlay,
      this.showOverlayTrue,
      this.showOverlayFalse,
      this.show,
      this.play,
      this.setListLinks,
      this.setPropertiesForFullScreen,
      this.currentSong})
      : super(key: key);
  @override
  _LibraryDownloadsState createState() => _LibraryDownloadsState();
}

class _LibraryDownloadsState extends State<LibraryDownloads> {
  // List shuffleList = [];
  // List<UserDownloaded> favMedias = [];
  // List favMediasP = [];
  // Future<List<UserDownloaded>> _getUserDownloads() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final userId = prefs.getInt('user_id');
  //   final token = prefs.getString('token');
  //   final machineId = prefs.getString('machine_id');

  //   // final headers = {'Authorization': "Bearer " + token};
  //   final response = await http.get(
  //     'https://api.khojgurbani.org/api/v1/android/user-download-list?user_id=$userId&machine_id=$machineId',
  //     //  headers: headers
  //   );
  //   var jsonData = json.decode(response.body)['media_downloaded'];
  //   favMedias = [];
  //   favMediasP = [];
  //   for (var a in jsonData) {
  //     UserDownloaded favMedia = UserDownloaded(
  //         a["id"],
  //         a["shabad_id"],
  //         a["title"],
  //         a["author"],
  //         a["type"],
  //         a["duration"],
  //         a["attachment_name"],
  //         a["image"],
  //         a["is_media"],
  //         a['page'],
  //         a['author_id']);
  //     favMedias.add(favMedia);
  //     favMediasP.add(favMedia);
  //   }
  //   favMedias.forEach((a) {
  //     shuffleList.add(a);
  //   });
  //   return favMedias;
  // }

  // updateUserDownloadsMedia() async {
  //   setState(() {
  //     _getUserDownloads();
  //   });
  // }

  int fromFile = 1;
  var playButton;
  var shuffleButton;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playButton = DBProvider.db.downl;
    shuffleButton = DBProvider.db.downl;
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: maxHeight * 0.0270,
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: maxWidth * 0.0555, right: maxWidth * 0.0555),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        this.widget.show == true
                            ? this.widget.setPropertiesForFullScreen(
                                  context,
                                  this.widget.currentSong.title,
                                  this.widget.currentSong.author,
                                  this.widget.currentSong.attachmentName,
                                  this.widget.currentSong.image,
                                  this.widget.currentSong.shabadId,
                                  this.widget.currentSong.page,
                                  this.widget.currentSong.is_media,
                                  this.widget.currentSong.author_id,
                                  this.widget.currentSong.id,
                                  fromFile: fromFile,
                                )
                            : this.widget.setPropertiesForFullScreen(
                                  context,
                                  playButton[0].title,
                                  playButton[0].author,
                                  playButton[0].attachmentName,
                                  playButton[0].image,
                                  playButton[0].shabadId,
                                  playButton[0].page,
                                  playButton[0].is_media,
                                  playButton[0].author_id,
                                  playButton[0].id,
                                  fromFile: fromFile,
                                );
                        this.widget.play(
                            this.widget.show == true
                                ? this.widget.currentSong.attachmentName
                                : playButton[0].attachmentName,
                            context,
                            true);
                        List links = [];
                        for (int i = 0; i < playButton.length; i++) {
                          links.add(playButton[i]);
                        }
                        this.widget.setListLinks(links);
                        if (!mounted) return;
                        // setState(() {
                        //   this.widget.showOverlayFalse();
                        // });
                      },
                      child: Container(
                        height: maxHeight / 17,
                        width: maxWidth / 2.34,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff578ed3),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Play",
                                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: maxWidth / 27,
                    ),
                    GestureDetector(
                      onTap: () {
                        shuffleButton.shuffle();
                        Future.delayed(Duration(milliseconds: 100), () {
                          this.widget.show == true
                              ? this.widget.setPropertiesForFullScreen(
                                    context,
                                    this.widget.currentSong.title,
                                    this.widget.currentSong.author,
                                    this.widget.currentSong.attachmentName,
                                    this.widget.currentSong.image,
                                    this.widget.currentSong.shabadId,
                                    this.widget.currentSong.page,
                                    this.widget.currentSong.is_media,
                                    this.widget.currentSong.author_id,
                                    this.widget.currentSong.id,
                                    fromFile: fromFile,
                                  )
                              : this.widget.setPropertiesForFullScreen(
                                    context,
                                    shuffleButton[0].title,
                                    shuffleButton[0].author,
                                    shuffleButton[0].attachmentName,
                                    shuffleButton[0].image,
                                    shuffleButton[0].shabadId,
                                    shuffleButton[0].page,
                                    shuffleButton[0].is_media,
                                    shuffleButton[0].author_id,
                                    shuffleButton[0].id,
                                    fromFile: fromFile,
                                  );
                          this.widget.play(
                              this.widget.show == true
                                  ? this.widget.currentSong.attachmentName
                                  : shuffleButton[0].attachmentName,
                              context,
                              true);
                          List links = [];
                          for (int i = 0; i < shuffleButton.length; i++) {
                            links.add(shuffleButton[i]);
                          }
                          this.widget.setListLinks(links);
                          if (!mounted) return;
                          setState(() {});
                        });
                      },
                      child: Container(
                        height: maxHeight / 17,
                        width: maxWidth / 2.36,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                              color: Color(0xff578ed3),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.shuffle,
                                      color: Color(0xff578ed3),
                                    ),
                                    Text(
                                      "Shuffle",
                                      style: TextStyle(
                                          color: Color(0xff578ed3), fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: maxWidth * 0.0555, top: maxWidth * 0.0135),
            height: maxHeight / 1.57,
            child: FutureBuilder<List<Downloads>>(
              future: DBProvider.db.getAllDownloads(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        // Destination destination = destinations[index];
                        return Container(
                          margin: EdgeInsets.only(top: maxHeight * 0.0094),
                          width: maxWidth / 20,
                          child: Stack(
                            // alignment: Alignment.topCenter,
                            children: <Widget>[
                              // Positioned(
                              //   left: maxWidth / 6,
                              //   child: Container(
                              //     height: maxHeight * 0.0635,
                              //     width: maxWidth * 0.58333,
                              //     decoration: BoxDecoration(
                              //       color: Colors.transparent,
                              //       borderRadius: BorderRadius.circular(10.0),
                              //     ),
                              //   ),
                              // ),
                              Container(
                                // decoration: BoxDecoration(
                                //   color: Colors.white,
                                //   borderRadius: BorderRadius.circular(20.0),
                                //   boxShadow: [
                                //     BoxShadow(
                                //       color: Colors.black26,
                                //       offset: Offset(0.0, 2.0),
                                //       blurRadius: 6.0,
                                //     ),
                                //   ],
                                // ),
                                child: GestureDetector(
                                  onTap: () {
                                    print('song title -> ${snapshot.data[index].title}');
                                    print('attachment name -> ${snapshot.data[index].attachmentName}');
                                    this.widget.showOverlay(
                                        context,
                                        snapshot.data[index].title,
                                        snapshot.data[index].author,
                                        snapshot.data[index].attachmentName,
                                        snapshot.data[index].image.toString(),
                                        snapshot.data[index].shabadId,
                                        snapshot.data[index].page,
                                        snapshot.data[index].id,
                                        fromFile: snapshot.data[index].fromFile);
                                    this.widget.play(snapshot.data[index].attachmentName, context);
                                    List links = [];
                                    for (int i = index; i < snapshot.data.length; i++) {
                                      links.add(snapshot.data[i]);
                                    }
                                    this.widget.setListLinks(links);
                                    if (!mounted) return;
                                    setState(() {
                                      this.widget.showOverlayTrue();
                                    });
                                  },
                                  child: Stack(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: maxHeight * 0.014,
                                          left: maxWidth * 0.159,
                                        ),
                                        child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            ConstrainedBox(
                                              constraints: BoxConstraints(maxWidth: maxWidth * 0.594444),
                                              child: Text(
                                                snapshot.data[index].title,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            ConstrainedBox(
                                              constraints: BoxConstraints(maxWidth: maxWidth * 0.594444),
                                              child: Text(
                                                snapshot.data[index].author != null ? snapshot.data[index].author : "",
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        // tag: 'recently-played1',
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(6.0),
                                          child: Image.file(
                                            File(snapshot.data[index].image.toString()),
                                            height: maxHeight * 0.0635,
                                            width: maxWidth * 0.1305,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: maxWidth * 0.055555),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        // Container(
                                        //   padding: EdgeInsets.only(
                                        //     top: maxHeight * 0.0167,
                                        //   ),
                                        //   child: Text(
                                        //     snapshot.data[index].duration,
                                        //     maxLines: 1,
                                        //     overflow: TextOverflow.clip,
                                        //     style: TextStyle(fontSize: 10),
                                        //   ),
                                        // ),
                                        Padding(
                                          padding: EdgeInsets.only(top: maxHeight * 0.00675),
                                          child: GestureDetector(
                                            onTap: () {
                                              snapshot.data[index].is_media == 1
                                                  ? Navigator.of(context).push(PageRouteBuilder(
                                                      opaque: false,
                                                      pageBuilder:
                                                          (BuildContext context, animation, secondaryAnimation) =>
                                                              SongOptions(
                                                        indexOfSong: snapshot.data[index].id,
                                                        title: snapshot.data[index].title,
                                                        artistName: snapshot.data[index].author,
                                                        id: snapshot.data[index].id,
                                                        author_id: snapshot.data[index].author_id,
                                                        image: snapshot.data[index].image,
                                                        isDownloaded: true,
                                                      ),
                                                      // transitionDuration:
                                                      //     Duration(seconds: 1),
                                                      transitionsBuilder:
                                                          (ontext, animation, secondaryAnimation, child) {
                                                        var begin = Offset(0.0, -1.0);
                                                        var end = Offset.zero;
                                                        var curve = Curves.ease;

                                                        var tween = Tween(begin: begin, end: end)
                                                            .chain(CurveTween(curve: curve));

                                                        return SlideTransition(
                                                          position: animation.drive(tween),
                                                          child: child,
                                                        );
                                                      },
                                                    ))
                                                  : Navigator.of(context).push(PageRouteBuilder(
                                                      opaque: false,
                                                      pageBuilder:
                                                          (BuildContext context, animation, secondaryAnimation) =>
                                                              PodcastThreeDots(
                                                        title: snapshot.data[index].title,
                                                        id: snapshot.data[index].id,
                                                        attachmentName: snapshot.data[index].attachmentName,
                                                        isDownloaded: true,
                                                      ),
                                                      // transitionDuration:
                                                      //     Duration(seconds: 1),
                                                      transitionsBuilder:
                                                          (ontext, animation, secondaryAnimation, child) {
                                                        var begin = Offset(0.0, 1.0);
                                                        var end = Offset(0.0, 0.47);
                                                        var curve = Curves.ease;
                                                        var tween = Tween(begin: begin, end: end)
                                                            .chain(CurveTween(curve: curve));
                                                        return SlideTransition(
                                                          position: animation.drive(tween),
                                                          child: child,
                                                        );
                                                      },
                                                    ));
                                            },
                                            child: Container(
                                              child: Icon(
                                                Icons.more_horiz,
                                                color: Colors.grey,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Container());
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
