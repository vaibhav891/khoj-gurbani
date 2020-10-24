import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:khojgurbani_music/screens/artist.dart';
import 'dart:convert';
import 'package:khojgurbani_music/screens/library.dart';
import 'package:khojgurbani_music/screens/search_screen.dart';
import 'package:khojgurbani_music/service_locator.dart';
import 'package:khojgurbani_music/services/downloadFiles.dart';
import 'package:khojgurbani_music/services/services.dart';
import 'package:khojgurbani_music/widgets/music_player_short_version.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import './screens/login.dart';
import './screens/login_or_register.dart';
import './screens/sign_up.dart';
import './screens/create_account.dart';
import './screens/forgot_password.dart';
import './screens/media.dart';
import './screens/forgot_password2.dart';
import './screens/podcast_theme.dart';
import './screens/sub_category.dart';
import 'models/featuredPodcasts.dart';
import 'screens/music_player_full_size.dart';
import 'services/loginAndRegistrationServices.dart';

void main() {
  getServices();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AudioPlayer audioPlayer;
  var service = getIt<LoginAndRegistrationService>();
  var downloadService = getIt<Downloader>();
  var showService = getIt<Services>();

  bool repeat = false;
  bool isInternetOn = true;
  var subscription;

  setRepeat(val) {
    if (val == true) {
      index--;
    } else
      index++;
    setState(() {
      repeat = val;
    });
  }

  @override
  void initState() {
    initUniLinks();
    audioPlayer = AudioPlayer();
    service.getDeviceDetails();
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result.index != 2) {
        isInternetOn = true;
      } else {
        isInternetOn = false;
      }
    });
    // audioPlayer = new AudioPlayer();
    getArtistAndSongs();
    getConnect();
    // getMelody();
    getSingers();
    getDropDownOptions();
    getFeaturedPodcasts();
    getFeaturedPodcastThemes();
    audioPlayer.onPlayerCompletion.listen((event) {
      if (index == listLinks.length) index = 0;
      if (index < this.listLinks.length) {
        if (isOpenFullScreen == false) {
          this.showOverlay(context, listLinks[index].title, listLinks[index].author, listLinks[index].attachmentName,
              listLinks[index].image, listLinks[index].shabadId, listLinks[index].page, listLinks[index].id,
              is_media: listLinks[index].is_media, author_id: listLinks[index].author_id);
        } else {
          setState(() {
            title = listLinks[index].title;
            singerName = listLinks[index].author;
            attachmentName = listLinks[index].attachmentName;
            image = listLinks[index].image;
            shabadId = listLinks[index].shabadId;
            page = listLinks[index].page;
            is_media = listLinks[index].is_media;
            author_id = listLinks[index].author_id;
            id = listLinks[index].id;
          });
        }
        if (is_media == 1) insertRecentlyPlayed(id);
        audioPlayer.play(listLinks[index].attachmentName).then((value) {
          {
            if (is_media == 1) getLyrics(this.shabadId, this.page);
          }
        });
        if (!repeat) index++;
      }
    });
  }

  void getConnect() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isInternetOn = false;
      });
    }
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

  setPropertiesForFullScreen(context, titleTMP, authorTMP, attachmentNameTEMP, imageTMP, shabadIdTMP, pageTMP,
      is_mediaTMP, author_idTMP, idTMP,
      {fromFile}) {
    setState(() {
      this.title = titleTMP;
      this.singerName = authorTMP;
      this.attachmentName = attachmentNameTEMP;
      this.image = imageTMP;
      this.shabadId = shabadIdTMP;
      this.page = pageTMP;
      this.is_media = is_mediaTMP;
      this.author_id = author_idTMP;
      this.id = idTMP;
    });
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => MusicPlayerFullSize(
                  title: this.title,
                  artistName: this.singerName,
                  attachmentName: this.attachmentName,
                  image: this.image,
                  shabadId: this.shabadId,
                  page: this.page,
                  is_media: this.is_media,
                  author_id: this.author_id,
                  id: this.id,
                  tapPause: this.tapPause,
                  tapPlay: this.tapPlay,
                  showOverlay: this.showOverlay,
                  showOverlayTrue: this.showOverlayTrue,
                  setIsOpenFullScreen: this.setIsOpenFullScreen,
                  show: this.show,
                  isPlaying: this.isPlaying,
                  audioPlayer: this.audioPlayer,
                  snapshot: this.snapshot,
                  getLyrics: this.getLyrics,
                  playPrevSong: playPrevSong,
                  shuffleListLinks: shuffleListLinks,
                  repeat: repeat,
                  setRepeat: setRepeat,
                  setShuffle: setShuffle,
                  shuffle: shuffle,
                  playNextSong: playNextSong,
                  fromFile: fromFile,
                )));
  }

  var snapshot;
  getLyrics(shabadId, page) async {
    if (shabadId != 0) {
      // final headers = {'Authorization': "Bearer " + token};
      final response = await http.get('https://apiprod.khojgurbani.org/api/v1/shabad/$page/$shabadId');

      var data = json.decode(response.body);

      Lyrcis lyrics = new Lyrcis.fromJson(data);
      if (!mounted) return;
      setState(() {
        snapshot = lyrics;
      });
      return lyrics;
    } else {
      doNothing();
    }
  }

  doNothing() {}

  bool show = false;
  OverlayEntry overlayEntryOld;
  OverlayState overlayState;

  String title;
  String singerName;
  String attachmentName;
  String image;
  int shabadId;
  int page;
  int is_media;
  int author_id;
  int id;

  showOverlayTrue() {
    setState(() {
      show = true;
      showService.showChange();
    });
  }

  showOverlayFalse() {
    setState(() {
      show = false;
      showService.showChange();
    });
  }

  bool isOpenFullScreen = false;

  setIsOpenFullScreen(param) {
    isOpenFullScreen = param;
  }

  // seekOnPressRight() async {
  //   var right = await audioPlayer.seek(Duration(minutes: 10, seconds: 9));
  // }

  void showOverlay(context, title, singerName, attachmentName, image, shabadId, page, id,
      {is_media, author_id, isRadio, fromFile}) async {
    // double maxWidth = MediaQuery.of(context).size.width;
    // double maxHeight = MediaQuery.of(context).size.height;
    if (show == true) {
      overlayEntryOld.remove();
    }
    if (overlayState == null) {
      overlayState = Overlay.of(context);
    }
    OverlayEntry overlayEntry;

    removeOverlayEntry() {
      overlayEntry.remove();
    }

    print('showOverlay attname -> $attachmentName');
    overlayEntry = OverlayEntry(
      builder: (context) => isRadio == null
          ? GestureDetector(
              onTap: () {
                setState(() {
                  showOverlayFalse();
                  isOpenFullScreen = true;
                });
                removeOverlayEntry();
                this.title = title;
                this.singerName = singerName;
                this.attachmentName = attachmentName;
                this.image = image;
                this.shabadId = shabadId;
                this.page = page;
                this.is_media = is_media;
                this.author_id = author_id;
                this.id = id;
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => MusicPlayerFullSize(
                              title: this.title,
                              artistName: this.singerName,
                              image: this.image,
                              attachmentName: this.attachmentName,
                              shabadId: this.shabadId,
                              page: this.page,
                              id: this.id,
                              tapPause: tapPause,
                              tapPlay: tapPlay,
                              showOverlay: showOverlay,
                              showOverlayTrue: showOverlayTrue,
                              setIsOpenFullScreen: setIsOpenFullScreen,
                              showOverlayFalse: showOverlayFalse,
                              isPlaying: isPlaying,
                              audioPlayer: audioPlayer,
                              snapshot: this.snapshot,
                              getLyrics: getLyrics,
                              is_media: is_media,
                              author_id: author_id,
                              playPrevSong: playPrevSong,
                              shuffleListLinks: shuffleListLinks,
                              repeat: repeat,
                              setRepeat: setRepeat,
                              setShuffle: setShuffle,
                              shuffle: shuffle,
                              playNextSong: playNextSong,
                              fromFile: fromFile,
                              currentSong: currentSong,
                              setPropertiesForFullScreen: setPropertiesForFullScreen,
                              play: play,
                              setListLinks: setListLinks,
                              insertRecentlyPlayed: insertRecentlyPlayed,
                              show: this.show,
                            )));
              },
              child: Stack(
                children: <Widget>[
                  Positioned(
                    height: MediaQuery.of(context).size.height * 0.08108,
                    width: MediaQuery.of(context).size.width,
                    bottom: 80,
                    child: Material(
                      color: Color(0xff578ed3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          fromFile != 1
                              ? Image(
                                  height: MediaQuery.of(context).size.height * 0.08108,
                                  width: MediaQuery.of(context).size.width * 0.16666,
                                  image: NetworkImage(image
                                      // .contains(
                                      //         'https://api.khojgurbani.org/uploads/author/')
                                      //     ? image
                                      //     : 'https://api.khojgurbani.org/uploads/author/' +
                                      //         image
                                      ),
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  // tag: 'recently-played1',
                                  child: Image.file(
                                    File(image),
                                    height: MediaQuery.of(context).size.height * 0.08108,
                                    width: MediaQuery.of(context).size.width * 0.16666,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.04166,
                                top: MediaQuery.of(context).size.height * 0.01891),
                            // width: 150,
                            // color: Colors.blue,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.40277,
                                      child: Text(
                                        title,
                                        overflow: TextOverflow.clip,
                                        maxLines: 1,
                                        style: TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.40277,
                                      child: singerName != null
                                          ? Text(
                                              singerName,
                                              overflow: TextOverflow.clip,
                                              maxLines: 1,
                                              style: TextStyle(color: Colors.grey, fontSize: 12),
                                            )
                                          : Container(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width * 0.1388,
                                    top: MediaQuery.of(context).size.height * 0.0243),
                                child: GestureOverlay(
                                  // icons: icons,
                                  isPlaying: this.isPlaying,
                                  tapPause: this.tapPause,
                                  tapPlay: this.tapPlay,
                                  tapStop: this.tapStop,
                                  show: this.show,
                                  removeOverlayEntry: removeOverlayEntry,
                                  showOverlayFalse: showOverlayFalse,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    height: MediaQuery.of(context).size.height * 0.081081,
                    width: MediaQuery.of(context).size.width,
                    bottom: 80,
                    child: Material(
                      color: Color(0xff578ed3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image(
                            height: MediaQuery.of(context).size.height * 0.081081,
                            width: MediaQuery.of(context).size.width * 0.16666,
                            image: NetworkImage(image
                                // .contains(
                                //         'https://api.khojgurbani.org/uploads/author/')
                                //     ? image
                                //     : 'https://api.khojgurbani.org/uploads/author/' +
                                //         image
                                ),
                            fit: BoxFit.cover,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.04166,
                                top: MediaQuery.of(context).size.height * 0.01891),
                            // width: 150,
                            // color: Colors.blue,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.40277,
                                      child: Text(
                                        title,
                                        overflow: TextOverflow.clip,
                                        maxLines: 1,
                                        style: TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.40277,
                                      child: singerName != null
                                          ? Text(
                                              singerName,
                                              overflow: TextOverflow.clip,
                                              maxLines: 1,
                                              style: TextStyle(color: Colors.grey, fontSize: 12),
                                            )
                                          : Container(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width * 0.13888,
                                      top: MediaQuery.of(context).size.height * 0.0243),
                                  child: GestureOverlay(
                                    // icons: icons,
                                    isPlaying: this.isPlaying,
                                    tapPause: this.tapPause,
                                    tapPlay: this.tapPlay,
                                    tapStop: this.tapStop,
                                    show: this.show,
                                    removeOverlayEntry: removeOverlayEntry,
                                    showOverlayFalse: showOverlayFalse,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
    overlayEntryOld = overlayEntry;

    WidgetsBinding.instance.addPostFrameCallback((_) => overlayState.insert(overlayEntry));
  }

  List listLinks = [];
  int index = 0;
  var currentSong;

  setListLinks(links) {
    setState(() {
      repeat = false;
      shuffle = false;
    });
    currentSong = links[0];
    this.listLinks = links;
    index = 1;
  }

  bool shuffle = false;
  setShuffle(val) {
    shuffle = val;
  }

  shuffleListLinks() {
    //listLinks.shuffle();
    var first = listLinks[index - 1];
    listLinks.forEach((element) {});
    for (int i = 0; i < listLinks.length; i++) {
      if (listLinks[i].id == first.id) {
        listLinks.removeAt(i);
        break;
      }
    }
    listLinks.shuffle();
    listLinks = [first, ...listLinks];
    listLinks.forEach((element) {});
    index = 0;
    setState(() {
      repeat = false;
      /*title = listLinks[index].title;
      singerName = listLinks[index].author;
      image = listLinks[index].image;
      shabadId = listLinks[index].shabadId;
      page = listLinks[index].page;
      is_media = listLinks[index].is_media;
      author_id = listLinks[index].author_id;
      id = listLinks[index].id;
      file = listLinks[index].attachmentName;*/
    });
    /*insertRecentlyPlayed(listLinks[index].id);
    audioPlayer
        .play(listLinks[index].attachmentName)
        .then((value) => getLyrics(this.shabadId, this.page));*/
    index++;
  }

  playPrevSong() {
    if (index > 1) {
      index--;
      index--;
      setState(() {
        repeat = false;
        shuffle = false;
        isPlaying = true;
        title = listLinks[index].title;
        singerName = listLinks[index].author;
        attachmentName = listLinks[index].attachmentName;
        image = listLinks[index].image;
        shabadId = listLinks[index].shabadId;
        page = listLinks[index].page;
        is_media = listLinks[index].is_media;
        author_id = listLinks[index].author_id;
        id = listLinks[index].id;
      });
      insertRecentlyPlayed(listLinks[index].id);
      audioPlayer.play(listLinks[index].attachmentName).then((value) {
        getLyrics(this.shabadId, this.page);
      });
      index++;
    } else {
      index = listLinks.length - 1;
      setState(() {
        repeat = false;
        shuffle = false;
        isPlaying = true;
        title = listLinks[index].title;
        singerName = listLinks[index].author;
        attachmentName = listLinks[index].attachmentName;
        image = listLinks[index].image;
        shabadId = listLinks[index].shabadId;
        page = listLinks[index].page;
        is_media = listLinks[index].is_media;
        author_id = listLinks[index].author_id;
        id = listLinks[index].id;
      });
      insertRecentlyPlayed(listLinks[index].id);
      audioPlayer.play(listLinks[index].attachmentName).then((value) {
        getLyrics(this.shabadId, this.page);
      });
      index++;
    }
  }

  playNextSong() {
    if (index < listLinks.length) {
      setState(() {
        repeat = false;
        shuffle = false;
        isPlaying = true;
        title = listLinks[index].title;
        singerName = listLinks[index].author;
        attachmentName = listLinks[index].attachmentName;
        image = listLinks[index].image;
        shabadId = listLinks[index].shabadId;
        page = listLinks[index].page;
        is_media = listLinks[index].is_media;
        author_id = listLinks[index].author_id;
        id = listLinks[index].id;
      });
      audioPlayer.play(listLinks[index].attachmentName).then((value) {
        getLyrics(this.shabadId, this.page);
      });
      index++;
    } else {
      index = 0;
      setState(() {
        repeat = false;
        shuffle = false;
        isPlaying = true;
        title = listLinks[index].title;
        singerName = listLinks[index].author;
        attachmentName = listLinks[index].attachmentName;
        image = listLinks[index].image;
        shabadId = listLinks[index].shabadId;
        page = listLinks[index].page;
        is_media = listLinks[index].is_media;
        author_id = listLinks[index].author_id;
        id = listLinks[index].id;
      });
      audioPlayer.play(listLinks[index].attachmentName).then((value) => getLyrics(this.shabadId, this.page));
      index++;
    }
  }

  bool isPlaying = false;
  play(song, context, [removeOverlay = false]) async {
    if (show == true && removeOverlay == true) {
      overlayEntryOld.remove();
      showOverlayFalse();
      setIsOpenFullScreen(true);
    }
    int result = await audioPlayer.play(song);
    // od();
// this must
    // seekOnPressRight();
    setState(() {
      isPlaying = true;
    });
    // int seek = await audioPlayer.seek(Duration(minutes: 10, seconds: 10));
    if (result == 1) {
      return 'succes';
    }
  }

  tapStop() async {
    await audioPlayer.stop();
    if (!mounted) return;
    setState(() {
      isPlaying = false;
    });
  }

  tapPlay() async {
    await audioPlayer.resume();
    if (!mounted) return;
    setState(() {
      isPlaying = true;
    });
  }

  tapPause() async {
    await audioPlayer.pause();
    if (!mounted) return;
    setState(() {
      isPlaying = false;
    });
  }

  // var prefs;

  // Future<List<String>> getDeviceDetailsLoginSkip() async {
  //   String deviceName;
  //   String deviceVersion;
  //   var identifier;
  //   final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  //   try {
  //     if (Platform.isAndroid) {
  //       var build = await deviceInfoPlugin.androidInfo;
  //       deviceName = build.model;
  //       deviceVersion = build.version.toString();
  //       identifier = build.androidId; //UUID for Android
  //     } else if (Platform.isIOS) {
  //       var data = await deviceInfoPlugin.iosInfo;
  //       deviceName = data.name;
  //       deviceVersion = data.systemVersion;
  //       identifier = data.identifierForVendor; //UUID for iOS
  //     }
  //   } on PlatformException {
  //   }
  //   this.getMachineId(identifier);
  //   return [deviceName, deviceVersion, identifier];
  // }

  // getMachineId(identifier) async {
  //   prefs = await SharedPreferences.getInstance();
  //   prefs.setString('machine_id', identifier);
  // }

// var melodys;
// List<Map> melodys = [{}];
  // var melodys;
  // getMelody() async {
  //   var response = await http
  //       .get('https://api.khojgurbani.org/api/v1/android/all-melodies');
  //   var melody = JsonDecoder().convert(response.body);

  //   setState(() {
  //     melodys = melody;
  //   });
  //   return melody;
  // }

  var singers;

  getSingers() async {
    var response = await http.get('https://api.khojgurbani.org/api/v1/android/all-singers');
    var singer = JsonDecoder().convert(response.body);

    setState(() {
      singers = singer;
    });
    return singer;
  }

  var dropDownOptions;

  getDropDownOptions() async {
    var response = await http.get('https://api.khojgurbani.org/api/v1/android/drop-down');
    var drop = JsonDecoder().convert(response.body);

    setState(() {
      dropDownOptions = drop;
    });
    return drop;
  }

  var artists;
  var songs;

  getArtistAndSongs() async {
    final response = await http.get('https://api.khojgurbani.org/api/v1/android/media-search');
    var data = json.decode(response.body);

    ArtistAndSongs results = new ArtistAndSongs.fromJson(data);

    setState(() {
      this.songs = results.songs;
      this.artists = results.artists;
      // searchResults = results;
    });
    return results;
  }

  var featuredPodcasts;

  getFeaturedPodcasts() async {
    var response = await http.get('https://api.khojgurbani.org/api/v1/android/home-skip');
    var data = json.decode(response.body);

    FeaturedPodcastsList results = new FeaturedPodcastsList.fromJson(data);
    setState(() {
      this.featuredPodcasts = results.result.featuredPodcasts;
    });
    return results;
  }

  var featuredPodcastsThemes;

  getFeaturedPodcastThemes() async {
    var response = await http.get('https://api.khojgurbani.org/api/v1/android/home-skip');
    var data = json.decode(response.body);

    FeaturedPodcastsList results = new FeaturedPodcastsList.fromJson(data);

    setState(() {
      this.featuredPodcastsThemes = results.result.featuredPodcastCategories;
    });
    return results;
  }

  insertRecentlyPlayed(int mediaId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int userId = prefs.getInt('user_id');
    final String machineId = prefs.getString('machine_id');

    final res = await http.post(
      'https://api.khojgurbani.org/api/v1/android/play?media_id=$mediaId',
      body: {'user_id': json.encode(userId), 'machine_id': machineId},
      // headers: {
      //   'Authorization': "Bearer " + token,
      // }
    );
    // final data = jsonDecode(res.body);
  }

  var initialLink;
  var initialLinkDecoded;
  var auth_id;
  var aStr;

  bool fromLink = false;

  Future<Null> initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initialLink = await getInitialLink();
      if (initialLink == null) {
        setState(() {
          fromLink = false;
        });
      } else {
        setState(() {
          fromLink = true;
          initialLinkDecoded = Uri.decodeComponent(initialLink);
          // auth_id = int.parse(initialLinkDecoded);
          aStr = initialLinkDecoded.replaceAll(new RegExp(r'[^0-9]'), '');
          auth_id = int.parse(aStr);
        });
      }
      // Use the uri and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
    } on FormatException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Cabin'),
      debugShowCheckedModeBanner: false,
      home: fromLink == false
          ? LoginOrRegister()
          : ArtistPage(
              indexOfArtist: auth_id,
              id: auth_id,
              showOverlay: this.showOverlay,
              showOverlayTrue: this.showOverlayTrue,
              showOverlayFalse: this.showOverlayFalse,
              show: this.show,
              play: this.play,
              setListLinks: this.setListLinks,
              insertRecentlyPlayed: this.insertRecentlyPlayed,
              tapPause: this.tapPause,
              tapPlay: this.tapPlay,
              tapStop: this.tapStop,
              setIsOpenFullScreen: this.setIsOpenFullScreen,
              isPlaying: this.isPlaying,
              audioPlayer: this.audioPlayer,
              snapshot: this.snapshot,
              getLyrics: this.getLyrics,
              setPropertiesForFullScreen: this.setPropertiesForFullScreen,
              currentSong: this.currentSong,
              initialLink: initialLink,
            ),
      routes: <String, WidgetBuilder>{
        '/loginOrSingup': (BuildContext context) => LoginOrRegister(),
        '/artist': (BuildContext context) => ArtistPage(),
        '/signUp': (BuildContext context) => SingupPage(),
        '/login': (BuildContext context) => LoginPage(),
        '/media': (BuildContext context) => MediaPage(
              isPlaying: isPlaying,
              tapPause: tapPause,
              tapPlay: tapPlay,
              tapStop: tapStop,
              play: play,
              show: show,
              showOverlay: showOverlay,
              showOverlayFalse: showOverlayFalse,
              showOverlayTrue: showOverlayTrue,
              setListLinks: setListLinks,
              insertRecentlyPlayed: insertRecentlyPlayed,
              setIsOpenFullScreen: setIsOpenFullScreen,
              audioPlayer: audioPlayer,
              snapshot: this.snapshot,
              getLyrics: getLyrics,
              setPropertiesForFullScreen: this.setPropertiesForFullScreen,
              featuredPodcasts: featuredPodcasts,
              featuredPodcastsThemes: featuredPodcastsThemes,
              currentSong: currentSong,
            ),
        '/createAccount': (BuildContext context) => CreateAccount(),
        '/forgotPassword': (BuildContext context) => ForgotPassword(),
        '/forgotPasswordContinue': (BuildContext context) => ForgotPasswordContinue(),
        '/fullSizePlayer': (BuildContext context) => MusicPlayerFullSize(),
        '/subCategoryPage': (BuildContext context) => CategoryPage(),
        '/podcastThemes': (BuildContext context) => PodcastThemePage(
              showOverlay: showOverlay,
              showOverlayTrue: showOverlayTrue,
              showOverlayFalse: showOverlayFalse,
              show: show,
              play: play,
              setListLinks: setListLinks,
            ),
        '/library': (BuildContext context) => Library(
            showOverlay: showOverlay,
            showOverlayTrue: showOverlayTrue,
            showOverlayFalse: showOverlayFalse,
            show: show,
            play: play,
            setListLinks: setListLinks,
            insertRecentlyPlayed: insertRecentlyPlayed,
            setPropertiesForFullScreen: this.setPropertiesForFullScreen,
            currentSong: currentSong),
        // '/threeDotsOnFullPlayer': (BuildContext context) => SongOptions(),
        '/search': (BuildContext context) => SearchScreen(
            artists: this.artists,
            songs: this.songs,
            showOverlay: showOverlay,
            showOverlayTrue: showOverlayTrue,
            showOverlayFalse: showOverlayFalse,
            show: show,
            play: play,
            setListLinks: setListLinks,
            singers: this.singers,
            dropDownOptions: this.dropDownOptions,
            insertRecentlyPlayed: insertRecentlyPlayed,
            tapPause: tapPause,
            tapPlay: tapPlay,
            tapStop: tapStop,
            isPlaying: isPlaying,
            audioPlayer: audioPlayer,
            getLyrics: getLyrics,
            setPropertiesForFullScreen: setPropertiesForFullScreen,
            currentSong: currentSong),
      },
    );
  }
}
