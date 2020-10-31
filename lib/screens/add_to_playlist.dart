import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:khojgurbani_music/models/libraryPlaylists.dart';

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class AddToPlaylist extends StatefulWidget {
  final int media_id;
  final int podcast_id;

  const AddToPlaylist({Key key, this.media_id, this.podcast_id}) : super(key: key);

  @override
  _AddToPlaylistState createState() => _AddToPlaylistState();
}

class _AddToPlaylistState extends State<AddToPlaylist> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlaylists();
  }

  var playlists;

  getPlaylists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final token = prefs.getString('token');
    final machineId = prefs.getString('machine_id');

    // this.playlistCard();

    // final headers = {'Authorization': "Bearer " + token};
    final response = await http.get(
      'https://api.khojgurbani.org/api/v1/android/user-playlist?user_id=$userId&machine_id=$machineId',
      // headers: headers
    );
    var jsonData = json.decode(response.body);
    Playlists results = new Playlists.fromJson(jsonData);

    setState(() {
      playlists = results.playlist;
    });

    return results;
  }

  updateParentGetPlaylists() async {
    setState(() {
      getPlaylists();
    });
  }

  var data;
  createPlaylist(String playlist_name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int userId = prefs.getInt('user_id');
    final String token = prefs.getString('token');
    final String machineId = prefs.getString('machine_id');
    var body = {
      'user_id': json.encode(userId),
      'playlist_name': playlist_name,
      'machine_id': machineId,
    };
    print(body);

    final res = await http.post('https://api.khojgurbani.org/api/v1/android/create-playlist', body: body);

    var response = json.decode(res.body);
    setState(() {
      // this.data = response.response.playlist_id;
      this.data = response['response']['playlist_id'];
    });
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
                  createPlaylist(_title.text)
                      .then((value) => addSongToPlaylist(this.widget.media_id, data, this.widget.podcast_id));
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

  addSongToPlaylist(int media_id, int playlist_id, int podcast_id) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String token = prefs.getString('token');
    // final String machineId = prefs.getString('machine_id');

    final res = await http.post(
      'https://api.khojgurbani.org/api/v1/android/action-track-playlist',
      body: {
        'media_id': json.encode(this.widget.media_id),
        'playlist_id': json.encode(playlist_id),
        'podcast_id': json.encode(this.widget.podcast_id)
      },
      // headers: {
      //   'Authorization': "Bearer " + token,
      // }
    ).then((value) => Navigator.of(context).pop());

    // final data = jsonDecode(res.body);
    Navigator.of(context).pop();

    if (!mounted) return;
    updateParentGetPlaylists();
  }

  addedToPlaylist() {
    showDialog(
        context: context,
        builder: (dialogContext) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop(context);
          });
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            title: Center(
              child: Text(
                'Added to Playlist',
                style: TextStyle(fontSize: 14),
              ),
            ),
          );
        });
  }

  playlistCard(playlist_name, int playlist_id, cnt_playlist_media, image) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        addSongToPlaylist(this.widget.media_id, playlist_id, this.widget.podcast_id);
        addedToPlaylist();
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
                borderRadius: BorderRadius.circular(6),
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
                                  style: TextStyle(fontSize: 14, color: Colors.white),
                                ),
                              ),
                              Container(
                                width: maxWidth * 0.5555,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  cnt_playlist_media.toString() + ' songs',
                                  style: TextStyle(
                                    color: Colors.grey[400],
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

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    return Material(
      color: Color(0xff578ed3),
      //color: Colors.white.withOpacity(0.1),
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: new Color(0xff578ed3), //.withOpacity(0.85),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.4, sigmaY: 1.4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 85,
                    ),
                    Text(
                      "Add to Playlist",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 300,
                      height: maxHeight * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white)),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            createPlaylistDialog(context);
                          },
                          child: Center(
                            child: Text(
                              "New Playlist",
                              style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Cabin'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
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
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
