import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khojgurbani_music/screens/podcast_on_three_dots.dart';
import 'package:khojgurbani_music/screens/three_dots_on_song.dart';
import 'package:khojgurbani_music/services/services.dart';
import 'package:khojgurbani_music/widgets/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../service_locator.dart';

// class PlaylistTracks {
//   int id;
//   int shabadId;
//   int favourite;
//   String title;
//   String author;
//   String type;
//   String duration;
//   String attachmentName;
//   String image;
//   int is_media;
//   int page;
//   int author_id;

//   PlaylistTracks(
//       this.id,
//       this.shabadId,
//       this.favourite,
//       this.title,
//       this.author,
//       this.type,
//       this.duration,
//       this.attachmentName,
//       this.image,
//       this.is_media,
//       this.page,
//       this.author_id);
// }

class PlaylistFull extends StatefulWidget {
  final playlist_id;
  final playlist_name;
  final Function showOverlay;
  final Function showOverlayTrue;
  final Function showOverlayFalse;
  bool show;
  final Function play;
  final Function setListLinks;
  final Function getPlaylists;
  final int cnt_playlist_media;
  final Function setPropertiesForFullScreen;
  final Function insertRecentlyPlayed;
  final currentSong;

  PlaylistFull({
    Key key,
    this.playlist_id,
    this.playlist_name,
    this.showOverlay,
    this.showOverlayTrue,
    this.showOverlayFalse,
    this.show,
    this.play,
    this.setListLinks,
    this.getPlaylists,
    this.cnt_playlist_media,
    this.setPropertiesForFullScreen,
    this.insertRecentlyPlayed,
    this.currentSong,
  }) : super(key: key);

  @override
  _PlaylistFullState createState() => _PlaylistFullState();
}

class _PlaylistFullState extends State<PlaylistFull> {
  var service = getIt<Services>();

  deletePlaylist(int playlist_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final token = prefs.getString('token');
    final machineId = prefs.getString('machine_id');

    // final headers = {'Authorization': "Bearer " + token};
    final response = await http.get(
      'https://api.khojgurbani.org/api/v1/android/delete-playlist?user_id=$userId&machine_id=$machineId&playlist_id=$playlist_id',
      // headers: headers
    );
    this.widget.getPlaylists();
    var jsonData = json.decode(response.body);
  }

