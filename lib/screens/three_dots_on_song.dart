import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:khojgurbani_music/models/Downloads.dart';
import 'package:khojgurbani_music/services/Database.dart';
import 'package:khojgurbani_music/services/downloadFiles.dart';
import 'package:khojgurbani_music/services/services.dart';
import 'dart:convert';
import 'dart:async';
import 'package:share/share.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../service_locator.dart';
import 'add_to_playlist.dart';
import 'artist.dart';

class SongOptions extends StatefulWidget {
  final indexOfSong;
  final indexOfArtist;
  final String title;
  final String artistName;
  final String attachmentName;
  final int id;
  final int is_media;
  final int author_id;
  final String image;
  final int shabadId;
  final int page;
  final int playlist_id;
  final Function showOverlay;
  final Function showOverlayTrue;
  final Function showOverlayFalse;
  bool show;
  final Function play;
  final Function setListLinks;
  final Function insertRecentlyPlayed;
  final Function setPropertiesForFullScreen;
  bool fromArtistPage;
  final currentSong;
  final int fromFullMusicPlayer;
  final Function setIsOpenFullScreen;
  bool isPlaying;
  final int fromFile;

  SongOptions({
    this.indexOfSong,
    this.indexOfArtist,
    this.title,
    this.artistName,
    this.attachmentName,
    this.id,
    this.is_media,
    this.author_id,
    this.image,
    this.shabadId,
    this.page,
    this.playlist_id,
    this.showOverlay,
    this.showOverlayTrue,
    this.showOverlayFalse,
    this.show,
    this.play,
    this.setListLinks,
    this.insertRecentlyPlayed,
    this.setPropertiesForFullScreen,
    this.fromArtistPage,
    this.currentSong,
    this.fromFullMusicPlayer,
    this.setIsOpenFullScreen,
    this.isPlaying,
    this.fromFile = 0,
  });

  @override
  _SongOptionsState createState() => _SongOptionsState();
}

class _SongOptionsState extends State<SongOptions> {
  var service = getIt<Services>();
  var download = getIt<Downloader>();
  var author_id;
  var url;

  @override
  void initState() {
    author_id = this.widget.author_id;
    url = 'https://khojgurbani.org/artistgurbanilist/' +
        author_id.toString() +
        '/' +
        Uri.encodeQueryComponent(this.widget.artistName).replaceAll('+', '%20');
    fetchUserFavorite();
    super.initState();
  }

  bool _isLoading = false;

  bool _isFavorite = false;

  var userFav;

  fetchUserFavorite() async {
    setState(() {
      _isLoading = true;
    });

    userFav = await service.getUserFavoriteMedia();

    setState(() {
      _isLoading = false;
    });

    userFav.forEach((u) {
      if (u.id.toString().contains(this.widget.indexOfSong.toString())) {
        setState(() {
          _isFavorite = true;
        });
      }
    });
  }

  mediaFav(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int userId = prefs.getInt('user_id');
    final String machineId = prefs.getString('machine_id');

    // final headers = {'Authorization': "Bearer " + token};
    var body = {
      'media_id': json.encode(id),
      'user_id': json.encode(userId),
      'machine_id': machineId
    };
    //var body = jsonEncode({'media_id': id, 'user_id': userId, 'machine_id': machineId});
    print(body);
    final res = await http
        .post('https://api.khojgurbani.org/api/v1/android/fav?', body: body);
    // headers: headers
    if (res.statusCode == 200)
      final data = jsonDecode(res.body);
    else
      print('error from API call ${res.reasonPhrase}');

    if (!mounted) return;
    setState(() {
      service.getUserFavoriteMedia();
    });
  }

  mediaDownload(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final token = prefs.getString('token');
    final machineId = prefs.getString('machine_id');

    // final headers = {'Authorization': "Bearer " + token};
    final res = await http.post(
        'https://api.khojgurbani.org/api/v1/android/user-download?media_id=$id&user_id=$userId&machine_id=$machineId&');
    // headers: headers
    // );
    final data = jsonDecode(res.body);
  }

  deleteTrackFromPlaylist(int playlist_id, int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var podcast_id = null;

    // final headers = {'Authorization': "Bearer " + token};
    final res = await http.get(
        'https://api.khojgurbani.org/api/v1/android/delete-playlist-track?playlist_id=$playlist_id&media_id=$id&podcast_id=$podcast_id');

    service.getPlaylistTracks(this.widget.playlist_id);
    Navigator.of(context).pop();
    removedFromPlaylistDialog();
    final data = jsonDecode(res.body);
  }

