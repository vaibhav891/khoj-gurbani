import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:khojgurbani_music/models/Downloads.dart';
import 'package:khojgurbani_music/services/Database.dart';
import 'package:khojgurbani_music/services/downloadFiles.dart';
import 'package:khojgurbani_music/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../service_locator.dart';
import 'add_to_playlist.dart';

class PodcastThreeDots extends StatefulWidget {
  final String title;
  final String artistName;
  final String image;
  final String attachmentName;
  final int playlist_id;
  final int id;
  final int is_media;
  final indexOfPodcast;
  final int fromFile;

  const PodcastThreeDots({
    Key key,
    this.title,
    this.artistName,
    this.image,
    this.attachmentName,
    this.id,
    this.is_media,
    this.playlist_id,
    this.indexOfPodcast,
    this.fromFile = 0,
  }) : super(key: key);

  @override
  _PodcastThreeDotsState createState() => _PodcastThreeDotsState();
}

class _PodcastThreeDotsState extends State<PodcastThreeDots> {
  var service = getIt<Services>();
  var download = getIt<Downloader>();

  initState() {
    fetchUserFavoritePodcasts();
    super.initState();
  }

  bool _isLoading = false;

  bool _isFavorite = false;

  var userPodcasts;

  fetchUserFavoritePodcasts() async {
    setState(() {
      _isLoading = true;
    });

    userPodcasts = await service.getUserFavoritePodcasts();

    setState(() {
      _isLoading = false;
    });

    userPodcasts.forEach((u) {
      if (u.id.toString().contains(this.widget.indexOfPodcast.toString())) {
        setState(() {
          _isFavorite = true;
        });
      }
    });
  }

  podcastFav(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final machineId = prefs.getString('machine_id');

    final res = await http
        .post('https://api.khojgurbani.org/api/v1/android/podcast-fav', body: {
      'podcast_id': json.encode(id),
      'user_id': json.encode(userId),
      'machine_id': machineId
    });
    final data = jsonDecode(res.body);
    if (!mounted) return;
    setState(() {
      service.getUserFavoritePodcasts();
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

  podcastDownload(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    //final token = prefs.getString('token');
    final machineId = prefs.getString('machine_id');

    // final headers = {'Authorization': "Bearer " + token};
    final res = await http.post(
      'https://api.khojgurbani.org/api/v1/android/user-download?podcast_id=$id' +
          (userId == null
              ? 'machine_id=$machineId&'
              : 'user_id=$userId&machine_id=$machineId&'),
      // headers: headers
    );
    if (res.statusCode == 200) {
      print('api returned success');
    } else {
      print('Api call returned error -> ${res.reasonPhrase}');
    }
  }

  deleteTrackFromPlaylist(int playlist_id, int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var media_id = null;

    final res = await http.get(
        'https://api.khojgurbani.org/api/v1/android/delete-playlist-track?playlist_id=$playlist_id&podcast_id=$id&media_id=$media_id');

    Navigator.of(context).pop();
    final data = jsonDecode(res.body);
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
      },
    );
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
        color: Colors.white.withOpacity(0.1),
        child: Container(
          height: 400,
          decoration: BoxDecoration(
            color: Color(0xff578ed3).withOpacity(0.9),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.4, sigmaY: 1.4),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 30),
                      child: Container(
                        width: 300,
                        child: Text(
                          this.widget.title,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    this.widget.playlist_id == null
                        ? Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, animation,
                                    secondaryAnimation) =>
                                AddToPlaylist(
                              podcast_id: this.widget.id,
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
                        : deleteTrackFromPlaylist(
                            this.widget.playlist_id, this.widget.id);
                  },
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 15),
                        child: Icon(
                          Icons.queue_music,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 15),
                        child: Text(
                          this.widget.playlist_id != null
                              ? 'Remove from Playlist'
                              : 'Add to Playlist',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 15),
                      child: Icon(
                        Icons.file_download,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 15),
                      child: GestureDetector(
                        onTap: () {
                          if (widget.fromFile == 0) {
                            print(
                                'inside download -> song name [${widget.title}]');
                            print(
                                'inside download -> attachment name [${widget.attachmentName}]');
                            print(
                                'inside download -> image path [${widget.image}]');
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
                                  title: this.widget.title,
                                  author: this.widget.artistName,
                                  attachmentName: download.pathName.toString(),
                                  image: download.imagePath.toString(),
                                  is_media: 0,
                                  //author_id: no author id for podcast
                                  //shabad_id: no shabad id for podcast
                                  duration: value,
                                  timestamp:
                                      DateTime.now().millisecondsSinceEpoch,
                                );
                                await DBProvider.db.newDownload(newDT);
                                // call api to notify server of new download
                                podcastDownload(widget.id);
                              },
                              onError: () => print(
                                  'Something went wrong, download returned error'),
                            );
                            Navigator.of(context).pop();
                            downloading();
                            //downloading();
                          } else {
                            _removeFromDownload(
                                widget.id, widget.attachmentName);
                            Navigator.of(context).popAndPushNamed('/library');
                          }
                        },
                        child: Text(
                          widget.fromFile == 0
                              ? 'Download'
                              : 'Remove from download',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 15),
                      child: Icon(
                        _isFavorite == true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 15),
                      child: GestureDetector(
                        onTap: () {
                          podcastFav(this.widget.id);
                          Navigator.of(context).pop();
                          addedToFavoriteDialog();
                        },
                        child: Text(
                          _isFavorite == true
                              ? 'Remove from Favorite'
                              : 'Add to Favorite',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 15),
                      child: Icon(
                        Icons.file_upload,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 15),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Share',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
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
        ));
  }
}
