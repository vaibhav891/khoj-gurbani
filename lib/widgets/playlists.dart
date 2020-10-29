import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:khojgurbani_music/screens/playlist_full.dart';
import 'package:khojgurbani_music/models/libraryPlaylists.dart';

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PlayListWidget extends StatefulWidget {
  final Function showOverlay;
  final Function showOverlayTrue;
  final Function showOverlayFalse;
  bool show;
  final Function play;
  final Function setListLinks;
  final Function setPropertiesForFullScreen;
  final Function insertRecentlyPlayed;
  final currentSong;

  PlayListWidget({
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
  _PlayListWidgetState createState() => _PlayListWidgetState();
}

class _PlayListWidgetState extends State<PlayListWidget> {
  void initState() {
    super.initState();
    getPlaylists();
  }

  createPlaylist(String playlist_name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int userId = prefs.getInt('user_id');
    final String token = prefs.getString('token');
    final machineId = prefs.getString('machine_id');

    final res = await http.post(
      'https://api.khojgurbani.org/api/v1/android/create-playlist',
      body: {'user_id': json.encode(userId), 'playlist_name': playlist_name, 'machine_id': machineId},
      // headers: {
      //   'Authorization': "Bearer " + token,
      // }
    );

    final data = jsonDecode(res.body);

    this.getPlaylists();
  }

  var playlists;

  getPlaylists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final token = prefs.getString('token');
    final machineId = prefs.getString('machine_id');
    final url = 'https://api.khojgurbani.org/api/v1/android/user-playlist?user_id=$userId&machine_id=$machineId';

    print('Url -> $url');
    // this.playlistCard();

    // final headers = {'Authorization': "Bearer " + token};
    final response = await http.get(url);
    var jsonData = json.decode(response.body);

    Playlists results = new Playlists.fromJson(jsonData);
    if (!mounted) return;
    setState(() {
      playlists = results.playlist;
    });
    return results;
  }

  playlistCard(
    playlist_name,
    playlist_id,
    cnt_playlist_media,
    image,
    showOverlay,
    showOverlayTrue,
    showOverlayFalse,
    show,
    play,
    setListLinks,
    currentSong,
  ) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => PlaylistFull(
                    playlist_id: playlist_id,
                    playlist_name: playlist_name,
                    showOverlay: this.widget.showOverlay,
                    showOverlayTrue: this.widget.showOverlayTrue,
                    showOverlayFalse: this.widget.showOverlayFalse,
                    show: this.widget.show,
                    play: this.widget.play,
                    setListLinks: this.widget.setListLinks,
                    getPlaylists: getPlaylists,
                    cnt_playlist_media: cnt_playlist_media,
                    setPropertiesForFullScreen: this.widget.setPropertiesForFullScreen,
                    insertRecentlyPlayed: this.widget.insertRecentlyPlayed,
                    currentSong: this.widget.currentSong))).then((value) {
          setState(() {
            getPlaylists();
          });
        });
      },
      child: Padding(
        padding: EdgeInsets.only(left: maxWidth * 0.05277, bottom: maxHeight * 0.02229),
        child: Row(
          children: <Widget>[
            Container(
              height: maxHeight * 0.0635,
              width: maxWidth * 0.1305,
              decoration: BoxDecoration(
                color: Color(0xffFAFAFA),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff578ed329),
                    offset: Offset(0.0, 3.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Image(
                        height: maxHeight * 0.0635,
                        width: maxWidth * 0.1306,
                        image: NetworkImage('https://api.khojgurbani.org/uploads/author/' + image),
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(
                      Icons.queue_music,
                      color: Color(0xff578ed3),
                    ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: maxWidth * 0.044444),
                        child: Container(
                          alignment: Alignment(-1, 0),
                          height: maxHeight * 0.0635,
                          // width: 320,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: maxWidth * 0.5555,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  playlist_name,
                                  maxLines: 1,
                                  // textAlign: TextAlign.left,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(fontSize: 14, color: Colors.black),
                                ),
                              ),
                              Container(
                                width: maxWidth * 0.5555,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  cnt_playlist_media.toString() + ' songs',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              //   }
                              //   return Center(
                              //       child: CircularProgressIndicator());
                              // },
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  createPlaylistDialog(BuildContext context) {
    TextEditingController _title = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text('New Playlist'),
            content: TextField(
              controller: _title,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5,
                onPressed: () {
                  createPlaylist(_title.text);
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Submit",
                  style: TextStyle(color: Color(0xff578ed3)),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: maxWidth * 0.0527, top: maxHeight * 0.02229, bottom: maxHeight * 0.02229),
            child: GestureDetector(
              onTap: () {
                createPlaylistDialog(context);
              },
              child: Row(
                children: <Widget>[
                  Container(
                    height: maxHeight * 0.0635,
                    width: maxWidth * 0.1305,
                    decoration: BoxDecoration(
                      color: Color(0xffFAFAFA),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff578ed329),
                          offset: Offset(0.0, 3.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.add,
                      color: Color(0xff578ed3),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: maxWidth * 0.0444),
                              child: Container(
                                alignment: Alignment(-1, 0),
                                height: maxHeight * 0.0635,
                                // width: 320,
                                child: Text(
                                  'New playlist',
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(fontSize: 14, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 300,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: playlists?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return playlistCard(
                        playlists[index].playlistName,
                        playlists[index].playlistId,
                        playlists[index].cntPlaylistMedia,
                        playlists[index].authorImage[0].image,
                        this.widget.showOverlay,
                        this.widget.showOverlayTrue,
                        this.widget.showOverlayFalse,
                        this.widget.show,
                        this.widget.play,
                        this.widget.setListLinks,
                        this.widget.currentSong);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
