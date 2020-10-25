import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:khojgurbani_music/screens/three_dots_on_song.dart';
import 'package:khojgurbani_music/services/services.dart';
import 'package:khojgurbani_music/widgets/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';

import '../service_locator.dart';
import 'artist_popular_tracks.dart';

// class OneArtist {
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

//   OneArtist(
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

class ArtistPage extends StatefulWidget {
  final id;
  final name;
  final String attachmentName;
  final Function showOverlay;
  final Function showOverlayTrue;
  final Function showOverlayFalse;
  bool show;
  final Function play;
  final Function setListLinks;
  final Function tapPause;
  final Function tapPlay;
  final Function tapStop;
  final Function setIsOpenFullScreen;
  final Function insertRecentlyPlayed;
  bool isPlaying;
  final audioPlayer;
  final snapshot;
  final Function getLyrics;
  final Function setPropertiesForFullScreen;
  final currentSong;
  final indexOfArtist;
  final initialLink;
  final int fromFullMusicPlayer;

  ArtistPage({
    Key key,
    this.id,
    this.name,
    this.attachmentName,
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
    this.snapshot,
    this.getLyrics,
    this.setPropertiesForFullScreen,
    this.insertRecentlyPlayed,
    this.currentSong,
    this.indexOfArtist,
    this.initialLink,
    this.fromFullMusicPlayer,
  }) : super(key: key);

  @override
  _ArtistPageState createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  var service = getIt<Services>();

  bool _isLoading = false;
  bool _isFavoriteLoading = false;
  bool _isFavorite = false;

  var oneArtist;
  var shuffleListOneArtist;

  // three dots da zna da je na artist pejdzu
  bool fromArtistPage = true;

  void initState() {
    _fetchArtistSongs();
    _fetchUserFavoriteArtists();
    super.initState();
  }

  _fetchArtistSongs() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    oneArtist = await service.getOneArtist(this.widget.id, initialLink: this.widget.initialLink);

