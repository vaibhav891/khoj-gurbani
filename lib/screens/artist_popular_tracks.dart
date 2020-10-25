import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khojgurbani_music/screens/three_dots_on_song.dart';
import 'package:khojgurbani_music/services/services.dart';
import '../service_locator.dart';

import 'dart:async';

import 'package:khojgurbani_music/widgets/bottom_navigation_bar.dart';

// class AllArtistSongs {
//   int id;
//   int shabadId;
//   String title;
//   String author;
//   String duration;
//   String author_name;
//   String authorDescription;
//   String attachmentName;
//   String image;
//   // ShabadDetail shabadDetail;
//   int favourite;

//   AllArtistSongs(
//       this.id,
//       this.shabadId,
//       this.title,
//       this.author,
//       this.duration,
//       this.author_name,
//       this.authorDescription,
//       this.attachmentName,
//       this.image,
//       // this.shabadDetail,
//       this.favourite,);
// }

class ArtistPopularTracks extends StatefulWidget {
  final id;
  final Function showOverlay;
  final Function showOverlayTrue;
  final Function showOverlayFalse;
  bool show;
  final Function play;
  final Function setListLinks;
  final Function insertRecentlyPlayed;
  final Function tapPause;
  final Function tapPlay;
  final Function tapStop;
  final Function setIsOpenFullScreen;
  bool isPlaying;
  final audioPlayer;
  final snapshot;
  final Function getLyrics;
  final Function setPropertiesForFullScreen;
  final currentSong;

  ArtistPopularTracks({
    Key key,
    @required this.id,
    this.showOverlay,
    this.showOverlayTrue,
    this.showOverlayFalse,
    this.show,
    this.play,
    this.setListLinks,
    this.insertRecentlyPlayed,
    this.isPlaying,
    this.tapPause,
    this.tapPlay,
    this.tapStop,
    this.setIsOpenFullScreen,
    this.audioPlayer,
    this.snapshot,
    this.getLyrics,
    this.setPropertiesForFullScreen,
    this.currentSong,
  }) : super(key: key);
  @override
  _ArtistPopularTracksState createState() => _ArtistPopularTracksState();
}

class _ArtistPopularTracksState extends State<ArtistPopularTracks> {
  var service = getIt<Services>();
  var oneArtist;
  var shuffleListOneArtist;

  // three dots da zna da je na artist pejdzu
  bool fromArtistPage = true;

  void initState() {
    oneArtist = service.oneArtist;
    shuffleListOneArtist = service.shuffleListOneArtist;
    service.getOneArtist(this.widget.id);
    setState(() {
      service.oneArtist = oneArtist;
      service.shuffleListOneArtist = shuffleListOneArtist;
    });
    super.initState();
  }

  TextEditingController controller = new TextEditingController();

  List searchResults = [];

