import 'package:flutter/material.dart';
import 'package:khojgurbani_music/widgets/bottom_navigation_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:khojgurbani_music/models/allPodcasts.dart';

import '../widgets/podcast_theme_card.dart';

class FeaturedPodcasts extends StatefulWidget {
  final Function onSortButtonPressed;
  final Function showOverlay;
  final Function showOverlayTrue;
  final Function showOverlayFalse;
  bool show;
  final Function play;
  final Function tapPause;
  final Function tapPlay;
  final Function tapStop;
  final Function setIsOpenFullScreen;
  bool isPlaying;
  final audioPlayer;

  FeaturedPodcasts(
      {Key key,
      this.onSortButtonPressed,
      this.showOverlay,
      this.showOverlayTrue,
      this.showOverlayFalse,
      this.show,
      this.play,
      this.tapPause,
      this.tapPlay,
      this.tapStop,
      this.setIsOpenFullScreen,
      this.isPlaying,
      this.audioPlayer})
      : super(key: key);
  @override
  _FeaturedPodcastsState createState() => _FeaturedPodcastsState();
}

class _FeaturedPodcastsState extends State<FeaturedPodcasts> {
  void initState() {
    super.initState();
    getAllPodcasts();
  }

  bool isSort = false;

  // var allPodcasts;
  AllPodcasts allPodcasts;

  getAllPodcasts() async {
    // if (!isSort) {
    var data = await http.get('https://api.khojgurbani.org/api/v1/android/all-podcasts');
    var jsonData = json.decode(data.body);

    // AllPodcasts allPodcasts = new AllPodcasts.fromJson(jsonData);

    setState(() {
      allPodcasts = AllPodcasts.fromJson(jsonData);
    });
    // } else {
    //   isSort = false;
    // }
    return AllPodcasts.fromJson(jsonData);
  }

  updateAllFeaturedPodcasts() {
    setState(() {
      getAllPodcasts();
    });
  }

  bool sort = true;

  updateSortOldest() {
    sort = true;
  }

  bool isPressed = false;

  setIsPressed() {
    isPressed = !isPressed;
  }

  resetSelectedProp() {
    this.allPodcasts.result.forEach((element) {
      element.isSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffF5F5F5),
        title: Text(
          'Featured Podcasts',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        leading: Container(
          // alignment: AxisDirection.left,
          // padding: EdgeInsets.only(right: 90),
          child: IconButton(
            color: Colors.black,
            iconSize: 30,
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(context);
            },
            icon: Icon(
              Icons.chevron_left,
            ),
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(),
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: maxHeight * 0.01756, left: maxWidth * 0.0555),
                child: Text(
                  'All Episodes',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: maxWidth * 0.3888, top: maxHeight * 0.02027, right: maxWidth * 0.0555),
                child: Container(
                  height: maxHeight * 0.03378,
                  width: maxWidth * 0.18888,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    color: Colors.white,
                    onPressed: () => showModalBottomSheet(
                        barrierColor: Colors.white.withOpacity(0),
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder: (BuildContext context, StateSetter setCheck) {
                            return Container(
                              height: maxHeight * 0.3756,
                              decoration: BoxDecoration(
                                color: new Color(0xff578ed3).withOpacity(0.80),
                                border: new Border.all(width: 1, color: Colors.transparent),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: maxWidth * 0.05555, top: maxHeight * 0.0351),
                                        child: Text(
                                          'Sort By',
                                          style:
                                              TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: maxHeight * 0.058,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: maxWidth * 0.055555),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              // allPodcastThemes = allPodcastThemes.toList();
                                              allPodcasts.result.sort(
                                                  (a, b) => b.createdAt.toString().compareTo(a.createdAt.toString()));
                                              isSort = true;
                                            });
                                            setCheck(() {
                                              sort = true;
                                            });
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                'Newest to Oldest',
                                                style: TextStyle(fontSize: 16, color: Colors.white),
                                              ),
                                              SizedBox(width: maxWidth * 0.505),
                                              sort == true
                                                  ? Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: maxHeight * 0.05,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: maxWidth * 0.0555),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              allPodcasts.result.sort(
                                                  (a, b) => a.createdAt.toString().compareTo(b.createdAt.toString()));
                                              isSort = true;
                                            });
                                            setCheck(() {
                                              sort = false;
                                            });
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                'Oldest to Newest',
                                                style: TextStyle(fontSize: 16, color: Colors.white),
                                              ),
                                              SizedBox(
                                                width: maxWidth * 0.505,
                                              ),
                                              sort == false
                                                  ? Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: maxHeight * 0.0743,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          height: maxHeight * 0.0675,
                                          width: maxWidth * 0.138888,
                                          child: Center(
                                            child: Text(
                                              "Close",
                                              style: TextStyle(color: Colors.white, fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          });
                        }),
                    child: Text(
                      'Sort',
                      style: TextStyle(color: Color(0xff578ed3), fontSize: 10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: maxHeight * 0.02702),
            height: maxHeight * 0.75,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: allPodcasts?.result?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: maxHeight * 0.02567),
                  child: PodcastThemeCard(
                    id: allPodcasts.result[index].id,
                    title: allPodcasts.result[index].title,
                    author: null,
                    shabadId: null,
                    duration: allPodcasts.result[index].duration,
                    thumbnail: allPodcasts.result[index].thumbnail,
                    attachmentName: allPodcasts.result[index].media,
                    description: allPodcasts.result[index].description,
                    created_at: allPodcasts.result[index].createdAt,
                    showOverlay: this.widget.showOverlay,
                    showOverlayTrue: this.widget.showOverlayTrue,
                    showOverlayFalse: this.widget.showOverlayFalse,
                    show: this.widget.show,
                    play: this.widget.play,
                    tapPause: this.widget.tapPause,
                    tapPlay: this.widget.tapPlay,
                    tapStop: this.widget.tapStop,
                    setIsOpenFullScreen: this.widget.setIsOpenFullScreen,
                    isPlaying: this.widget.isPlaying,
                    audioPlayer: this.widget.audioPlayer,
                    allPodcasts: allPodcasts.result[index],
                    resetSelectedProp: this.resetSelectedProp,
                    indexOfPodcast: allPodcasts.result[index].id,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
