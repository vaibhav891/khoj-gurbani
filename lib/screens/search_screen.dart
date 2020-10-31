import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:khojgurbani_music/models/drop-down.dart';
import 'package:khojgurbani_music/models/mediaSearchFilter.dart';
import 'package:khojgurbani_music/models/melody.dart';
import 'package:khojgurbani_music/models/singers.dart';
import 'package:khojgurbani_music/widgets/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:khojgurbani_music/screens/three_dots_on_song.dart';
import 'dart:convert';
import 'dart:async';

import 'artist.dart';

class SearchHistory {
  String status;
  String message;
  List<Result> result;

  SearchHistory({this.status, this.message, this.result});

  SearchHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int id;
  int userId;
  String machineId;
  String keyword;
  String createdAt;
  String updatedAt;

  Result({this.id, this.userId, this.machineId, this.keyword, this.createdAt, this.updatedAt});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    machineId = json['machine_id'];
    keyword = json['keyword'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['machine_id'] = this.machineId;
    data['keyword'] = this.keyword;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ArtistAndSongs {
  String status;
  String message;
  List<Songs> songs;
  List<Artists> artists;

  ArtistAndSongs({this.status, this.message, this.songs, this.artists});

  ArtistAndSongs.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['songs'] != null) {
      songs = new List<Songs>();
      json['songs'].forEach((v) {
        songs.add(new Songs.fromJson(v));
      });
    }
    if (json['artists'] != null) {
      artists = new List<Artists>();
      json['artists'].forEach((v) {
        artists.add(new Artists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.songs != null) {
      data['songs'] = this.songs.map((v) => v.toJson()).toList();
    }
    if (this.artists != null) {
      data['artists'] = this.artists.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Songs {
  int id;
  int author_id;
  int shabadId;
  String title;
  String author;
  String type;
  String duration;
  String attachmentName;
  String image;
  int is_media;
  int page;

  Songs({
    this.id,
    this.author_id,
    this.shabadId,
    this.title,
    this.author,
    this.type,
    this.duration,
    this.attachmentName,
    this.image,
    this.is_media,
    this.page,
  });

  Songs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author_id = json['author_id'];
    shabadId = json['shabad_id'];
    title = json['title'];
    author = json['author'];
    type = json['type'];
    duration = json['duration'];
    attachmentName = json['attachment_name'];
    image = json['image'];
    is_media = json['is_media'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author_id'] = this.author_id;
    data['shabad_id'] = this.shabadId;
    data['title'] = this.title;
    data['author'] = this.author;
    data['type'] = this.type;
    data['duration'] = this.duration;
    data['attachment_name'] = this.attachmentName;
    data['image'] = this.image;
    data['is_media'] = this.is_media;
    data['page'] = this.page;
    return data;
  }
}

class Artists {
  int id;
  String slug;
  String name;
  String description;
  String image;
  int status;
  int featured;
  int featuredDisplayOrder;
  String createdAt;
  String updatedAt;

  Artists({
    this.id,
    this.slug,
    this.name,
    this.description,
    this.image,
    this.status,
    this.featured,
    this.featuredDisplayOrder,
    this.createdAt,
    this.updatedAt,
  });

  Artists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    featured = json['featured'];
    featuredDisplayOrder = json['featured_display_order'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['status'] = this.status;
    data['featured'] = this.featured;
    data['featured_display_order'] = this.featuredDisplayOrder;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class SearchScreen extends StatefulWidget {
  final artists;
  final songs;
  final Function showOverlay;
  final Function showOverlayTrue;
  final Function showOverlayFalse;
  bool show;
  final Function play;
  final Function setListLinks;
  final singers;
  final dropDownOptions;
  final Function insertRecentlyPlayed;
  final Function tapPause;
  final Function tapPlay;
  final Function tapStop;
  bool isPlaying;
  final audioPlayer;
  final Function getLyrics;
  final Function setPropertiesForFullScreen;
  final currentSong;

  SearchScreen({
    Key key,
    this.artists,
    this.songs,
    this.showOverlay,
    this.showOverlayTrue,
    this.showOverlayFalse,
    this.show,
    this.play,
    this.setListLinks,
    this.singers,
    this.dropDownOptions,
    this.insertRecentlyPlayed,
    this.tapPause,
    this.tapPlay,
    this.tapStop,
    this.isPlaying,
    this.audioPlayer,
    this.getLyrics,
    this.setPropertiesForFullScreen,
    this.currentSong,
  }) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchHistory;
  TextEditingController controller = new TextEditingController();
  TextEditingController searchkeyword = new TextEditingController();

  Future getHistory() async {
    // if (searchHistory == null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final machineId = prefs.getString('machine_id');

    final response = await http
        .get('https://api.khojgurbani.org/api/v1/android/search-history?user_id=$userId&machine_id=$machineId');
    var data = json.decode(response.body);

    SearchHistory history = new SearchHistory.fromJson(data);

    if (!mounted) return;
    setState(() {
      searchHistory = history;
    });
    return history;
    // } else {
    //   return searchHistory;
    // }
  }

  updateHistory() async {
    setState(() {
      getHistory();
    });
  }

  bool fromArtistPage = false;
  bool keyboard;

  @override
  void initState() {
    keyboard = false;
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    getHistory();
  }

  @override
  void dispose() {
    super.dispose();
    if (keyboard == true) {
      overlayEntry.remove();
    }
  }

  bool showFilter = false;

  bool showH = true;

  FocusNode focusNode = FocusNode();
  // OverlayEntry overlayEntry;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey list2 = GlobalKey();

  List<Singers> _sing = [];
  List<Melodies> _mel = [];
  List<DropDown> _drop = [];
  String dropdownValue;
  String dropdownValue1;
  String dropdownValue2 = "First letter (search in the begin)";

  int searchOptionId = 3;
  int searchOptionSingerId;
  int searchOptionMelodyId;
  var res = "media";
  var language;
  var content = "audio";
  int pageF = 1;
  int pageT = 1430;
  int translation_author = 1;
  var searchKeyWord;

  List<MediaSearchFilter> mediaFilters = [];
  var mediaF;

  checkSearchKeywordLang() async {
    RegExp englishRerExP = RegExp(r'^[a-zA-Z0-9]+$', caseSensitive: false);

    this.language = 'gurmukhi';

    if (englishRerExP.hasMatch(this.searchKeyWord)) {
      setState(() {
        this.language = 'english';
      });
    }

    //this.setHideShowContentBasedOnLanguage();
  }

  mediaSearchFilter() async {
    var uri = searchOptionSingerId != null
        ? 'https://api.khojgurbani.org/api/v1/scripture/media-advance-search?search_option=$searchOptionId&res=$res&language=$language&content=$content&pageF=$pageF&pageT=$pageT&translation_author=$translation_author&search_keyword=$searchKeyWord&audio_author_id=$searchOptionSingerId'
        : 'https://api.khojgurbani.org/api/v1/scripture/media-advance-search?search_option=$searchOptionId&res=$res&language=$language&content=$content&pageF=$pageF&pageT=$pageT&translation_author=$translation_author&search_keyword=$searchKeyWord';
    var response = await get(uri);
    var mediaFilter = JsonDecoder().convert(response.body);

    setState(() {
      mediaF = mediaFilter;
    });
    mediaFilters = (mediaF).map<MediaSearchFilter>((item) => MediaSearchFilter.fromJson(item)).toList();

    return mediaFilter;
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    SystemChrome.setEnabledSystemUIOverlays([]);
    // _mel = (this.widget.melodys)
    //     .map<Melodies>((item) => Melodies.fromJson(item))
    //     .toList();
    _sing = (this.widget.singers).map<Singers>((item) => Singers.fromJson(item)).toList();
    _drop = (this.widget.dropDownOptions).map<DropDown>((item) => DropDown.fromJson(item)).toList();
    return showFilter == false
        ? Scaffold(
            appBar: AppBar(
              //centerTitle: true,
              backgroundColor: Color(0xffF5F5F5),
              titleSpacing: 0.0,
              title: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    // padding: EdgeInsets.only(bottom: 15),
                    height: maxHeight * 0.045, //0.0418,
                    width: maxWidth * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6.0), topLeft: Radius.circular(6.0)),
                    ),
                    child: TextField(
                      // textInputAction: TextInputAction.done,  on click keyboard finish
                      //textAlignVertical: TextAlignVertical.center,
                      onSubmitted: (value) {
                        showH = false;
                        this.controller.text == '' ? null : insertHistory(this.controller.text);
                      },
                      onTap: () {
                        setState(() {
                          showH = true;
                        });
                      },
                      controller: controller,
                      onChanged: onSearchTextChanged,
                      style: TextStyle(height: 1.7),
                      decoration: InputDecoration(
                        //isDense: true,
                        // contentPadding:
                        // EdgeInsets.only(top: maxHeight * 0.0175),
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
                        hintText: "Search tracks, artists",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        showFilter = true;
                        controller.clear();
                      });
                      // Navigator.of(context).push(PageRouteBuilder(
                      //   opaque: false,
                      //   pageBuilder: (BuildContext context, _, __) =>
                      //       GurbaniSearch(
                      //           melodys: this.widget.melodys,
                      //           singers: this.widget.singers,
                      //           dropDownOptions: this.widget.dropDownOptions),
                      // ));

                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //       builder: (context) => GurbaniSearch(
                      //           melodys: this.widget.melodys,
                      //           singers: this.widget.singers,
                      //           dropDownOptions: this.widget.dropDownOptions),
                      //     ));
                    },
                    child: Container(
                      height: maxHeight * 0.045,
                      width: maxWidth * 0.0972,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(6.0), topRight: Radius.circular(6.0)),
                      ),
                      child: Center(child: Image(image: AssetImage('assets/images/filter.png'))),
                    ),
                  )
                ],
              ),
              // leading: Container(
              //   margin: EdgeInsets.only(right: 0),
              //   child: IconButton(
              //     color: Colors.black,
              //     iconSize: 30,
              //     onPressed: () {
              //       Navigator.popAndPushNamed(context, '/media');
              //     },
              //     icon: Icon(
              //       Icons.chevron_left,
              //     ),
              //   ),
              // ),
              // leading:
            ),
            bottomNavigationBar: MyBottomNavBar(),
            backgroundColor: Colors.white,
            body: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: buildBody()),
          )
        : Scaffold(
            bottomNavigationBar: MyBottomNavBar(),
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Color(0xffF5F5F5),
              actions: <Widget>[],
              title: Text(
                "Filters",
                style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
              ),
              leading: Container(
                // width: 20,
                // height: 50,
                // alignment: AxisDirection.left,
                // padding: EdgeInsets.only(right: 90),
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: IconButton(
                    color: Colors.black,
                    // padding: EdgeInsets.only(bottom: 30),
                    iconSize: 30,
                    onPressed: () {
                      // setState(() {
                      //   showFilter = false;
                      // });
                      Navigator.pushNamedAndRemoveUntil(context, '/search', ModalRoute.withName('/'));
                    },
                    padding: EdgeInsets.only(bottom: maxHeight * 0.0135),
                    icon: Icon(
                      Icons.clear,
                    ),
                  ),
                ),
              ),
            ),
            body: mediaFilters.isEmpty
                ? GestureDetector(
                    // behavior: HitTestBehavior.opaque,
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    child: ListView(
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    top: maxHeight * 0.06621, left: maxWidth * 0.05555, right: maxWidth * 0.055),
                                child: Container(
                                  height: maxHeight * 0.0418,
                                  //width: maxWidth / 1.15,
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: <Widget>[
                                      TextField(
                                        focusNode: focusNode,
                                        textAlignVertical: TextAlignVertical.center,
                                        onSubmitted: (value) {
                                          setState(() {
                                            searchKeyWord = value;
                                            checkSearchKeywordLang();
                                            if (searchKeyWord != '') mediaSearchFilter();

                                            // showFilter = true;
                                          });
                                          // this.searchKeyWord == ''
                                          //     ? null
                                          //     : insertHistory(this.searchKeyWord);
                                        },
                                        onTap: () {
                                          setState(() {
                                            overlayEntry.remove();
                                            keyboard = false;
                                          });
                                        },
                                        controller: searchkeyword,
                                        style: TextStyle(height: 1.7),
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(width: 2, color: Colors.grey)),
                                          isDense: true,
                                          hintText: "Gurbani search",
                                          hintStyle: TextStyle(fontSize: 14),
                                          // border: InputBorder.none,
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          // IconButton(
                                          //   icon: Image(
                                          //       image: AssetImage(
                                          //           'assets/images/keyboard.png')),
                                          //   onPressed: () {},
                                          // ),
                                          GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 4),
                                              child: Icon(
                                                Icons.keyboard,
                                                color: keyboard == true ? Color(0xff578ed3) : Colors.grey,
                                              ),
                                            ),

                                            //  Image(
                                            //     image: AssetImage(
                                            //         'assets/images/keyboard.png')),
                                            onTap: () {
                                              if (keyboard == true) {
                                                overlayEntry.remove();
                                                setState(() {
                                                  keyboard = !keyboard;
                                                });
                                              } else {
                                                FocusScope.of(context).unfocus();
                                                buildPunKeyboard(context);
                                                setState(() {
                                                  keyboard = !keyboard;
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.only(left: 20, top: 50),
                              //   child: DropdownButton<String>(
                              //     value: dropdownValue,
                              //     hint: Text("Melody (RAAG)"),
                              //     icon: Padding(
                              //       padding: EdgeInsets.only(left: 220),
                              //       child: Icon(
                              //         Icons.keyboard_arrow_down,
                              //         color: Colors.blue,
                              //       ),
                              //     ),
                              //     iconSize: 30,
                              //     elevation: 16,
                              //     style: TextStyle(color: Colors.deepPurple),
                              //     underline: Container(
                              //       height: 2,
                              //       color: Colors.grey,
                              //     ),
                              //     onChanged: (String newValue) {
                              //       setState(() {
                              //         dropdownValue = newValue;
                              //       });
                              //     },
                              //     items: _mel.map((Melodies map) {
                              //       return new DropdownMenuItem<String>(
                              //           value: map.melody,
                              //           onTap: () {
                              //             setState(() {
                              //               searchOptionMelodyId = map.id;
                              //             });
                              //             print(searchOptionMelodyId);
                              //           },
                              //           child: Text(map.melody,
                              //               style: new TextStyle(
                              //                   color: Colors.grey, fontSize: 12)));
                              //     }).toList(),
                              //   ),
                              // ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: maxWidth * 0.055, top: maxHeight * 0.0675, right: maxWidth * 0.055),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: dropdownValue1,
                                  hint: Text("Singer (Raagi)"),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Color(0xff578ed3),
                                  ),
                                  iconSize: 30,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.grey,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdownValue1 = newValue;
                                    });
                                  },
                                  items: _sing.map((Singers map) {
                                    return new DropdownMenuItem<String>(
                                        value: map.name,
                                        onTap: () {
                                          setState(() {
                                            searchOptionSingerId = map.id;
                                          });
                                        },
                                        child: Text(map.name, style: new TextStyle(color: Colors.grey, fontSize: 12)));
                                  }).toList(),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: maxWidth * 0.0555, top: maxHeight * 0.0675, right: maxWidth * 0.055),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: dropdownValue2,
                                  isDense: true,
                                  // hint: Text(dropdownValue2),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Color(0xff578ed3),
                                  ),
                                  iconSize: 30,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.grey,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdownValue2 = newValue;
                                    });
                                  },
                                  items: _drop.map((DropDown map) {
                                    return new DropdownMenuItem<String>(
                                        value: map.value,
                                        onTap: () {
                                          setState(() {
                                            searchOptionId = map.id;
                                          });
                                        },
                                        child: new Text(map.value,
                                            style: new TextStyle(color: Colors.grey, fontSize: 12)));
                                  }).toList(),
                                ),
                              ),
                              SizedBox(
                                height: maxHeight * 0.1081,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: maxWidth * 0.0597),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      searchKeyWord = searchkeyword.text;
                                      checkSearchKeywordLang();
                                      mediaSearchFilter();
                                      if (keyboard == true) {
                                        overlayEntry.remove();
                                        setState(() {
                                          keyboard = !keyboard;
                                        });
                                      }
                                      // showFilter = false;
                                    });
                                  },
                                  child: Container(
                                    height: maxHeight * 0.061,
                                    width: maxWidth / 1.11,
                                    // padding: EdgeInsets.only(left: maxWidth * 0.25),
                                    decoration: BoxDecoration(
                                      color: Color(0xff578ed3),
                                      borderRadius: BorderRadius.circular(6.0),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Search',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
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
                  )
                : filterResults(),
          );
  }

  Widget buildBody() {
    return this.controller.text.isEmpty ? buildHistoryList() : buildSearchResults();
  }

  // Fliter results
  Widget filterResults() {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Container(
      height: maxHeight * 1.35135,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: mediaFilters?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(top: maxHeight * 0.0135, left: maxWidth * 0.05555),
            child: Stack(
              // alignment: Alignment.topCenter,
              children: <Widget>[
                // Positioned(
                //   left: maxWidth * 0.159,
                //   child: Container(
                //     height: maxHeight * 0.0635,
                //     width: maxWidth * 0.568,
                //     decoration: BoxDecoration(
                //       color: Colors.transparent,
                //       borderRadius:
                //           BorderRadius.circular(10.0),
                //     ),
                //     child: Padding(
                //       padding: EdgeInsets.only(
                //           top: maxHeight * 0.014),

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
                      FocusScope.of(context).requestFocus(new FocusNode());
                      this.widget.showOverlay(
                            context,
                            mediaFilters[index].title,
                            mediaFilters[index].author,
                            mediaFilters[index].attachmentName,
                            mediaFilters[index].image,
                            mediaFilters[index].shabadId,
                            mediaFilters[index].page,
                            mediaFilters[index].id,
                            is_media: mediaFilters[index].is_media,
                            author_id: mediaFilters[index].author_id,
                          );
                      this.widget.play(mediaFilters[index].attachmentName, context);
                      List links = [];
                      for (int t = index; t < mediaFilters.length; t++) {
                        links.add(mediaFilters[t]);
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
                              Container(
                                width: maxWidth / 1.8,
                                child: Text(
                                  mediaFilters[index].title,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: maxHeight * 0.003,
                              ),
                              Container(
                                width: maxWidth / 1.8,
                                child: Text(
                                  mediaFilters[index].name,
                                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.grey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                              width: maxWidth * 0.1306,
                              image: NetworkImage(mediaFilters[index].image),
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          // width: maxWidth * 0.138888,
                          padding: EdgeInsets.only(top: maxHeight * 0.014, right: maxWidth * 0.045),
                          child: Text(
                            mediaFilters[index].duration,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (BuildContext context, animation, secondaryAnimation) => SongOptions(
                                indexOfSong: mediaFilters[index].id,
                                indexOfArtist: mediaFilters[index].author_id,
                                title: mediaFilters[index].title,
                                artistName: mediaFilters[index].name,
                                attachmentName: mediaFilters[index].attachmentName,
                                id: mediaFilters[index].mediaId,
                                author_id: mediaFilters[index].author_id,
                                image: mediaFilters[index].image,
                                showOverlay: this.widget.showOverlay,
                                showOverlayTrue: this.widget.showOverlayTrue,
                                showOverlayFalse: this.widget.showOverlayFalse,
                                show: this.widget.show,
                                play: this.widget.play,
                                setListLinks: this.widget.setListLinks,
                                insertRecentlyPlayed: this.widget.insertRecentlyPlayed,
                                setPropertiesForFullScreen: this.widget.setPropertiesForFullScreen,
                                fromArtistPage: fromArtistPage,
                                currentSong: this.widget.currentSong,
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
                            width: maxWidth * 0.138888,
                            padding: EdgeInsets.only(
                              top: maxHeight * 0.005,
                              right: maxWidth * 0.00055,
                            ),
                            child: Icon(
                              CupertinoIcons.ellipsis,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  deleteHistory(keyword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int userId = prefs.getInt('user_id');
    final String token = prefs.getString('token');
    final String machineId = prefs.getString('machine_id');

    final res = await http.post(
      'https://api.khojgurbani.org/api/v1/android/media-search-delete',
      body: {'keyword': keyword, 'user_id': json.encode(userId), 'machine_id': machineId},
      // headers: {
      //   'Authorization': "Bearer " + token,
      // }
    );

    final data = jsonDecode(res.body);
    updateHistory();
  }

  insertHistory(keyword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int userId = prefs.getInt('user_id');
    final String token = prefs.getString('token');
    final String machineId = prefs.getString('machine_id');
    final res = await http.post(
      'https://api.khojgurbani.org/api/v1/android/media-search-insert',
      body: {'keyword': keyword, 'user_id': json.encode(userId), 'machine_id': machineId},
      // headers: {
      //   'Authorization': "Bearer " + token,
      // }
    );

    final data = jsonDecode(res.body);
    updateHistory();
  }

  Widget buildHistoryList() {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Container(
      height: maxHeight * 1.35135,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: searchHistory?.result?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.history),
            title: searchHistory.result[index].keyword == null
                ? Container()
                : GestureDetector(
                    onTap: () {
                      onSearchTextChanged(this.controller.text = searchHistory.result[index].keyword);
                      this.controller.text = searchHistory.result[index].keyword;
                    },
                    child: Text(searchHistory.result[index].keyword)),
            trailing: GestureDetector(
              onTap: () {
                deleteHistory(searchHistory.result[index].keyword);
              },
              child: Icon(Icons.close, size: 14),
            ),
          );
        },
      ),
    );
  }

  List searchResults1 = [];
  List searchResults2 = [];

  Widget buildSearchResults() {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return
        // searchResults == null
        //     ? Center(child: CircularProgressIndicator())
        //     :
        CustomScrollView(slivers: <Widget>[
      SliverToBoxAdapter(
        child: searchResults1.length != 0
            ? Padding(
                padding: EdgeInsets.only(left: maxWidth * 0.055, top: maxHeight * 0.01756, bottom: maxHeight * 0.0135),
                child: Text(
                  "Ragi",
                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
            : Container(),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => ArtistPage(
                              indexOfArtist: searchResults1[index].id,
                              id: searchResults1[index].id,
                              name: searchResults1[index].name,
                              attachmentName: searchResults1[index].image,
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
                              isPlaying: this.widget.isPlaying,
                              audioPlayer: this.widget.audioPlayer,
                              getLyrics: this.widget.getLyrics,
                              setPropertiesForFullScreen: this.widget.setPropertiesForFullScreen,
                              currentSong: this.widget.currentSong,
                            )));
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
                        searchResults1[index].name == null
                            ? Container()
                            : Container(
                                width: maxWidth / 1.5,
                                child: Text(
                                  searchResults1[index].name,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                      ],
                    ),
                  ),
                  Container(
                    // tag: 'recently-played1',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: searchResults1[index].image == null
                          ? Container()
                          : Image(
                              height: maxHeight * 0.0635,
                              width: maxWidth * 0.1306,
                              image: NetworkImage(searchResults1[index].image),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }, childCount: searchResults1.length),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(left: maxWidth * 0.0555, top: maxHeight * 0.03108, bottom: maxHeight * 0.01351),
          child: Text(
            "Tracks",
            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      SliverList(
        key: list2,
        delegate: SliverChildBuilderDelegate((BuildContext context, int i) {
          return Padding(
            padding: EdgeInsets.only(top: maxHeight * 0.0135, left: maxWidth * 0.0555),
            child: Stack(
              // alignment: Alignment.topCenter,
              children: <Widget>[
                // Positioned(
                //   left: maxWidth * 0.159,
                //   child: Container(
                //     height: maxHeight * 0.0635,
                //     width: maxWidth * 0.568,
                //     decoration: BoxDecoration(
                //       color: Colors.transparent,
                //       borderRadius:
                //           BorderRadius.circular(10.0),
                //     ),
                //     child: Padding(
                //       padding: EdgeInsets.only(
                //           top: maxHeight * 0.014),

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
                      FocusScope.of(context).requestFocus(new FocusNode());
                      this.widget.showOverlay(
                            context,
                            searchResults2[i].title,
                            searchResults2[i].author,
                            searchResults2[i].attachmentName,
                            searchResults2[i].image,
                            searchResults2[i].shabadId,
                            searchResults2[i].page,
                            searchResults2[i].id,
                            is_media: searchResults2[i].is_media,
                            author_id: searchResults2[i].author_id,
                          );
                      this.widget.play(searchResults2[i].attachmentName, context);
                      List links = [];
                      for (int t = i; t < searchResults2.length; t++) {
                        links.add(searchResults2[t]);
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
                              Container(
                                width: maxWidth / 1.7,
                                child: Text(
                                  searchResults2[i].title,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: maxHeight * 0.003,
                              ),
                              Container(
                                width: maxWidth / 1.7,
                                child: Text(
                                  searchResults2[i].author,
                                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.grey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                              width: maxWidth * 0.1306,
                              image: NetworkImage(searchResults2[i].image),
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          // width: maxWidth * 0.138888,
                          padding: EdgeInsets.only(top: maxHeight * 0.014, right: maxWidth * 0.0555),
                          child: Text(
                            searchResults2[i].duration,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (BuildContext context, animation, secondaryAnimation) => SongOptions(
                                indexOfSong: searchResults2[i].id,
                                indexOfArtist: searchResults2[i].author_id,
                                title: searchResults2[i].title,
                                artistName: searchResults2[i].author,
                                attachmentName: searchResults2[i].attachmentName,
                                id: searchResults2[i].id,
                                author_id: searchResults2[i].author_id,
                                image: searchResults2[i].image,
                                showOverlay: this.widget.showOverlay,
                                showOverlayTrue: this.widget.showOverlayTrue,
                                showOverlayFalse: this.widget.showOverlayFalse,
                                show: this.widget.show,
                                play: this.widget.play,
                                setListLinks: this.widget.setListLinks,
                                insertRecentlyPlayed: this.widget.insertRecentlyPlayed,
                                setPropertiesForFullScreen: this.widget.setPropertiesForFullScreen,
                                fromArtistPage: fromArtistPage,
                                currentSong: this.widget.currentSong,
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
                            width: maxWidth * 0.138888,
                            padding: EdgeInsets.only(
                              top: maxHeight * 0.003750,
                              right: maxWidth * 0.02,
                            ),
                            child: Icon(
                              CupertinoIcons.ellipsis,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }, childCount: searchResults2.length),
      ),
    ]);
  }

  onSearchTextChanged(String text) async {
    searchResults1.clear();
    searchResults2.clear();

    if (text.isEmpty) {
      setState(() {});
      return;
    }
    final textToLowerCase = text.toLowerCase();

    this.widget.songs.forEach((s) {
      if (s.title.toLowerCase().contains(textToLowerCase)) searchResults2.add(s);
      // setState(() {});
    });

    this.widget.artists.forEach((a) {
      if (a.name.toLowerCase().contains(textToLowerCase)) searchResults1.add(a);
      // setState(() {});
    });
    setState(() {});
  }

  OverlayEntry overlayEntry;
  OverlayState overlayState;

  buttonPressed(String buttonText) {
    if (buttonText == "go") {
      overlayEntry.remove();
      mediaSearchFilter();
      keyboard = false;
    } else if (buttonText == 'space') {
      searchkeyword.text = searchkeyword.text + buttonText;
      searchKeyWord = searchkeyword.text;
    } else {
      setState(() {
        searchkeyword.text = searchkeyword.text + buttonText;
        searchKeyWord = searchkeyword.text;
      });
    }
  }

  Widget backSpace() {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.all(2.0),
        child: RaisedButton(
            color: Colors.grey,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.all(1.0),
            child: Icon(
              Icons.backspace,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                if ((searchkeyword.text != null) && (searchkeyword.text.length > 0)) {
                  searchkeyword.text = searchkeyword.text.substring(0, searchkeyword.text.length - 1);
                  searchKeyWord = searchkeyword.text;
                }
              });
            }),
      ),
    );
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.all(2.0),
        child: RaisedButton(
            color: Colors.grey,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.all(1.0),
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              buttonPressed(buttonText);
            }),
      ),
    );
  }

  Widget buildSpaceButton(String buttonText) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.all(2.0),
        child: RaisedButton(
            color: Colors.grey,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.all(1.0),
            child: Text(
              'space',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            onPressed: () {
              buttonPressed(' ');
            }),
      ),
    );
  }

  buildPunKeyboard(BuildContext context) async {
    overlayState = Overlay.of(context);
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
          top: maxHeight / 1.61,
          child: Container(
            color: Colors.white,
            width: maxWidth,
            height: maxHeight / 2,
            child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    buildButton("ਕ"),
                    buildButton("ਖ"),
                    buildButton("ਗ"),
                    buildButton("ਘ"),
                    buildButton("ਙ"),
                    buildButton("ਚ"),
                    buildButton("ਛ"),
                    buildButton("ਜ"),
                    buildButton("ਝ"),
                    buildButton("ਞ"),
                    buildButton("ਟ"),
                    buildButton("ਠ"),
                    buildButton("ਡ"),
                    buildButton("ਢ"),
                  ]),
                  Row(children: [
                    buildButton("ਣ"),
                    buildButton("ਤ"),
                    buildButton("ਥ"),
                    buildButton("ਦ"),
                    buildButton("ਧ"),
                    buildButton("ਨ"),
                    buildButton("ਪ"),
                    buildButton("ਫ"),
                    buildButton("ਬ"),
                    buildButton("ਭ"),
                    buildButton("ਮ"),
                    buildButton("ਯ"),
                    buildButton("ਰ"),
                  ]),
                  Row(children: [
                    buildButton("ਲ"),
                    buildButton("ਲ਼"),
                    buildButton("ਵ"),
                    buildButton("ਸ਼"),
                    buildButton("ਮ"),
                    buildButton("ਰ"),
                    buildButton("ਖ਼"),
                    buildButton("ਗ਼"),
                    buildButton("ਜ਼"),
                    buildButton("ੜ"),
                    buildButton("ਫ਼"),
                  ]),
                  Row(children: [
                    buildButton("ਅ"),
                    buildButton("ਆ"),
                    buildButton("ਇ"),
                    buildButton("ਈ"),
                    buildButton("ਉ"),
                    buildButton("ਊ"),
                    buildButton("ਏ"),
                    buildButton("ਐ"),
                    buildButton("ਓ"),
                    buildButton("ਔ"),
                    buildButton("ੲ"),
                    buildButton("ੳ"),
                  ]),
                  Row(children: [
                    buildButton("ਂ"),
                    buildButton("਼"),
                    buildButton("ਾ"),
                    buildButton("ਿ"),
                    buildButton("ੀ"),
                    buildButton("ੁ"),
                    buildButton("ੂ"),
                    buildButton("ੇ"),
                    buildButton("ੈ"),
                    buildButton("ੋ"),
                    buildButton("ੌ"),
                    buildButton("੍"),
                    buildButton("ੰ"),
                    buildButton("ੱ"),
                  ]),
                  Row(children: [
                    buildButton("ੴ"),
                    buildButton("੦"),
                    buildButton("੧"),
                    buildButton("੨"),
                    buildButton("੩"),
                    buildButton("੪"),
                    buildButton("੫"),
                    buildButton("੬"),
                    buildButton("੭"),
                    buildButton("੮"),
                    buildButton("੯"),
                    buildButton("☬"),
                  ]),
                  Row(children: [
                    buildSpaceButton(" "),
                    backSpace(),
                    buildButton("go"),
                  ]),
                ]),
          )),
    );
    overlayState.insert(overlayEntry);
  }
}