  deletePlaylistDialog() {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop();
          });
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            title: Center(
              child: Text(
                "Playlist Removed",
                style: TextStyle(fontSize: 14),
              ),
            ),
          );
        });
  }

  var playlistTracks;
  List shuffleListPlaylist = [];

  @override
  void initState() {
    service.playlistSubject.stream.listen((event) {
      if (!mounted) return;
      setState(() {
        playlistTracks = event;
      });
      shuffleListPlaylist.addAll(playlistTracks);
    });
    service.getPlaylistTracks(this.widget.playlist_id);
    super.initState();
  }

  bool fromArtistPage = false;

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffF5F5F5),
          title: Text(
            this.widget.playlist_name,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          leading: Container(
            // alignment: AxisDirection.left,
            // padding: EdgeInsets.only(right: 90),
            child: IconButton(
              color: Colors.black,
              // padding: EdgeInsets.only(bottom: 30),
              iconSize: 30,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(context);
              },
              padding: EdgeInsets.only(bottom: maxHeight * 0.01351),
              icon: Icon(
                Icons.chevron_left,
              ),
            ),
          ),
        ),
        bottomNavigationBar: MyBottomNavBar(),
        body: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: maxHeight * 0.0229, left: maxWidth * 0.0555),
                  child: Card(
                    elevation: 3,
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: (service.playlistTracks != null)
                              ? service.playlistTracks.length == 0
                                  ? Container(
                                      height: maxHeight * 0.2297297,
                                      width: maxWidth * 0.4222,
                                    )
                                  : Image(
                                      height: maxHeight * 0.2297297,
                                      width: maxWidth * 0.4222,
                                      image: NetworkImage(service.playlistTracks[0].image),
                                      fit: BoxFit.cover,
                                    )
                              : Container(
                                  height: maxHeight * 0.2297297,
                                  width: maxWidth * 0.4222,
                                )),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: maxHeight * 0.0675, left: maxWidth * 0.038),
                  child: Container(
                    width: maxWidth * 0.3361,
                    child: Column(
                      children: <Widget>[
                        Row(children: <Widget>[
                          Container(
                            width: maxWidth * 0.2361,
                            height: 25,
                            child: Text(
                              widget.playlist_name,
                              // widget.name,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ]),
                        Row(children: <Widget>[
                          Container(
                            width: maxWidth * 0.2361,
                            // height: maxHeight * 0.07432,
                            child: Text(
                              service.length == null ? "" : service.length.toString() + " songs",
                              // widget.name,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16, color: Colors.grey
                                  // fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ]),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            SizedBox(
                              height: maxHeight * 0.027027,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: maxHeight * 0.0743,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: maxHeight * 0.0405,
                              width: maxWidth * 0.277,
                              child: Container(
                                // padding: EdgeInsets.only(left: 0),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(6.0),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        deletePlaylist(widget.playlist_id);
                                        this.widget.getPlaylists();
                                        Navigator.of(context).pop(context);
                                        deletePlaylistDialog();
                                      },
                                      child: Center(
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            Text(
                                              'Remove',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: maxHeight * 0.0135,
            ),
            Padding(
              padding: EdgeInsets.only(left: maxWidth * 0.0555, right: maxWidth * 0.0555),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: maxHeight / 17,
                    width: maxWidth / 2.34,
                    child: GestureDetector(
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
                                  playlistTracks[0].title,
                                  playlistTracks[0].author,
                                  playlistTracks[0].attachmentName,
                                  playlistTracks[0].image,
                                  playlistTracks[0].shabadId,
                                  playlistTracks[0].page,
                                  playlistTracks[0].is_media,
                                  playlistTracks[0].author_id,
                                  playlistTracks[0].id,
                                );
                        this.widget.play(
                            this.widget.show == true
                                ? this.widget.currentSong.attachmentName
                                : playlistTracks[0].attachmentName,
                            context,
                            true);
                        List links = [];
                        for (int i = 0; i < playlistTracks.length; i++) {
                          links.add(playlistTracks[i]);
                        }
                        this.widget.setListLinks(links);
                        if (!mounted) return;
                        setState(() {});
                      },
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
                    width: maxHeight * 0.0135,
                  ),
                  GestureDetector(
                    onTap: () {
                      shuffleListPlaylist.shuffle();
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
                                  shuffleListPlaylist[0].title,
                                  shuffleListPlaylist[0].author,
                                  shuffleListPlaylist[0].attachmentName,
                                  shuffleListPlaylist[0].image,
                                  shuffleListPlaylist[0].shabadId,
                                  shuffleListPlaylist[0].page,
                                  shuffleListPlaylist[0].is_media,
                                  shuffleListPlaylist[0].author_id,
                                  shuffleListPlaylist[0].id,
                                );
                        this.widget.play(
                            this.widget.show == true
                                ? this.widget.currentSong.attachmentName
                                : shuffleListPlaylist[0].attachmentName,
                            context,
                            true);
                        List links = [];
                        for (int i = 0; i < shuffleListPlaylist.length; i++) {
                          links.add(shuffleListPlaylist[i]);
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
                                    style:
                                        TextStyle(color: Color(0xff578ed3), fontSize: 16, fontWeight: FontWeight.bold),
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
            Flexible(
              child: Container(
                padding: EdgeInsets.only(left: maxWidth * 0.0555, top: maxHeight * 0.02162),
                height: maxHeight * 0.58486,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: playlistTracks?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(top: maxHeight * 0.0094),
                      child: Stack(
                        // alignment: Alignment.topCenter,
                        children: <Widget>[
                          // Positioned(
                          //   left: maxWidth * 0.166,
                          //   child:
                          Container(
                              // height: 100.0,
                              // width: maxWidth * 0.4722,
                              // decoration: BoxDecoration(
                              //   color: Colors.transparent,
                              //   borderRadius:
                              //       BorderRadius.circular(10.0),
                              // ),

                              ),
                          // )
                          Container(
                            // decoration: BoxDecoration(
                            //   color: Colors.white,
                            //   borderRadius:
                            //       BorderRadius.circular(20.0),
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
                                      playlistTracks[index].title,
                                      playlistTracks[index].author,
                                      playlistTracks[index].attachmentName,
                                      playlistTracks[index].image,
                                      playlistTracks[index].shabadId,
                                      playlistTracks[index].page,
                                      playlistTracks[index].id,
                                      is_media: playlistTracks[index].is_media,
                                      author_id: playlistTracks[index].author_id,
                                    );
                                this.widget.play(playlistTracks[index].attachmentName, context);
                                List links = [];
                                for (int i = index; i < playlistTracks.length; i++) {
                                  links.add(playlistTracks[i]);
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
                                            playlistTracks[index].title,
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
                                            playlistTracks[index].author,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 14.0, fontWeight: FontWeight.w600, color: Color(0xffB3B3B3)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // tag: 'recently-played1',
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6.0),
                                      child: Image(
                                        height: maxHeight * 0.0635,
                                        width: maxWidth * 0.1305,
                                        image: NetworkImage(playlistTracks[index].image),
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
                                        playlistTracks[index].duration,
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        playlistTracks[index].is_media == 1
                                            ? Navigator.of(context).push(PageRouteBuilder(
                                                opaque: false,
                                                pageBuilder: (BuildContext context, animation, secondaryAnimation) =>
                                                    SongOptions(
                                                  indexOfSong: playlistTracks[index].id,
                                                  indexOfArtist: playlistTracks[index].author_id,
                                                  title: playlistTracks[index].title,
                                                  artistName: playlistTracks[index].author,
                                                  attachmentName: playlistTracks[index].attachmentName,
                                                  id: playlistTracks[index].id,
                                                  is_media: playlistTracks[index].is_media,
                                                  playlist_id: this.widget.playlist_id,
                                                  author_id: playlistTracks[index].author_id,
                                                  image: playlistTracks[index].image,
                                                  showOverlay: this.widget.showOverlay,
                                                  showOverlayTrue: this.widget.showOverlayTrue,
                                                  showOverlayFalse: this.widget.showOverlayFalse,
                                                  show: this.widget.show,
                                                  play: this.widget.play,
                                                  setListLinks: this.widget.setListLinks,
                                                  insertRecentlyPlayed: this.widget.insertRecentlyPlayed,
                                                  setPropertiesForFullScreen: this.widget.setPropertiesForFullScreen,
                                                  fromArtistPage: fromArtistPage,
                                                ),
                                                // transitionDuration:
                                                //     Duration(seconds: 1),
                                                transitionsBuilder: (ontext, animation, secondaryAnimation, child) {
                                                  var begin = Offset(0.0, -1.0);
                                                  var end = this.widget.show == true ? Offset(0.0, -0.08) : Offset.zero;
                                                  var curve = Curves.ease;

                                                  var tween =
                                                      Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                                  return SlideTransition(
                                                    position: animation.drive(tween),
                                                    child: child,
                                                  );
                                                },
                                              ))
                                            : Navigator.of(context).push(PageRouteBuilder(
                                                opaque: false,
                                                pageBuilder: (BuildContext context, animation, secondaryAnimation) =>
                                                    PodcastThreeDots(
                                                  playlist_id: this.widget.playlist_id,
                                                  is_media: playlistTracks[index].is_media,
                                                  title: playlistTracks[index].title,
                                                  id: playlistTracks[index].id,
                                                  indexOfPodcast: playlistTracks[index].id,
                                                ),
                                                // transitionDuration:
                                                //     Duration(seconds: 1),
                                                transitionsBuilder: (ontext, animation, secondaryAnimation, child) {
                                                  var begin = Offset(0.0, 1.0);
                                                  var end = Offset(0.0, 0.47);
                                                  var curve = Curves.ease;
                                                  var tween =
                                                      Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                                  return SlideTransition(
                                                    position: animation.drive(tween),
                                                    child: child,
                                                  );
                                                },
                                              ));
                                      },
                                      child: Container(
                                        child: Icon(
                                          CupertinoIcons.ellipsis,
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
            ),
          ],
        ));
  }
}
