import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khojgurbani_music/screens/three_dots_on_song.dart';
import 'package:khojgurbani_music/widgets/bottom_navigation_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class SubCategoriesNew {
  final int id;
  final int shabadId;
  final String title;
  final String type;
  final int status;
  final String duration;
  final int featured;
  final int featured_display_order;
  final int priority_status;
  final int priority_order_status;
  final String attachmentName;
  final String image;
  final String author;
  final String author_name_without_bhai;
  final int page;
  final int is_media;
  final int author_id;

  SubCategoriesNew(
    this.id,
    this.shabadId,
    this.title,
    this.type,
    this.status,
    this.duration,
    this.featured,
    this.featured_display_order,
    this.priority_status,
    this.priority_order_status,
    this.attachmentName,
    this.image,
    this.author,
    this.author_name_without_bhai,
    this.page,
    this.is_media,
    this.author_id,
  );
}

class CategoryTracksPage extends StatefulWidget {
  final int id;
  final String name;
  final String api;
  final Function showOverlay;
  final Function showOverlayTrue;
  final Function showOverlayFalse;
  bool show;
  final Function play;
  final Function setListLinks;
  final Function insertRecentlyPlayed;
  final Function setPropertiesForFullScreen;
  final currentSong;

  CategoryTracksPage({
    Key key,
    @required this.id,
    this.name,
    this.api,
    this.showOverlay,
    this.showOverlayTrue,
    this.showOverlayFalse,
    this.show,
    this.play,
    this.setListLinks,
    this.insertRecentlyPlayed,
    this.setPropertiesForFullScreen,
    this.currentSong,
  }) : super(key: key);

  @override
  _CategoryTracksPageState createState() => _CategoryTracksPageState();
}

class _CategoryTracksPageState extends State<CategoryTracksPage> {
  void initState() {
    // _getSubCategorysNew(this.widget.id);
  }
  List<SubCategoriesNew> subCategoriesNew = [];
  List subCategoriesNewP = [];
  List shuffleList = [];

  Future<List<SubCategoriesNew>> _getSubCategorysNew(int id) async {
    var data = await http.get(this.widget.api);
    var jsonData = json.decode(data.body)['result'];
    subCategoriesNew = [];
    subCategoriesNewP = [];

    for (var s in jsonData) {
      SubCategoriesNew subCatNew = SubCategoriesNew(
        s["id"],
        s["shabad_id"],
        s["title"],
        s.containsKey('type') ? s["type"] : '',
        s.containsKey('status') ? s["status"] : '',
        s.containsKey('duration') ? s["duration"] : '',
        s.containsKey('featured') ? s["featured"] : '',
        s.containsKey('featured_display_order') ? s["featured_display_order"] : '',
        s.containsKey('priority_status') ? s["priority_status"] : '',
        s.containsKey('priority_order_status') ? s["priority_order_status"] : '',
        s.containsKey('attachment_name') ? s["attachment_name"] : '',
        s.containsKey('author_image') ? s["author_image"] : '',
        s.containsKey('author_name') ? s["author_name"] : s['title'],
        s.containsKey('autor_name_without_bhai') ? s["autor_name_without_bhai"] : '',
        s.containsKey('page') ? s['page'] : '',
        s.containsKey('is_media') ? s['is_media'] : '',
        s.containsKey('author_id') ? s["author_id"] : '',
      );

      subCategoriesNew.add(subCatNew);
      subCategoriesNewP.add(subCatNew);
    }

    subCategoriesNew.forEach((a) {
      shuffleList.add(a);
    });

    return subCategoriesNew;
  }