  onSearchTextChanged(String text) {
    searchResults.clear();

    if (text.isEmpty) {
      setState(() {});
      return;
    }
    final textToLowerCase = text.toLowerCase();

    service.oneArtist.forEach((a) {
      if (a.title.toLowerCase().contains(textToLowerCase)) searchResults.add(a);
      // setState(() {});
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffF5F5F5),
        title: Padding(
          padding: EdgeInsets.only(bottom: maxWidth * 0.0277, right: maxWidth * 0.06388),
          child: Container(
            // padding: EdgeInsets.only(bottom: 15),
            height: maxHeight * 0.0418,
            width: maxWidth * 0.8694,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
            child: TextField(
              onSubmitted: (value) {},
              onTap: () {
                setState(() {});
              },
              controller: controller,
              onChanged: onSearchTextChanged,
              style: TextStyle(height: 1.7),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: maxHeight * 0.0175),
                prefixIcon: Icon(
                  Icons.search,
                  size: 20,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 15,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    controller.clear();
                    onSearchTextChanged('');
                  },
                ),
                // suffixIcon: Icon(Icons.cancel),
                hintText: "Search",
                hintStyle: TextStyle(fontSize: 14),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        leading: Container(
          // width: 20,
          // height: 50,
          // alignment: AxisDirection.left,
          // padding: EdgeInsets.only(right: 90),
          child: IconButton(
            color: Colors.black,
            // padding: EdgeInsets.only(bottom: 30),
            iconSize: 30,
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(context);
            },
            padding: EdgeInsets.only(bottom: 10),
            icon: Icon(
              Icons.chevron_left,
            ),
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: maxHeight * 0.0229,
          ),
          Row(
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
                                  this.widget.currentSong.id,
                                  this.widget.currentSong.is_media,
                                  this.widget.currentSong.author_id,
                                )
                            : this.widget.setPropertiesForFullScreen(
                                  context,
                                  service.oneArtist[0].title,
                                  service.oneArtist[0].author,
                                  service.oneArtist[0].attachmentName,
                                  service.oneArtist[0].image,
                                  service.oneArtist[0].shabadId,
                                  service.oneArtist[0].page,
                                  service.oneArtist[0].id,
                                  service.oneArtist[0].is_media,
                                  service.oneArtist[0].author_id,
                                );
                        this.widget.play(
                            this.widget.show == true
                                ? this.widget.currentSong.attachmentName
                                : service.oneArtist[0].attachmentName,
                            context,
                            true);
                        List links = [];
                        for (int i = 0; i < service.oneArtist.length; i++) {
                          links.add(service.oneArtist[i]);
                        }
                        this.widget.setListLinks(links);
                        if (!mounted) return;
                        setState(() {
                          this.widget.showOverlayFalse();
                        });
                      },
                      child: Container(
                        height: maxHeight * 0.0581,
                        width: maxWidth * 0.4305,
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
                                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: maxWidth * 0.0277,
                    ),
                    GestureDetector(
                      onTap: () {
                        service.shuffleListOneArtist.shuffle();
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
                                    this.widget.currentSong.id,
                                    this.widget.currentSong.is_media,
                                    this.widget.currentSong.author_id,
                                  )
                              : this.widget.setPropertiesForFullScreen(
                                    context,
                                    service.shuffleListOneArtist[0].title,
                                    service.shuffleListOneArtist[0].author,
                                    service.shuffleListOneArtist[0].attachmentName,
                                    service.shuffleListOneArtist[0].image,
                                    service.shuffleListOneArtist[0].shabadId,
                                    service.shuffleListOneArtist[0].page,
                                    service.shuffleListOneArtist[0].id,
                                    service.shuffleListOneArtist[0].is_media,
                                    service.shuffleListOneArtist[0].author_id,
                                  );
                          this.widget.play(
                              this.widget.show == true
                                  ? this.widget.currentSong.attachmentName
                                  : service.shuffleListOneArtist[0].attachmentName,
                              context,
                              true);
                          List links = [];
                          for (int i = 0; i < service.shuffleListOneArtist.length; i++) {
                            links.add(service.shuffleListOneArtist[i]);
                          }
                          this.widget.setListLinks(links);
                          if (!mounted) return;
                          setState(() {});
                        });
                      },
                      child: Container(
                        height: maxHeight * 0.0581,
                        width: maxWidth * 0.4305,
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
                                    style:
                                        TextStyle(color: Color(0xff578ed3), fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: maxWidth * 0.0555, top: maxHeight * 0.0229),
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
          controller.text == ''
              ? Flexible(
                  child: Container(
                    padding: EdgeInsets.only(left: maxWidth * 0.0555, top: maxHeight * 0.01621),
                    height: maxHeight * 0.681,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: service.oneArtist?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        // Destination destination = destinations[index];
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(bottom: maxHeight * 0.0270),
                            width: maxWidth * 0.9305,
                            child: Stack(
                              // alignment: Alignment.topCenter,
                              children: <Widget>[
                                // Positioned(
                                //   left: maxWidth * 0.1666,
                                //   child: Container(
                                //     height: maxHeight * 0.0635,
                                //     width: maxWidth * 0.5694,
                                //     decoration: BoxDecoration(
                                //       color: Colors.transparent,
                                //       borderRadius:
                                //           BorderRadius.circular(10.0),
                                //     ),
                                //     child: Padding(
                                //       padding: EdgeInsets.only(
                                //           top: maxHeight * 0.00675),
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
                                            service.oneArtist[index].title,
                                            service.oneArtist[index].author,
                                            service.oneArtist[index].attachmentName,
                                            service.oneArtist[index].image,
                                            service.oneArtist[index].shabadId,
                                            service.oneArtist[index].page,
                                            service.oneArtist[index].id,
                                            is_media: service.oneArtist[index].is_media,
                                            author_id: service.oneArtist[index].author_id,
                                          );
                                      this.widget.play(service.oneArtist[index].attachmentName, context);
                                      List links = [];
                                      for (int i = index; i < service.oneArtist.length; i++) {
                                        links.add(service.oneArtist[i]);
                                      }
                                      this.widget.setListLinks(links);
                                      if (!mounted) return;
                                      setState(() {
                                        this.widget.showOverlayTrue();
                                      });
                                    },
                                    child: Stack(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: maxHeight * 0.014,
                                            left: maxWidth * 0.159,
                                          ),
                                          child: Column(
                                            // mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              ConstrainedBox(
                                                constraints: BoxConstraints(maxWidth: maxWidth * 0.594444),
                                                child: Text(
                                                  service.oneArtist[index].title,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              ConstrainedBox(
                                                constraints: BoxConstraints(maxWidth: maxWidth * 0.594444),
                                                child: Text(
                                                  service.oneArtist[index].author,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(0xffB3B3B3)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // tag: 'recently-played1',
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(6.0),
                                            child: Image(
                                              height: maxHeight * 0.0635,
                                              width: maxWidth * 0.1305,
                                              image: NetworkImage(service.oneArtist[index].image),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          width: 50,
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.only(top: maxHeight * 0.00675, right: maxWidth * 0.0555),
                                          child: Text(
                                            service.oneArtist[index].duration,
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(PageRouteBuilder(
                                              opaque: false,
                                              pageBuilder: (BuildContext context, animation, secondaryAnimation) =>
                                                  SongOptions(
                                                indexOfSong: service.oneArtist[index].id,
                                                title: service.oneArtist[index].title,
                                                artistName: service.oneArtist[index].authorName,
                                                attachmentName: service.oneArtist[index].attachmentName,
                                                id: service.oneArtist[index].id,
                                                author_id: service.oneArtist[index].author_id,
                                                image: service.oneArtist[index].image,
                                                showOverlay: this.widget.showOverlay,
                                                showOverlayTrue: this.widget.showOverlayTrue,
                                                showOverlayFalse: this.widget.showOverlayFalse,
                                                show: this.widget.show,
                                                play: this.widget.play,
                                                setListLinks: this.widget.setListLinks,
                                                insertRecentlyPlayed: this.widget.insertRecentlyPlayed,
                                                setPropertiesForFullScreen: this.widget.setPropertiesForFullScreen,
                                                fromArtistPage: fromArtistPage,
                                              ),
                                              // transitionDuration:
                                              //     Duration(seconds: 1),
                                              transitionsBuilder: (ontext, animation, secondaryAnimation, child) {
                                                var begin = Offset(0.0, -1.0);
                                                var end = this.widget.show == true ? Offset(0.0, -0.08) : Offset.zero;
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
                                            alignment: Alignment.centerLeft,
                                            width: 50,
                                            padding: EdgeInsets.only(
                                              top: maxHeight * 0.00675,
                                              left: maxWidth * 0.0277,
                                            ),
                                            child: Icon(
                                              CupertinoIcons.ellipsis,
                                              color: Color(0xff727272),
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : showSearch(),
        ],
      ),
    );
  }

  Widget showSearch() {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Flexible(
      child: Container(
        padding: EdgeInsets.only(left: maxWidth * 0.0555, top: maxHeight * 0.02162),
        height: maxHeight * 0.681,
        child:
            // FutureBuilder(
            //   future: getOneArtist(widget.id),
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            //     if (snapshot.connectionState == ConnectionState.done) {
            //       if (snapshot.hasData) {
            //         return
            ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: searchResults?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            // Destination destination = destinations[index];
            return Container(
              margin: EdgeInsets.only(bottom: maxHeight * 0.027),
              width: maxWidth * 0.9305,
              child: Stack(
                // alignment: Alignment.topCenter,
                children: <Widget>[
                  // Positioned(
                  //   left: maxWidth * 0.166,
                  //   child: Container(
                  //     // height: 100.0,
                  //     width: maxWidth * 0.4722,
                  //     decoration: BoxDecoration(
                  //       color: Colors.transparent,
                  //       borderRadius: BorderRadius.circular(10.0),
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
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        this.widget.showOverlay(
                              context,
                              searchResults[index].title,
                              searchResults[index].author,
                              searchResults[index].attachmentName,
                              searchResults[index].image,
                              searchResults[index].shabadId,
                              searchResults[index].page,
                              searchResults[index].id,
                              is_media: searchResults[index].is_media,
                              author_id: searchResults[index].author_id,
                            );
                        this.widget.play(searchResults[index].attachmentName, context);
                        List links = [];
                        for (int i = index; i < searchResults.length; i++) {
                          links.add(searchResults[i]);
                        }
                        this.widget.setListLinks(links);
                        if (!mounted) return;
                        setState(() {
                          this.widget.showOverlayTrue();
                          this.widget.insertRecentlyPlayed(searchResults[index].id);
                        });
                      },
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              top: maxHeight * 0.008,
                              left: maxWidth * 0.159,
                            ),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: maxWidth * 0.554444),
                                  child: searchResults[index].title != null
                                      ? Text(
                                          searchResults[index].title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      : Container(),
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: maxWidth * 0.694444),
                                  child: searchResults[index].author != null
                                      ? Text(
                                          searchResults[index].author,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 14.0, fontWeight: FontWeight.w600, color: Color(0xffB3B3B3)),
                                        )
                                      : Container(),
                                )
                              ],
                            ),
                          ),
                          Container(
                            // tag: 'recently-played1',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6.0),
                              child: Image(
                                height: maxHeight * 0.0635,
                                width: maxWidth * 0.1305,
                                image: NetworkImage(searchResults[index].image),
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
                                searchResults[index].duration,
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: maxHeight * 0.00675),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder: (BuildContext context, animation, secondaryAnimation) => SongOptions(
                                      indexOfSong: searchResults[index].id,
                                      title: searchResults[index].title,
                                      artistName: searchResults[index].authorName,
                                      attachmentName: searchResults[index].attachmentName,
                                      id: searchResults[index].id,
                                      author_id: searchResults[index].author_id,
                                      image: searchResults[index].image,
                                      showOverlay: this.widget.showOverlay,
                                      showOverlayTrue: this.widget.showOverlayTrue,
                                      showOverlayFalse: this.widget.showOverlayFalse,
                                      show: this.widget.show,
                                      play: this.widget.play,
                                      setListLinks: this.widget.setListLinks,
                                      insertRecentlyPlayed: this.widget.insertRecentlyPlayed,
                                      setPropertiesForFullScreen: this.widget.setPropertiesForFullScreen,
                                      fromArtistPage: fromArtistPage,
                                    ),
                                    // transitionDuration: Duration(seconds: 1),
                                    transitionsBuilder: (ontext, animation, secondaryAnimation, child) {
                                      var begin = Offset(0.0, -1.0);
                                      var end = this.widget.show == true ? Offset(0.0, -0.08) : Offset.zero;
                                      var curve = Curves.ease;

                                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

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
            );
          },
        ),
        //       } else {
        //         return Center(child: Container());
        //       }
        //     } else {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //   },
        // ),
      ),
    );
  }
}