  removedFromPlaylistDialog() {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop();
          });
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            title: Center(
              child: Text(
                'Removed from Playlist',
                style: TextStyle(fontSize: 14),
              ),
            ),
          );
        });
  }

  addedToFavoriteDialog() {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop();
          });
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            title: Center(
              child: Text(
                _isFavorite == false
                    ? 'Added to Favorite'
                    : 'Removed from Favorite',
                style: TextStyle(fontSize: 14),
              ),
            ),
          );
        });
  }

  downloading() {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop();
          });
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            title: Center(
              child: Text(
                'Downloading...',
                style: TextStyle(fontSize: 14),
              ),
            ),
          );
        });
  }

  _removeFromDownload(int id, String pathname) async {
    await download.removeDownloadFile(pathname);
    await DBProvider.db.deleteDownload(id);
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Material(
      color: Color(0xff578ed3).withOpacity(0.8),
      child: Container(
        decoration: BoxDecoration(
          color: new Color(0xff578ed3).withOpacity(0.95),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.4, sigmaY: 1.4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              (() {
                if (this.widget.show == true ||
                    service.showFromService == true &&
                        this.widget.fromArtistPage == true) {
                  return SizedBox(
                    height: maxHeight / 8,
                  );
                } else if (this.widget.show == true &&
                    this.widget.fromArtistPage == false) {
                  return SizedBox(
                    height: maxHeight / 8,
                  );
                } else if (this.widget.fromArtistPage == true &&
                    this.widget.show == false) {
                  return SizedBox(
                    height: maxHeight / 19,
                  );
                } else {
                  return SizedBox(
                    height: maxHeight / 19,
                  );
                }
              }()),
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: maxWidth / 1.3,
                      child: Text(
                        this.widget.title,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: maxWidth * 0.04722, top: maxHeight * 0.0067),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: maxWidth / 1.3,
                      child: Text(
                        this.widget.artistName != null
                            ? this.widget.artistName
                            : '',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: maxWidth * 0.0583, top: maxHeight * 0.0378),
                child: InkWell(
                  onTap: () {
                    this.widget.playlist_id == null
                        ? Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, animation,
                                    secondaryAnimation) =>
                                AddToPlaylist(
                              media_id: this.widget.id,
                            ),
                            transitionDuration: Duration(seconds: 1),
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
                        // .then((value) => Navigator.of(context).pop())
                        : deleteTrackFromPlaylist(
                            this.widget.playlist_id, this.widget.id);
                  },
                  child: Container(
                    width: maxWidth * 0.6722,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.queue_music, color: Colors.white),
                        SizedBox(
                          width: maxWidth * 0.04444,
                        ),
                        Text(
                          this.widget.playlist_id != null
                              ? "Remove from Playlist"
                              : "Add to Playlist",
                          // : "Remove from Playlist",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: maxWidth * 0.05833, top: maxHeight * 0.0378),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: maxWidth * 0.5722,
                    child: InkWell(
                      onTap: () {
                        mediaFav(this.widget.id);
                        Navigator.of(context).pop();
                        addedToFavoriteDialog();
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            _isFavorite == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: maxWidth * 0.044,
                          ),
                          Text(
                            _isFavorite == true
                                ? "Remove from Favorite"
                                : "Add to Favorite",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              this.widget.fromArtistPage == true
                  ? Container()
                  : Padding(
                      padding: EdgeInsets.only(
                          left: maxWidth * 0.05833, top: maxHeight * 0.0378),
                      child: InkWell(
                        onTap: () {
                          if (this.widget.fromFullMusicPlayer == 1) {
                            this.widget.showOverlay(
                                  context,
                                  this.widget.currentSong.title,
                                  this.widget.currentSong.author,
                                  this.widget.currentSong.attachmentName,
                                  this.widget.currentSong.image,
                                  this.widget.currentSong.shabadId,
                                  this.widget.currentSong.page,
                                  this.widget.currentSong.id,
                                  is_media: this.widget.currentSong.is_media,
                                  author_id: this.widget.currentSong.author_id,
                                );
                            this.widget.showOverlayTrue();
                          }
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => ArtistPage(
                                        indexOfArtist:
                                            this.widget.indexOfArtist,
                                        id: this.widget.author_id,
                                        name: this.widget.artistName,
                                        attachmentName: this.widget.image,
                                        showOverlay: this.widget.showOverlay,
                                        showOverlayTrue:
                                            this.widget.showOverlayTrue,
                                        showOverlayFalse:
                                            this.widget.showOverlayFalse,
                                        show: widget.show,
                                        play: this.widget.play,
                                        setListLinks: this.widget.setListLinks,
                                        setPropertiesForFullScreen: this
                                            .widget
                                            .setPropertiesForFullScreen,
                                        insertRecentlyPlayed:
                                            this.widget.insertRecentlyPlayed,
                                        currentSong: this.widget.currentSong,
                                        setIsOpenFullScreen:
                                            this.widget.setIsOpenFullScreen,
                                        fromFullMusicPlayer:
                                            this.widget.fromFullMusicPlayer,
                                      )));
                        },
                        child: Container(
                          width: maxWidth * 0.4722,
                          child: Row(
                            children: <Widget>[
                              Image(
                                image: AssetImage(
                                    'assets/images/Mask Group 9.png'),
                              ),
                              SizedBox(
                                width: maxWidth * 0.044,
                              ),
                              Text(
                                "Go to Artist",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              // : Container(),
              Padding(
                padding: EdgeInsets.only(
                    left: maxWidth * 0.05833, top: maxHeight * 0.0378),
                child: InkWell(
                  onTap: () {
                    // mediaDownload(this.widget.id);
                    if (widget.fromFile == 0) {
                      print('inside download -> song name [${widget.title}]');
                      print(
                          'inside download -> attachment name [${widget.attachmentName}]');
                      print('inside download -> image path [${widget.image}]');

                      download.downloadImage(
                          this.widget.image, this.widget.title);
                      download
                          .downloadFile(
                        this.widget.attachmentName,
                        this.widget.title,
                      )
                          .then(
                        (value) async {
                          Downloads newDT = Downloads(
                            id: widget.id,
                            title: widget.title,
                            author: widget.artistName,
                            attachmentName: download.pathName.toString(),
                            image: download.imagePath.toString(),
                            is_media: 1,
                            author_id: widget.author_id,
                            shabadId: widget.shabadId,
                            duration: value,
                            page: widget.page,
                            timestamp: DateTime.now().millisecondsSinceEpoch,
                          );
                          await DBProvider.db.newDownload(newDT);
                          // call api to notify server of new download
                          mediaDownload(widget.id);
                        },
                        onError: (e) => print(
                            'Something went wrong, download returned error'),
                      );

                      Navigator.of(context).pop();
                      downloading();
                    } else {
                      _removeFromDownload(widget.id, widget.attachmentName);
                      Navigator.of(context).popAndPushNamed('/library');
                    }
                  },
                  child: Container(
                    width: maxWidth * 0.4722,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.file_download,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: maxWidth * 0.044,
                        ),
                        Text(
                          widget.fromFile == 0
                              ? "Download"
                              : 'Remove from downloads',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(
              //       left: maxWidth * 0.05833, top: maxHeight * 0.0378),
              //   child: InkWell(
              //     onTap: () {},
              //     child: Container(
              //       width: maxWidth * 0.4722,
              //       child: Row(
              //         children: <Widget>[
              //           Icon(
              //             Icons.playlist_add,
              //             color: Colors.white,
              //           ),
              //           SizedBox(
              //             width: maxWidth * 0.044,
              //           ),
              //           Text(
              //             "Add to Queue",
              //             style: TextStyle(
              //               color: Colors.white,
              //               fontSize: 14,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.only(
                  left: maxWidth * 0.05833,
                  top: maxHeight * 0.0378,
                ),
                child: InkWell(
                  onTap: () {
                    // final RenderBox box = context.findRenderObject();
                    Share.share(url
                        // ,
                        //     sharePositionOrigin:
                        //         box.localToGlobal(Offset.zero) & box.size
                        );
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: maxWidth * 0.4722,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.file_upload,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: maxWidth * 0.044,
                        ),
                        Text(
                          "Share",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: (() {
                  if (this.widget.show == true ||
                      service.showFromService == true &&
                          this.widget.fromArtistPage == true) {
                    return SizedBox(
                      height: maxHeight / 3.3,
                    );
                  } else if (this.widget.fromArtistPage == true &&
                      this.widget.show == false) {
                    return SizedBox(
                      height: maxHeight / 2,
                    );
                  } else if (this.widget.show == true &&
                      this.widget.fromArtistPage == false) {
                    return SizedBox(
                      height: maxHeight / 4.2,
                    );
                  } else {
                    return SizedBox(
                      height: maxHeight / 2.3,
                    );
                  }
                }()),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: maxHeight * 0.0675,
                      width: maxWidth * 0.138888,
                      child: Center(
                        child: Text(
                          "Close",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
