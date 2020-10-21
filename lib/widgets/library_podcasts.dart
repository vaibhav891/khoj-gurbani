import 'package:flutter/material.dart';
import 'package:khojgurbani_music/screens/podcast_on_three_dots.dart';
import 'package:khojgurbani_music/services/services.dart';

import '../service_locator.dart';

// class UserFavoritePodcast {
//   final int id;
//   final int shabadId;
//   final String title;
//   final String description;
//   final String author = null;
//   final int page = null;
//   final int is_media = null;
//   final int author_id = null;
//   final String type;
//   final String duration;
//   final String attachmentName;
//   final String image;

//   UserFavoritePodcast(
//     this.id,
//     this.shabadId,
//     this.title,
//     this.description,
//     this.type,
//     this.duration,
//     this.attachmentName,
//     this.image,
//   );
// }

class LibraryPodcasts extends StatefulWidget {
  final Function showOverlay;
  final Function showOverlayTrue;
  final Function showOverlayFalse;
  bool show;
  final Function play;
  final Function setListLinks;
  final Function setPropertiesForFullScreen;
  final currentSong;

  LibraryPodcasts(
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
  _LibraryPodcastsState createState() => _LibraryPodcastsState();
}

class _LibraryPodcastsState extends State<LibraryPodcasts> {
  var service = getIt<Services>();
  var userPodcasts;
  var shuffleListUserPodcasts;

  @override
  void initState() {
    service.userPodcastSubject.stream.listen((event) {
      if (!mounted) return;
      setState(() {
        userPodcasts = event;
      });
    });
    service.getUserFavoritePodcasts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(children: <Widget>[
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
                            )
                        : this.widget.setPropertiesForFullScreen(
                              context,
                              userPodcasts[0].title,
                              userPodcasts[0].author,
                              userPodcasts[0].attachmentName,
                              userPodcasts[0].image,
                              userPodcasts[0].shabadId,
                              userPodcasts[0].page,
                              userPodcasts[0].is_media,
                              userPodcasts[0].author_id,
                              userPodcasts[0].id,
                            );
                    this.widget.play(
                        this.widget.show == true
                            ? this.widget.currentSong.attachmentName
                            : userPodcasts[0].attachmentName,
                        context,
                        true);
                    List links = [];
                    for (int i = 0; i < userPodcasts.length; i++) {
                      links.add(userPodcasts[i]);
                    }
                    this.widget.setListLinks(links);
                    if (!mounted) return;
                    // setState(() {
                    // });
                  },
                  child: Container(
                    height: maxHeight / 17,
                    width: maxWidth / 2.36,
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
                    service.shuffleUserFavoritePodcasts.shuffle();
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
                              )
                          : this.widget.setPropertiesForFullScreen(
                                context,
                                service.shuffleUserFavoritePodcasts[0].title,
                                service.shuffleUserFavoritePodcasts[0].author,
                                service.shuffleUserFavoritePodcasts[0].attachmentName,
                                service.shuffleUserFavoritePodcasts[0].image,
                                service.shuffleUserFavoritePodcasts[0].shabadId,
                                service.shuffleUserFavoritePodcasts[0].page,
                                service.shuffleUserFavoritePodcasts[0].is_media,
                                service.shuffleUserFavoritePodcasts[0].author_id,
                                service.shuffleUserFavoritePodcasts[0].id,
                              );
                      this.widget.play(
                          this.widget.show == true
                              ? this.widget.currentSong.attachmentName
                              : service.shuffleUserFavoritePodcasts[0].attachmentName,
                          context,
                          true);
                      List links = [];
                      for (int m = 0; m < service.shuffleUserFavoritePodcasts.length; m++) {
                        links.add(service.shuffleUserFavoritePodcasts[m]);
                      }
                      this.widget.setListLinks(links);
                      if (!mounted) return;
                      setState(() {});
                    });
                  },
                  child: Container(
                    height: maxHeight / 17,
                    width: maxWidth / 2.34,
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
                                  style: TextStyle(color: Color(0xff578ed3), fontSize: 16, fontWeight: FontWeight.bold),
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
        height: maxHeight / 1.565,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: userPodcasts?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(top: maxHeight * 0.0094),
              // width: maxWidth * 0.5555,
              child: Stack(
                // alignment: Alignment.topCenter,
                children: <Widget>[
                  // Positioned(
                  //   left: maxWidth * 0.16666,
                  //   child: Container(
                  //     // height: 100.0,
                  //     width: maxWidth * 0.555,
                  //     decoration: BoxDecoration(
                  //       color: Colors.transparent,
                  //       borderRadius: BorderRadius.circular(10.0),
                  //     ),
                  //     child: Padding(
                  //       padding: EdgeInsets.only(
                  //           top: maxHeight * 0.0080),
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
                        this.widget.showOverlay(
                            context,
                            userPodcasts[index].title,
                            userPodcasts[index].author,
                            userPodcasts[index].attachmentName,
                            userPodcasts[index].image,
                            userPodcasts[index].shabadId,
                            userPodcasts[index].page,
                            userPodcasts[index].id);
                        this.widget.play(userPodcasts[index].attachmentName, context);
                        List links = [];
                        for (int i = index; i < userPodcasts.length; i++) {
                          links.add(userPodcasts[i]);
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: maxWidth * 0.594444),
                                  child: Text(
                                    userPodcasts[index].title,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6.0),
                              child: Image(
                                height: maxHeight * 0.0635,
                                width: maxWidth * 0.1305,
                                image: NetworkImage(userPodcasts[index].image),
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
                            Container(
                              padding: EdgeInsets.only(
                                top: maxHeight * 0.0167,
                              ),
                              child: Text(
                                userPodcasts[index].duration,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (BuildContext context, animation, secondaryAnimation) =>
                                      PodcastThreeDots(
                                    title: userPodcasts[index].title,
                                    id: userPodcasts[index].id,
                                    indexOfPodcast: userPodcasts[index].id,
                                  ),
                                  // transitionDuration: Duration(seconds: 1),
                                  transitionsBuilder: (ontext, animation, secondaryAnimation, child) {
                                    var begin = Offset(0.0, 1.0);
                                    var end = Offset(0.0, 0.47);
                                    var curve = Curves.ease;
                                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

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
                                  size: 20,
                                  color: Color(0xff727272),
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
        ),
      ),
    ]));
  }
}
