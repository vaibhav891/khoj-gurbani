import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:khojgurbani_music/screens/music_player_full_size.dart';

class PlayerTextFild extends StatefulWidget {
  final String description;
  final bool isGurmukhi;
  final bool isEnglish;
  final bool isLarevaar;
  final int val;
  final int shabadId;
  final int page;

  PlayerTextFild(
      this.description, this.isGurmukhi, this.isEnglish, this.isLarevaar, this.val, this.shabadId, this.page);

  @override
  _PlayerTextFildState createState() => _PlayerTextFildState();
}

class _PlayerTextFildState extends State<PlayerTextFild> {
  Future getTextFildtLyrics(shabadId, page) async {
    final response = await http.get('https://apiprod.khojgurbani.org/api/v1/shabad/$page/$shabadId');
    var data = json.decode(response.body);
    Lyrcis _lyrcis = new Lyrcis.fromJson(data);
    return _lyrcis;
  }

  @override
  void initState() {
    super.initState();
  }

// Future getLyrics(shabadId) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final userId = prefs.getInt('user_id');
//     final token = prefs.getString('token');

//     final headers = {'Authorization': "Bearer " + token};
//     final response = await http.get(
//         'https://apiprod.khojgurbani.org/api/v1/shabad/$shabadId',
//         headers: headers);
//     var data = json.decode(response.body);
//     Lyrcis lyrics = new Lyrcis.fromJson(data);
//     return lyrics;
//   }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Material(
      child: SafeArea(
        child: Container(
          color: Colors.white,
          //height: 630,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: maxWidth * 0.0555,
                    right: maxWidth * 0.0555,
                    top: maxHeight * 0.03,
                  ),
                  child: Container(
                    //height: 630,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.red,
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            this.widget.description != null
                                ? Text(
                                    this.widget.description,
                                    textAlign: TextAlign.center,
                                  )
                                : Container(),
                            FutureBuilder(
                                future: getTextFildtLyrics(this.widget.shabadId, this.widget.page),
                                builder: (BuildContext context, AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done) {
                                    if (snapshot.hasData) {
                                      return Container(
                                        height: maxHeight * 0.8,
                                        child: ListView.builder(
                                            padding: EdgeInsets.only(
                                              top: maxHeight * 0.00,
                                            ),
                                            scrollDirection: Axis.vertical,
                                            itemCount: snapshot.data.data.scriptures.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return Padding(
                                                padding: EdgeInsets.only(bottom: maxHeight * 0.015),
                                                child: Column(
                                                  children: <Widget>[
                                                    this.widget.isGurmukhi == true
                                                        ? Text(
                                                            (() {
                                                              if (this.widget.isGurmukhi == true) {
                                                                return snapshot.data.data.scriptures[index].scripture !=
                                                                        null
                                                                    ? snapshot.data.data.scriptures[index].scripture
                                                                    : 'No translation';
                                                              } else {
                                                                print("error");
                                                              }
                                                            })(),
                                                            style: TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 24,
                                                                fontWeight: FontWeight.bold),
                                                            textAlign: TextAlign.center,
                                                          )
                                                        : Container(),
                                                    this.widget.isEnglish == true
                                                        ? Text(
                                                            (() {
                                                              if (this.widget.isEnglish == true) {
                                                                return snapshot.data.data.scriptures[index]
                                                                            .scriptureRoman !=
                                                                        null
                                                                    ? snapshot
                                                                        .data.data.scriptures[index].scriptureRoman
                                                                    : 'No translation';
                                                              } else {
                                                                print("error");
                                                              }
                                                            })(),
                                                            style: TextStyle(color: Colors.black, fontSize: 17),
                                                            textAlign: TextAlign.center,
                                                          )
                                                        : Container(),
                                                    this.widget.isLarevaar == true
                                                        ? Text(
                                                            (() {
                                                              if (this.widget.isLarevaar == true) {
                                                                return snapshot.data.data.scriptures[index]
                                                                            .scriptureOriginal !=
                                                                        null
                                                                    ? snapshot
                                                                        .data.data.scriptures[index].scriptureOriginal
                                                                    : 'No translation';
                                                              } else {
                                                                print("error");
                                                              }
                                                            })(),
                                                            style: TextStyle(color: Colors.black, fontSize: 15),
                                                            textAlign: TextAlign.center,
                                                          )
                                                        : Container(),
                                                    Text(
                                                      (() {
                                                        if (this.widget.val == 0) {
                                                          return snapshot.data.data.scriptures[index].translation
                                                                      .santSinghKhalsaEnglish !=
                                                                  null
                                                              ? snapshot.data.data.scriptures[index].translation
                                                                  .santSinghKhalsaEnglish
                                                              : 'No translation';
                                                        } else if (this.widget.val == 1) {
                                                          return snapshot.data.data.scriptures[index].translation
                                                                      .manmohanSinghEnglish !=
                                                                  null
                                                              ? snapshot.data.data.scriptures[index].translation
                                                                  .manmohanSinghEnglish
                                                              : 'No translation';
                                                        } else if (this.widget.val == 2) {
                                                          return snapshot.data.data.scriptures[index].translation
                                                                      .sahibSinghPunjabi !=
                                                                  null
                                                              ? snapshot.data.data.scriptures[index].translation
                                                                  .sahibSinghPunjabi
                                                              : 'No translation';
                                                        } else if (this.widget.val == 3) {
                                                          return snapshot.data.data.scriptures[index].translation
                                                                      .harbansSinghPunjabi !=
                                                                  null
                                                              ? snapshot.data.data.scriptures[index].translation
                                                                  .harbansSinghPunjabi
                                                              : 'No translation';
                                                        } else if (this.widget.val == 4) {
                                                          return snapshot.data.data.scriptures[index].translation
                                                                      .manmohanSinghPunjabi !=
                                                                  null
                                                              ? snapshot.data.data.scriptures[index].translation
                                                                  .manmohanSinghPunjabi
                                                              : 'No translation';
                                                        } else if (this.widget.val == 5) {
                                                          return "";
                                                        } else {
                                                          print("error");
                                                        }
                                                      })(),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                      );
                                    } else {
                                      return Container(
                                        height: maxHeight * 0.3378,
                                      );
                                    }
                                  } else {
                                    return Container(
                                      height: 630,
                                      child: Center(child: CircularProgressIndicator()),
                                    );
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: maxHeight / 50),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 20,
                    width: maxWidth * 0.138888,
                    child: Center(
                      child: Text(
                        "Close",
                        style: TextStyle(color: Color(0xff578ed3), fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
