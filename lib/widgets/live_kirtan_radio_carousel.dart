import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Radio {
  final int id;
  final String title;
  final String author = null;
  final int shabadId = null;
  final int page = null;
  final int isRadio = 1;
  final String img;
  final String src;

  Radio(this.id, this.title, this.img, this.src);
}

class LiveKirtanRadioCarousel extends StatefulWidget {
  final Function showOverlay;
  final Function showOverlayTrue;
  final Function showOverlayFalse;
  final bool show;
  final Function play;
  final Function tapPause;
  final Function tapPlay;
  final Function tapStop;
  bool isPlaying;
  final audioPlayer;

  LiveKirtanRadioCarousel(
      this.showOverlay,
      this.showOverlayTrue,
      this.showOverlayFalse,
      this.show,
      this.play,
      this.tapPause,
      this.tapPlay,
      this.tapStop,
      this.isPlaying,
      this.audioPlayer);

  @override
  _LiveKirtanRadioCarouselState createState() =>
      _LiveKirtanRadioCarouselState();
}

class _LiveKirtanRadioCarouselState extends State<LiveKirtanRadioCarousel> {
  void initState() {
    _getRadio();
  }

  Future<List<Radio>> _getRadio() async {
    var data = await http
        .get('https://api.khojgurbani.org/api/v1/android/android-radio');
    var jsonData = json.decode(data.body)['data'];

    List<Radio> radioList = [];

    for (var r in jsonData) {
      Radio radio = Radio(r["id"], r["title"], r["img"], r["src"]);
      radioList.add(radio);
    }
    return radioList;
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.0694),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Live Kirtan Radio',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: maxWidth * 0.0694),
          height: maxHeight * 0.175,
          child: FutureBuilder(
            future: _getRadio(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Destination destination = destinations[index];
                      return GestureDetector(
                        onTap: () {
                          this.widget.showOverlay(
                              context,
                              snapshot.data[index].title,
                              snapshot.data[index].author,
                              snapshot.data[index].src,
                              snapshot.data[index].img,
                              snapshot.data[index].shabadId,
                              snapshot.data[index].page,
                              snapshot.data[index].id,
                              isRadio: snapshot.data[index].isRadio);
                          this.widget.play(snapshot.data[index].src, context);
                          if (!mounted) return;
                          setState(() {
                            this.widget.showOverlayTrue();
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: maxHeight * 0.0135),
                          width: maxWidth * 0.2916,
                          child: Center(
                            child: Stack(
                              // alignment: Alignment.topCenter,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: maxHeight * 0.0975,
                                      right: maxWidth * 0.055),
                                  child: Center(
                                    child: Text(
                                      snapshot.data[index].title,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    width: maxWidth * 0.2194,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      // tag: 'recently-played1',
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(180.0),
                                        child: Image(
                                          height: maxHeight * 0.1067,
                                          width: maxWidth * 0.2194,
                                          image: NetworkImage(
                                              snapshot.data[index].img),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
        ),
      ],
    );
  }
}
