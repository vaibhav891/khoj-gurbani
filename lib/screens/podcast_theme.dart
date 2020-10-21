import 'package:flutter/material.dart';
import 'package:khojgurbani_music/models/podcastTheme.dart';
import 'package:khojgurbani_music/widgets/bottom_navigation_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/podcast_theme_card.dart';

// class PodcastTheme {
//   int id;
//   String title;
//   String description;
//   String type;
//   int status;
//   String duration;
//   int featured;
//   int featured_display_order;
//   int priority_status;
//   int priority_order_status;
//   String attachmentName;
//   String thumbnail;
//   String created_at;
//   int user_podcast_id;

//   PodcastTheme(
//       this.id,
//       this.title,
//       this.description,
//       this.type,
//       this.status,
//       this.duration,
//       this.featured,
//       this.featured_display_order,
//       this.priority_status,
//       this.priority_order_status,
//       this.attachmentName,
//       this.thumbnail,
//       this.created_at,
//       this.user_podcast_id);
// }

class PodcastThemePage extends StatefulWidget {
  final Function showOverlay;
  final Function showOverlayTrue;
  final Function showOverlayFalse;
  final bool show;
  final Function play;
  final Function setListLinks;
  final Function tapPause;
  final Function tapPlay;
  final Function tapStop;
  final Function setIsOpenFullScreen;
  bool isPlaying;
  final audioPlayer;
  final id;

  PodcastThemePage({
    Key key,
    this.showOverlay,
    this.showOverlayTrue,
    this.showOverlayFalse,
    this.show,
    this.play,
    this.setListLinks,
    this.tapPause,
    this.tapPlay,
    this.tapStop,
    this.setIsOpenFullScreen,
    this.isPlaying,
    this.audioPlayer,
    this.id,
  }) : super(key: key);
  @override
  _PodcastThemePageState createState() => _PodcastThemePageState();
}

class _PodcastThemePageState extends State<PodcastThemePage> {
  void initState() {
    super.initState();
    getAllPodcastThemes(this.widget.id);
  }

  bool isSort = false;

  PodcastThemeAll allPodcastsThemes;

  getAllPodcastThemes(int id) async {
    var data = await http.get('https://api.khojgurbani.org/api/v1/media/resource-category-podmedia-new/$id');
    var jsonData = json.decode(data.body);

    setState(() {
      allPodcastsThemes = PodcastThemeAll.fromJson(jsonData);
    });

    return PodcastThemeAll.fromJson(jsonData);
  }

  updatePodcastThemes() {
    setState(() {
      getAllPodcastThemes(this.widget.id);
    });
  }

  resetSelectedProp() {
    this.allPodcastsThemes.result.forEach((element) {
      element.isSelected = false;
    });
  }

  bool sort = true;

  updateSortOldest() {
    sort = true;
  }
  // updateSortNewest() {
  //   sort = true;
  // }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffF5F5F5),
        title: Text(
          'Podcast Theme',
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
                              height: maxHeight * 0.375675,
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
                                        padding: EdgeInsets.only(left: maxWidth * 0.0555, top: maxHeight * 0.035135),
                                        child: Text(
                                          'Sort By',
                                          style:
                                              TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: maxHeight * 0.0581,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: maxWidth * 0.0555),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              // allPodcastThemes = allPodcastThemes.toList();
                                              allPodcastsThemes.result
                                                  .sort((a, b) => b.createdAt.compareTo(a.createdAt));
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
                                              // allPodcastThemes = allPodcastThemes.toList();
                                              allPodcastsThemes.result
                                                  .sort((a, b) => a.createdAt.compareTo(b.createdAt));
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
              itemCount: allPodcastsThemes?.result?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: maxHeight * 0.02567),
                  child: PodcastThemeCard(
                    id: allPodcastsThemes.result[index].id,
                    title: allPodcastsThemes.result[index].title,
                    author: null,
                    shabadId: null,
                    duration: allPodcastsThemes.result[index].duration,
                    thumbnail: allPodcastsThemes.result[index].thumbnail,
                    attachmentName: allPodcastsThemes.result[index].attachmentName,
                    created_at: allPodcastsThemes.result[index].createdAt,
                    description: allPodcastsThemes.result[index].description,
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
                    allPodcasts: allPodcastsThemes.result[index],
                    resetSelectedProp: resetSelectedProp,
                    indexOfPodcast: allPodcastsThemes.result[index].id,
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
