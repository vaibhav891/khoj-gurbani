import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class RecentlyPlayed {
  final int id;
  final int shabadId;
  final String title;
  final String author;
  final String type;
  final String duration;
  final String attachmentName;
  final String image;
  final int page;
  final int is_media;
  final int author_id;
  final int favourite;

  RecentlyPlayed(
    this.id,
    this.shabadId,
    this.title,
    this.author,
    this.type,
    this.duration,
    this.attachmentName,
    this.image,
    this.page,
    this.is_media,
    this.author_id,
    this.favourite,
  );
}

class RecentlyPlayedCarousel extends StatefulWidget {
  final Function showOverlay;
  final Function showOverlayTrue;
  final Function showOverlayFalse;
  bool show;
  final Function play;
  final Function setListLinks;
  final currentSong;

  RecentlyPlayedCarousel(
    this.showOverlay,
    this.showOverlayTrue,
    this.showOverlayFalse,
    this.show,
    this.play,
    this.setListLinks,
    this.currentSong,
  );

  @override
  _RecentlyPlayedCarouselState createState() => _RecentlyPlayedCarouselState();
}

class _RecentlyPlayedCarouselState extends State<RecentlyPlayedCarousel> {
  Future<List<RecentlyPlayed>> _getRecentlyPlayed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final token = prefs.getString('token');
    final machineId = prefs.getString('machine_id');

    // final headers = {'Authorization': "Bearer " + token};
    var data = await http.get(
      'https://api.khojgurbani.org/api/v1/android/home?user_id=$userId&machine_id=$machineId',
      // headers: headers
    );
    var jsonData = json.decode(data.body)['result']['recently_played'];

    List<RecentlyPlayed> recents = [];

    for (var r in jsonData) {
      RecentlyPlayed recent = RecentlyPlayed(
        r["id"],
        r["shabad_id"],
        r["title"],
        r["author"],
        r["type"],
        r["duration"],
        r["attachment_name"],
        r["image"],
        r["page"],
        r["is_media"],
        r["author_id"],
        r["favourite"],
      );
      recents.add(recent);
    }
    return recents;
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: _getRecentlyPlayed(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: maxWidth * 0.0555, bottom: maxHeight / 80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Recently played',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: maxWidth * 0.0555),
                    // height: maxHeight * 0.211,
                    height: maxHeight * 0.22008,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length == null ? 0 : snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(top: maxHeight * 0.005),
                          width: maxWidth * 0.357,
                          child: GestureDetector(
                            onTap: () {},
                            child: GestureDetector(
                              onTap: () {
                                this.widget.showOverlay(
                                      context,
                                      snapshot.data[index].title,
                                      snapshot.data[index].author,
                                      snapshot.data[index].attachmentName,
                                      snapshot.data[index].image,
                                      snapshot.data[index].shabadId,
                                      snapshot.data[index].page,
                                      snapshot.data[index].id,
                                      is_media: snapshot.data[index].is_media,
                                      author_id: snapshot.data[index].author_id,
                                    );
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
                                // alignment: Alignment.topCenter,
                                children: <Widget>[
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      height: maxHeight * 0.0411,
                                      width: maxWidth * 0.329,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Container(
                                        // height: 65.0,
                                        width: maxWidth * 0.378,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              snapshot.data[index].title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: //GoogleFonts.poppins(fontSize: 12, color: Colors.black),
                                                  TextStyle(fontSize: 14.0, color: Colors.black
                                                      // fontWeight: FontWeight.normal,
                                                      // fontFamily: 'Cabin'
                                                      ),
                                            ),
                                            SizedBox(height: maxHeight * 0.001),
                                            Text(
                                              snapshot.data[index].author,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  // GoogleFonts.poppins(
                                                  //   fontSize: 11,
                                                  // )
                                                  TextStyle(
                                                fontSize: 12.0,
                                                // fontWeight: FontWeight.normal,
                                                // color: Colors.grey[800],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          // tag: 'recently-played1',
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(6.0),
                                            child: Image(
                                              height: maxHeight * 0.160,
                                              width: maxWidth * 0.329,
                                              image: NetworkImage(snapshot.data[index].image),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Container());
            }
          } else {
            return Center(
              child: Container(
                height: maxHeight * 0.20270,
              ),
            );
          }
        });
  }
}
