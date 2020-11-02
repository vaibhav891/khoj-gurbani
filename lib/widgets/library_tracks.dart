import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khojgurbani_music/screens/three_dots_on_song.dart';
import 'package:khojgurbani_music/services/loginAndRegistrationServices.dart';
import 'package:khojgurbani_music/services/services.dart';
import 'dart:async';

import '../service_locator.dart';

// class UserFavoriteMedia {
//   final int id;
//   final int shabadId;
//   final String title;
//   final String author;
//   final String type;
//   final String duration;
//   final String attachmentName;
//   final String image;
//   final int page;
//   final int is_media;
//   final int author_id;

//   UserFavoriteMedia(
//       this.id,
//       this.shabadId,
//       this.title,
//       this.author,
//       this.type,
//       this.duration,
//       this.attachmentName,
//       this.image,
//       this.page,
//       this.is_media,
//       this.author_id);
// }

class LibraryTracks extends StatefulWidget {
  final Function showOverlay;
  final Function showOverlayTrue;
  final Function showOverlayFalse;
  bool show;
  final Function play;
  final Function setListLinks;
  final Function setPropertiesForFullScreen;
  final Function insertRecentlyPlayed;
  final currentSong;

  LibraryTracks({
    Key key,
    this.showOverlay,
    this.showOverlayTrue,
    this.showOverlayFalse,
    this.show,
    this.play,
    this.setListLinks,
    this.setPropertiesForFullScreen,
    this.insertRecentlyPlayed,
    this.currentSong,
  }) : super(key: key);

  @override
  _LibraryTracksState createState() => _LibraryTracksState();
}

class _LibraryTracksState extends State<LibraryTracks> {
  var service = getIt<Services>();
  var log = getIt<LoginAndRegistrationService>();

  var userMedia;
  var shuffleListUserMedias;

  @override
  void initState() {
    service.userMediaSubject.stream.listen((event) {
      if (!mounted) return;
      setState(() {
        userMedia = event;
      });
    });
    service.getUserFavoriteMedia();
    super.initState();
  }

  bool fromArtistPage = false;

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
                padding: EdgeInsets.only(
                    left: maxWidth * 0.0555, right: maxWidth * 0.0555),
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
                                  userMedia[0].title,
                                  userMedia[0].author,
                                  userMedia[0].attachmentName,
                                  userMedia[0].image,
                                  userMedia[0].shabadId,
                                  userMedia[0].page,
                                  userMedia[0].is_media,
                                  userMedia[0].author_id,
                                  userMedia[0].id,
                                );
                        this.widget.play(
                            this.widget.show == true
                                ? this.widget.currentSong.attachmentName
                                : userMedia[0].attachmentName,
                            context,
                            true);
                        List links = [];
                        for (int i = 0; i < userMedia.length; i++) {
                          links.add(userMedia[i]);
                        }
                        this.widget.setListLinks(links);
                        if (!mounted) return;
                        setState(() {});
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
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
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
                        service.shuffleListUserMedias.shuffle();
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
                                    service.shuffleListUserMedias[0].title,
                                    service.shuffleListUserMedias[0].author,
                                    service.shuffleListUserMedias[0]
                                        .attachmentName,
                                    service.shuffleListUserMedias[0].image,
                                    service.shuffleListUserMedias[0].shabadId,
                                    service.shuffleListUserMedias[0].page,
                                    service.shuffleListUserMedias[0].is_media,
                                    service.shuffleListUserMedias[0].author_id,
                                    service.shuffleListUserMedias[0].id,
                                  );
                          this.widget.play(
                              this.widget.show == true
                                  ? this.widget.currentSong.attachmentName
                                  : service
                                      .shuffleListUserMedias[0].attachmentName,
                              context,
                              true);
                          List links = [];
                          for (int i = 0;
                              i < service.shuffleListUserMedias.length;
                              i++) {
                            links.add(service.shuffleListUserMedias[i]);
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
                                      style: TextStyle(
                                          color: Color(0xff578ed3),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              // RaisedButton(
                              //   onPressed:() => log.getUserTest(),
                              // ),
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
            padding: EdgeInsets.only(
                left: maxWidth * 0.0555, top: maxWidth * 0.0135),
            height: maxHeight / 1.565,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: userMedia?.length ?? 0,
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
                                  userMedia[index].title,
                                  userMedia[index].author,
                                  userMedia[index].attachmentName,
                                  userMedia[index].image,
                                  userMedia[index].shabadId,
                                  userMedia[index].page,
                                  userMedia[index].id,
                                  is_media: userMedia[index].is_media,
                                  author_id: userMedia[index].author_id,
                                );
                            this
                                .widget
                                .play(userMedia[index].attachmentName, context);
                            List links = [];
                            for (int i = index; i < userMedia.length; i++) {
                              links.add(userMedia[i]);
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
                                  top: maxHeight * 0.006,
                                  left: maxWidth * 0.159,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: maxWidth * 0.594444),
                                      child: Text(
                                        userMedia[index].title,
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: maxHeight * 0.006,
                                    ),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: maxWidth * 0.594444),
                                      child: Text(
                                        userMedia[index].author,
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14.0,
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
                                    image: NetworkImage(userMedia[index].image),
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
                                    top: maxHeight * 0.006,
                                  ),
                                  child: Text(
                                    userMedia[index].duration,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: maxHeight * 0.00675),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(PageRouteBuilder(
                                        opaque: false,
                                        pageBuilder: (BuildContext context,
                                                animation,
                                                secondaryAnimation) =>
                                            SongOptions(
                                          indexOfSong: userMedia[index].id,
                                          indexOfArtist:
                                              userMedia[index].author_id,
                                          title: userMedia[index].title,
                                          artistName: userMedia[index].author,
                                          attachmentName:
                                              userMedia[index].attachmentName,
                                          id: userMedia[index].id,
                                          playlist_id: null,
                                          author_id: userMedia[index].author_id,
                                          image: userMedia[index].image,
                                          showOverlay: this.widget.showOverlay,
                                          showOverlayTrue:
                                              this.widget.showOverlayTrue,
                                          showOverlayFalse:
                                              this.widget.showOverlayFalse,
                                          show: this.widget.show,
                                          play: this.widget.play,
                                          setListLinks:
                                              this.widget.setListLinks,
                                          insertRecentlyPlayed:
                                              this.widget.insertRecentlyPlayed,
                                          setPropertiesForFullScreen: this
                                              .widget
                                              .setPropertiesForFullScreen,
                                          fromArtistPage: fromArtistPage,
                                        ),
                                        // transitionDuration:
                                        //     Duration(seconds: 1),
                                        transitionsBuilder: (ontext, animation,
                                            secondaryAnimation, child) {
                                          var begin = Offset(0.0, -1.0);
                                          var end = this.widget.show == true
                                              ? Offset(0.0, -0.08)
                                              : Offset.zero;
                                          var curve = Curves.ease;

                                          var tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));

                                          return SlideTransition(
                                            position: animation.drive(tween),
                                            child: child,
                                          );
                                        },
                                      ));
                                      //     .then((value) {
                                      //   setState(() {
                                      //     getUserFavoriteMedia();
                                      //   });
                                      // });
                                    },
                                    child: Container(
                                      child: Icon(
                                        CupertinoIcons.ellipsis,
                                        size: 20,
                                        color: Color(0xff727272),
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
            ),
          )
        ],
      ),
    );
  }
}