  updateCategoryTracks() async {
    if (!mounted) return;
    setState(() {
      _getSubCategorysNew(this.widget.id);
    });
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
          widget.name,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
        leading: Container(
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
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: maxHeight * 0.0229),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: maxWidth * 0.0555, right: maxWidth * 0.0555),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
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
                                    subCategoriesNewP[0].title,
                                    subCategoriesNewP[0].author,
                                    subCategoriesNew[0].attachmentName,
                                    subCategoriesNewP[0].image,
                                    subCategoriesNewP[0].shabadId,
                                    subCategoriesNewP[0].page,
                                    subCategoriesNewP[0].is_media,
                                    subCategoriesNewP[0].author_id,
                                    subCategoriesNewP[0].id,
                                  );
                          this.widget.play(
                              this.widget.show == true
                                  ? this.widget.currentSong.attachmentName
                                  : subCategoriesNewP[0].attachmentName,
                              context,
                              true);
                          List links = [];
                          for (int i = 0; i < subCategoriesNewP.length; i++) {
                            links.add(subCategoriesNewP[i]);
                          }
                          this.widget.setListLinks(links);
                          if (!mounted) return;
                          // setState(() {
                          //   // this.widget.showOverlayTrue();
                          // });
                        },
                        child: Container(
                          height: maxHeight / 17,
                          width: maxWidth / 2.34,
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
                                        style:
                                            TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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
                        width: maxWidth * 0.0277,
                      ),
                      GestureDetector(
                        onTap: () {
                          shuffleList.shuffle();
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
                                      shuffleList[0].title,
                                      shuffleList[0].author,
                                      shuffleList[0].attachmentName,
                                      shuffleList[0].image,
                                      shuffleList[0].shabadId,
                                      shuffleList[0].page,
                                      shuffleList[0].is_media,
                                      shuffleList[0].author_id,
                                      shuffleList[0].id,
                                    );
                            this.widget.play(
                                this.widget.show == true
                                    ? this.widget.currentSong.attachmentName
                                    : shuffleList[0].attachmentName,
                                context,
                                true);
                            List links = [];
                            for (int i = 0; i < shuffleList.length; i++) {
                              links.add(shuffleList[i]);
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
                                        style: TextStyle(
                                            color: Color(0xff578ed3), fontSize: 16, fontWeight: FontWeight.bold),
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
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: maxWidth * 0.05555, top: maxHeight * 0.0135),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Tracks',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: maxWidth * 0.0555, top: maxHeight * 0.0162),
              //height: maxHeight * 0.6905,
              child: FutureBuilder(
                future: _getSubCategorysNew(widget.id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(bottom: maxHeight * 0.027),
                              child: Stack(
                                children: <Widget>[
                                  // Positioned(
                                  //   left: maxWidth * 0.166,
                                  //   child: Container(
                                  //     width: maxWidth * 0.5555,
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.transparent,
                                  //       borderRadius: BorderRadius.circular(10.0),
                                  //     ),
                                  //     child: Padding(
                                  //       padding: EdgeInsets.only(
                                  //           top: maxHeight * 0.0202),
                                  //       child: Column(
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.start,
                                  //         children: <Widget>[],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  Container(
                                    // decoration: BoxDecoration(
                                    //   color: Colors.white,
                                    //   borderRadius: BorderRadius.circular(20.0),
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
                                        this.widget.insertRecentlyPlayed(snapshot.data[index].id);
                                      },
                                      child: Stack(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: maxHeight * 0.014,
                                              left: maxWidth * 0.159,
                                            ),
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(maxWidth: maxWidth * 0.594444),
                                              child: Text(
                                                snapshot.data[index].author,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(6.0),
                                              child: Image(
                                                height: maxHeight * 0.0621,
                                                width: maxWidth * 0.1305,
                                                image: NetworkImage(snapshot.data[index].image),
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
                                                top: maxHeight * 0.0087,
                                              ),
                                              child: Text(
                                                snapshot.data[index].duration,
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: maxHeight * 0.00475),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(PageRouteBuilder(
                                                    opaque: false,
                                                    pageBuilder:
                                                        (BuildContext context, animation, secondaryAnimation) =>
                                                            SongOptions(
                                                      indexOfSong: snapshot.data[index].id,
                                                      indexOfArtist: snapshot.data[index].author_id,
                                                      artistName: snapshot.data[index].author,
                                                      title: snapshot.data[index].title,
                                                      attachmentName: snapshot.data[index].attachmentName,
                                                      id: snapshot.data[index].id,
                                                      author_id: snapshot.data[index].author_id,
                                                      image: snapshot.data[index].image,
                                                      showOverlay: this.widget.showOverlay,
                                                      showOverlayTrue: this.widget.showOverlayTrue,
                                                      showOverlayFalse: this.widget.showOverlayFalse,
                                                      show: this.widget.show,
                                                      play: this.widget.play,
                                                      setListLinks: this.widget.setListLinks,
                                                      insertRecentlyPlayed: this.widget.insertRecentlyPlayed,
                                                      setPropertiesForFullScreen:
                                                          this.widget.setPropertiesForFullScreen,
                                                      fromArtistPage: fromArtistPage,
                                                    ),
                                                    // transitionDuration:
                                                    //     Duration(seconds: 1),
                                                    transitionsBuilder: (ontext, animation, secondaryAnimation, child) {
                                                      var begin = Offset(0.0, -1.0);
                                                      var end =
                                                          this.widget.show == true ? Offset(0.0, -0.08) : Offset.zero;
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
                                                    color: Color(0xff727272),
                                                    size: 20,
                                                  ),
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
          ),
        ],
      ),
    );
  }
}