    setState(() {
      _isLoading = false;
    });
  }

  var _userFavoriteArtists;

  _fetchUserFavoriteArtists() async {
    if (!mounted) return;
    setState(() {
      _isFavoriteLoading = true;
    });

    _userFavoriteArtists = await service.getUserFavoriteArtists();

    if (!mounted) return;
    setState(() {
      _isFavoriteLoading = false;
    });

    _userFavoriteArtists.forEach((u) {
      if (u.id.toString().contains(this.widget.indexOfArtist.toString())) {
        setState(() {
          _isFavorite = true;
        });
      }
    });
  }

  updateArtistPopularTracksArtistPage() async {
    if (!mounted) return;
    setState(() {
      service.getOneArtist(this.widget.id).then((value) => onSearchTextChanged(controller.text));
    });
  }

  addArtistFavorite(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final String machineId = prefs.getString('machine_id');

    var data = await http.post('https://api.khojgurbani.org/api/v1/android/artist-fav?',
        body: {'artist_id': json.encode(id), 'user_id': json.encode(userId), 'machine_id': machineId});
    var jsonData = jsonDecode(data.body);
    setState(() {
      service.getUserFavoriteMedia();
      service.getUserFavoriteArtists();
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            title: Center(
              child: Text(
                _isFavorite == true ? 'Added to Favorite' : 'Removed from Favorite',
                style: TextStyle(fontSize: 14),
              ),
            ),
          );
        });
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
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        backgroundColor: Color(0xffF5F5F5),
        title: Padding(
          padding: EdgeInsets.only(right: maxWidth * 0.06388),
          child: Container(
            // padding: EdgeInsets.only(bottom: 15),
            height: maxHeight * 0.057,
            width: maxWidth * 0.8694,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              onSubmitted: (value) {},
              onTap: () {
                setState(() {});
              },
              controller: controller,
              onChanged: onSearchTextChanged,
              style: TextStyle(height: 1.7),
              decoration: InputDecoration(
                //isDense: true,
                // contentPadding: EdgeInsets.only(bottom: maxHeight * 0.0175),
                prefixIcon: Image.asset('assets/images/search.png'),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 15,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    controller.clear();
                    onSearchTextChanged('');
                  },
                ),
                hintText: "Search",
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        leading: Container(
          // alignment: Alignment.center,
          padding: EdgeInsets.only(top: 10),
          child: IconButton(
            color: Colors.black,
            // padding: EdgeInsets.only(bottom: 30),
            iconSize: 30,
            onPressed: () {
              // if (this.widget.fromFullMusicPlayer == 0) {
              if (service.oneArtist == null) {
                // Navigator.of(context, rootNavigator: true).pop();
                Navigator.pushNamedAndRemoveUntil(context, '/media', ModalRoute.withName('/'));
              } else {
                service.oneArtist.clear();
                // Navigator.of(context, rootNavigator: true).pop();
                Navigator.pushNamedAndRemoveUntil(context, '/media', ModalRoute.withName('/'));
              }

              // } else {
              //   this.widget.setPropertiesForFullScreen(
              //         context,
              //         this.widget.currentSong.title,
              //         this.widget.currentSong.author,
              //         this.widget.currentSong.attachmentName,
              //         this.widget.currentSong.image,
              //         this.widget.currentSong.shabadId,
              //         this.widget.currentSong.page,
              //         this.widget.currentSong.id,
              //         this.widget.currentSong.is_media,
              //         this.widget.currentSong.author_id,
              //       );
              //   setState(() {
              //     this.widget.showOverlayFalse();
              //   });
              // }
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 21, top: 20),
                child: InkWell(
                  onTap: () {
                    print(this.widget.show);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: _isLoading == false
                        ? Image(
                            width: maxWidth * 0.42, //0.4472,
                            height: maxHeight * 0.2067,
                            image: NetworkImage(_isLoading == false ? service.oneArtist[0].image : ""),
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: maxWidth * 0.4472,
                            height: maxHeight * 0.2067,
                          ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: maxHeight * 0.0364, left: maxWidth * 0.035),
                child: Container(
                  width: maxWidth * 0.4361,
                  child: Column(
                    children: <Widget>[
                      Row(children: <Widget>[
                        _isLoading == false
                            ? Container(
                                width: maxWidth * 0.4361,
                                height: 55,
                                child: Text(
                                  service.oneArtist[0].authorName,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : Container(
                                width: maxWidth * 0.4361,
                                height: 55,
                              ),
                      ]),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          SizedBox(
                            height: maxHeight * 0.0067,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: maxHeight * 0.0743,
                      ),
                      InkWell(
                        onTap: () {
                          addArtistFavorite(this.widget.id);
                          if (_isFavorite == false) {
                            setState(() {
                              _isFavorite = true;
                            });
                          } else {
                            setState(() {
                              _isFavorite = false;
                            });
                          }
                          addedToFavoriteDialog();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: maxHeight * 0.0405,
                              width: maxWidth * 0.277,
                              child: Container(
                                // padding: EdgeInsets.only(left: 0),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(6.0),
                                  border: Border.all(color: Color(0xff578ed3)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Center(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            _isFavorite == true ? Icons.favorite : Icons.favorite_border,
                                            color: Color(0xff578ed3),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          _isFavorite == true
                                              ? Text(
                                                  'Remove',
                                                  style: TextStyle(
                                                    color: Color(0xff578ed3),
                                                    fontSize: 14,
                                                  ),
                                                )
                                              : Text(
                                                  'Add',
                                                  style: TextStyle(
                                                    color: Color(0xff578ed3),
                                                    fontSize: 14,
                                                  ),
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
                ),
              ),
            ],
          ),
          SizedBox(
            height: maxHeight * 0.0135,
          ),
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
                              service.oneArtist[0].title,
                              service.oneArtist[0].author,
                              service.oneArtist[0].attachmentName,
                              service.oneArtist[0].image,
                              service.oneArtist[0].shabadId,
                              service.oneArtist[0].page,
                              service.oneArtist[0].is_media,
                              service.oneArtist[0].author_id,
                              service.oneArtist[0].id,
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
                    setState(() {});
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
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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
                  width: maxHeight * 0.0135,
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
                                this.widget.currentSong.is_media,
                                this.widget.currentSong.author_id,
                                this.widget.currentSong.id,
                              )
                          : this.widget.setPropertiesForFullScreen(
                                context,
                                service.shuffleListOneArtist[0].title,
                                service.shuffleListOneArtist[0].author,
                                service.shuffleListOneArtist[0].attachmentName,
                                service.shuffleListOneArtist[0].image,
                                service.shuffleListOneArtist[0].shabadId,
                                service.shuffleListOneArtist[0].page,
                                service.shuffleListOneArtist[0].is_media,
                                service.shuffleListOneArtist[0].author_id,
                                service.shuffleListOneArtist[0].id,
                              );
                      this.widget.play(
                          this.widget.show == true
                              ? this.widget.currentSong.attachmentName
                              : service.shuffleListOneArtist[0].attachmentName,
                          context,
                          true);
                      List links = [];
                      for (int m = 0; m < service.shuffleListOneArtist.length; m++) {
                        links.add(service.shuffleListOneArtist[m]);
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
                                  style: TextStyle(color: Color(0xff578ed3), fontSize: 16, fontWeight: FontWeight.bold),
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
          Padding(
            padding: EdgeInsets.only(left: maxWidth * 0.0555, top: maxHeight * 0.01351),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Popular',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: maxHeight * 0.00675, right: maxWidth * 0.055),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => ArtistPopularTracks(
                                    id: widget.id,
                                    showOverlay: this.widget.showOverlay,
                                    showOverlayTrue: this.widget.showOverlayTrue,
                                    showOverlayFalse: this.widget.showOverlayFalse,
                                    show: this.widget.show,
                                    play: this.widget.play,
                                    setListLinks: this.widget.setListLinks,
                                    insertRecentlyPlayed: this.widget.insertRecentlyPlayed,
                                    tapPause: this.widget.tapPause,
                                    tapPlay: this.widget.tapPlay,
                                    tapStop: this.widget.tapStop,
                                    setIsOpenFullScreen: this.widget.setIsOpenFullScreen,
                                    isPlaying: this.widget.isPlaying,
                                    audioPlayer: this.widget.audioPlayer,
                                    snapshot: this.widget.snapshot,
                                    getLyrics: this.widget.getLyrics,
                                    setPropertiesForFullScreen: this.widget.setPropertiesForFullScreen,
                                    currentSong: this.widget.currentSong,
                                  )));
                    },
                    child: Text(
                      "See all",
                      style: TextStyle(color: Color(0xff578ed3), fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          controller.text == ''
              ? Flexible(
                  child: Container(
                    padding: EdgeInsets.only(left: maxWidth * 0.0555, top: maxHeight * 0.02162),
                    height: maxHeight,
                    child:
                        // FutureBuilder(
                        //   future: getOneArtist(widget.id),
                        //   builder: (BuildContext context, AsyncSnapshot snapshot) {
                        //     if (snapshot.connectionState == ConnectionState.done) {
                        //       if (snapshot.hasData) {
                        //         return
                        ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: (service.oneArtist?.length ?? 0) < 5 ? (service.oneArtist?.length ?? 0) : 5,
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
                                    // FocusScope.of(context)
                                    //     .requestFocus(new FocusNode());
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
                                      this.widget.insertRecentlyPlayed(service.oneArtist[index].id);
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
                                              child: service.oneArtist[index].title != null
                                                  ? Text(
                                                      service.oneArtist[index].title,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    )
                                                  : Text(""),
                                            ),
                                            ConstrainedBox(
                                              constraints: BoxConstraints(maxWidth: maxWidth * 0.694444),
                                              child: service.oneArtist[index].author != null
                                                  ? Text(
                                                      service.oneArtist[index].author,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight: FontWeight.w600,
                                                          color: Color(0xffB3B3B3)),
                                                    )
                                                  : Text(""),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        // tag: 'recently-played1',
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(6.0),
                                          child: service.oneArtist != null
                                              ? Image(
                                                  height: maxHeight * 0.0635,
                                                  width: maxWidth * 0.1305,
                                                  image: NetworkImage(service.oneArtist[0].image),
                                                  fit: BoxFit.cover,
                                                )
                                              : Container(
                                                  height: maxHeight * 0.0635,
                                                  width: maxWidth * 0.1305,
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
                                            right: maxWidth * 0.005,
                                          ),
                                          child: Text(
                                            service.oneArtist[index].duration,
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: maxHeight * 0.00675),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(PageRouteBuilder(
                                                opaque: false,
                                                pageBuilder: (BuildContext context, animation, secondaryAnimation) =>
                                                    SongOptions(
                                                  indexOfSong: service.oneArtist[index].id,
                                                  title: service.oneArtist[index].title,
                                                  artistName: service.oneArtist[index].author,
                                                  attachmentName: service.oneArtist[index].attachmentName,
                                                  id: service.oneArtist[index].id,
                                                  playlist_id: null,
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
                                                  var end = this.widget.show == true || service.showFromService == true
                                                      ? Offset(0.0, -0.08)
                                                      : Offset.zero;
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
                                                size: 24,
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
        height: maxHeight * 0.46486,
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
                              child: service.oneArtist != null
                                  ? Image(
                                      height: maxHeight * 0.0635,
                                      width: maxWidth * 0.1305,
                                      image: NetworkImage(service.oneArtist[0].image),
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      height: maxHeight * 0.0635,
                                      width: maxWidth * 0.1305,
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
                                      artistName: searchResults[index].author,
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
