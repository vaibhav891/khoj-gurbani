import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khojgurbani_music/models/UserSetings.dart';
import 'package:khojgurbani_music/screens/settings_screen.dart';
import 'package:khojgurbani_music/screens/three_dots_on_song.dart';
import 'package:khojgurbani_music/services/Database.dart';
import '../widgets/player_text_fild_expanded.dart';
import 'package:khojgurbani_music/screens/podcast_on_three_dots.dart';

class Lyrcis {
  String status;
  Data data;
  List<int> pages;

  Lyrcis({this.status, this.data, this.pages});

  Lyrcis.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    pages = json['pages'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['pages'] = this.pages;
    return data;
  }
}

class Data {
  int id;
  int scriptureidFrom;
  int scriptureidTo;
  List<Scriptures> scriptures;
  List<Null> blog;
  List<Null> video;
  List<Santhya> santhya;
  List<Null> audio;
  List<Katha> katha;

  Data(
      {this.id,
      this.scriptureidFrom,
      this.scriptureidTo,
      this.scriptures,
      this.blog,
      this.video,
      this.santhya,
      this.audio,
      this.katha});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scriptureidFrom = json['scriptureid_from'];
    scriptureidTo = json['scriptureid_to'];
    if (json['scriptures'] != null) {
      scriptures = new List<Scriptures>();
      json['scriptures'].forEach((v) {
        scriptures.add(new Scriptures.fromJson(v));
      });
    }
    if (json['blog'] != null) {
      blog = new List<Null>();
      json['blog'].forEach((v) {
        // blog.add(new Null.fromJson(v));
      });
    }
    if (json['video'] != null) {
      video = new List<Null>();
      json['video'].forEach((v) {
        // video.add(new Null.fromJson(v));
      });
    }
    if (json['santhya'] != null) {
      santhya = new List<Santhya>();
      json['santhya'].forEach((v) {
        santhya.add(new Santhya.fromJson(v));
      });
    }
    if (json['audio'] != null) {
      audio = new List<Null>();
      json['audio'].forEach((v) {
        // audio.add(new Null.fromJson(v));
      });
    }
    if (json['katha'] != null) {
      katha = new List<Katha>();
      json['katha'].forEach((v) {
        katha.add(new Katha.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['scriptureid_from'] = this.scriptureidFrom;
    data['scriptureid_to'] = this.scriptureidTo;
    if (this.scriptures != null) {
      data['scriptures'] = this.scriptures.map((v) => v.toJson()).toList();
    }
    if (this.blog != null) {
      // data['blog'] = this.blog.map((v) => v.toJson()).toList();
    }
    if (this.video != null) {
      // data['video'] = this.video.map((v) => v.toJson()).toList();
    }
    if (this.santhya != null) {
      // data['santhya'] = this.santhya.map((v) => v.toJson()).toList();
    }
    if (this.audio != null) {
      // data['audio'] = this.audio.map((v) => v.toJson()).toList();
    }
    if (this.katha != null) {
      // data['katha'] = this.katha.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Scriptures {
  int id;
  int shabadID;
  String scripture;
  String scriptureOriginal;
  String scriptureRoman;
  Translation translation;

  Scriptures({this.id, this.shabadID, this.scripture, this.scriptureOriginal, this.scriptureRoman, this.translation});

  Scriptures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shabadID = json['ShabadID'];
    scripture = json['Scripture'];
    scriptureOriginal = json['ScriptureOriginal'];
    scriptureRoman = json['ScriptureRoman'];
    translation = json['translation'] != null ? new Translation.fromJson(json['translation']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ShabadID'] = this.shabadID;
    data['Scripture'] = this.scripture;
    data['ScriptureOriginal'] = this.scriptureOriginal;
    data['ScriptureRoman'] = this.scriptureRoman;
    if (this.translation != null) {
      data['translation'] = this.translation.toJson();
    }
    return data;
  }
}

class Translation {
  int scriptureID;
  String manmohanSinghPunjabi;
  String manmohanSinghEnglish;
  String sahibSinghPunjabi;
  String harbansSinghPunjabi;
  String santSinghKhalsaEnglish;
  Null khojgurbaaniEnglish;
  Null userId;

  Translation(
      {this.scriptureID,
      this.manmohanSinghPunjabi,
      this.manmohanSinghEnglish,
      this.sahibSinghPunjabi,
      this.harbansSinghPunjabi,
      this.santSinghKhalsaEnglish,
      this.khojgurbaaniEnglish,
      this.userId});

  Translation.fromJson(Map<String, dynamic> json) {
    scriptureID = json['ScriptureID'];
    manmohanSinghPunjabi = json['ManmohanSinghPunjabi'];
    manmohanSinghEnglish = json['ManmohanSinghEnglish'];
    sahibSinghPunjabi = json['SahibSinghPunjabi'];
    harbansSinghPunjabi = json['HarbansSinghPunjabi'];
    santSinghKhalsaEnglish = json['SantSinghKhalsaEnglish'];
    khojgurbaaniEnglish = json['KhojgurbaaniEnglish'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ScriptureID'] = this.scriptureID;
    data['ManmohanSinghPunjabi'] = this.manmohanSinghPunjabi;
    data['ManmohanSinghEnglish'] = this.manmohanSinghEnglish;
    data['SahibSinghPunjabi'] = this.sahibSinghPunjabi;
    data['HarbansSinghPunjabi'] = this.harbansSinghPunjabi;
    data['SantSinghKhalsaEnglish'] = this.santSinghKhalsaEnglish;
    data['KhojgurbaaniEnglish'] = this.khojgurbaaniEnglish;
    data['user_id'] = this.userId;
    return data;
  }
}

class Santhya {
  int santheyaId;
  String santhyaUrl;
  int shabadId;
  String changetime;
  int priority;
  int userIdFk;

  Santhya({this.santheyaId, this.santhyaUrl, this.shabadId, this.changetime, this.priority, this.userIdFk});

  Santhya.fromJson(Map<String, dynamic> json) {
    santheyaId = json['santheya_id'];
    santhyaUrl = json['santhya_url'];
    shabadId = json['shabad_id'];
    changetime = json['changetime'];
    priority = json['priority'];
    userIdFk = json['user_id_fk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['santheya_id'] = this.santheyaId;
    data['santhya_url'] = this.santhyaUrl;
    data['shabad_id'] = this.shabadId;
    data['changetime'] = this.changetime;
    data['priority'] = this.priority;
    data['user_id_fk'] = this.userIdFk;
    return data;
  }
}

class Katha {
  int kathaId;
  String kathaUrl;
  int singerId;
  String shabadtitle;
  String website;
  int shabadId;
  String changetime;
  Null displaySingerId;
  int userIdFk;
  int approved;
  Singer singer;

  Katha(
      {this.kathaId,
      this.kathaUrl,
      this.singerId,
      this.shabadtitle,
      this.website,
      this.shabadId,
      this.changetime,
      this.displaySingerId,
      this.userIdFk,
      this.approved,
      this.singer});

  Katha.fromJson(Map<String, dynamic> json) {
    kathaId = json['katha_id'];
    kathaUrl = json['katha_url'];
    singerId = json['singer_id'];
    shabadtitle = json['shabadtitle'];
    website = json['website'];
    shabadId = json['shabad_id'];
    changetime = json['changetime'];
    displaySingerId = json['DisplaySingerId'];
    userIdFk = json['user_id_fk'];
    approved = json['approved'];
    singer = json['singer'] != null ? new Singer.fromJson(json['singer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['katha_id'] = this.kathaId;
    data['katha_url'] = this.kathaUrl;
    data['singer_id'] = this.singerId;
    data['shabadtitle'] = this.shabadtitle;
    data['website'] = this.website;
    data['shabad_id'] = this.shabadId;
    data['changetime'] = this.changetime;
    data['DisplaySingerId'] = this.displaySingerId;
    data['user_id_fk'] = this.userIdFk;
    data['approved'] = this.approved;
    if (this.singer != null) {
      data['singer'] = this.singer.toJson();
    }
    return data;
  }
}

class Singer {
  int singerId;
  String singerName;
  int priority;

  Singer({this.singerId, this.singerName, this.priority});

  Singer.fromJson(Map<String, dynamic> json) {
    singerId = json['singer_id'];
    singerName = json['singer_name'];
    priority = json['Priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['singer_id'] = this.singerId;
    data['singer_name'] = this.singerName;
    data['Priority'] = this.priority;
    return data;
  }
}

class MusicPlayerFullSize extends StatefulWidget {
  final id;
  final title;
  final artistName;
  final attachmentName;
  final int shabadId;
  final int page;
  final Function tapPause;
  final Function showOverlay;
  final String image;
  final Function showOverlayTrue;
  final Function setIsOpenFullScreen;
  final Function showOverlayFalse;
  bool isPlaying;
  final Function tapPlay;
  final audioPlayer;
  final description;
  final thumbnail;
  final created_at;
  final snapshot;
  final Function getLyrics;
  final int is_media;
  final int author_id;
  final Function playPrevSong;
  final Function shuffleListLinks;
  bool repeat;
  final Function setRepeat;
  final Function setShuffle;
  bool shuffle;
  final Function playNextSong;
  final int fromFile;
  final currentSong;
  final setPropertiesForFullScreen;
  final Function play;
  final Function setListLinks;
  final Function insertRecentlyPlayed;
  bool show;
  bool isDownloaded;

  MusicPlayerFullSize({
    Key key,
    this.id,
    this.title,
    this.artistName,
    this.attachmentName,
    this.description,
    this.thumbnail,
    this.created_at,
    this.tapPause,
    this.showOverlay,
    this.image,
    this.showOverlayTrue,
    this.setIsOpenFullScreen,
    this.showOverlayFalse,
    this.isPlaying,
    this.tapPlay,
    this.shabadId,
    this.audioPlayer,
    this.snapshot,
    this.getLyrics,
    this.is_media,
    this.author_id,
    this.playPrevSong,
    this.shuffleListLinks,
    this.repeat,
    this.setRepeat,
    this.page,
    this.setShuffle,
    this.shuffle,
    this.playNextSong,
    this.fromFile,
    this.currentSong,
    this.setPropertiesForFullScreen,
    this.play,
    this.setListLinks,
    this.insertRecentlyPlayed,
    this.show,
    this.isDownloaded,
  }) : super(key: key);

  @override
  _MusicPlayerFullSizeState createState() => _MusicPlayerFullSizeState();
}

class _MusicPlayerFullSizeState extends State<MusicPlayerFullSize> {
  var val;
  List<UserSetings> dbVal = [];
  int fromFullMusicPlayer;

  void initState() {
    this.widget.shabadId != null ? this.widget.getLyrics(this.widget.shabadId, this.widget.page) : null;
    getTranslateValue();
    this.widget.setIsOpenFullScreen(true);
    super.initState();
    songMaxDuration();
    songPosition();
    fromFullMusicPlayer = 1;
    // DBProvider.db.getCount();
    // print(DBProvider.db.ll.toString() + "AAAAAAAAAAAAAAAAAAAAA");
  }

  songMaxDuration() {
    this.widget.audioPlayer.onDurationChanged.listen((Duration d) {
      durationSong = d;
      if (!mounted) return;
      setState(() {
        //return duration = (d - position).inSeconds > 0 ? d - position : Duration(seconds: 0);
      });
    });
  }

  songPosition() async {
    var songDur = await this.widget.audioPlayer.getDuration();
    durationSong = Duration(milliseconds: songDur);
    this.widget.audioPlayer.onAudioPositionChanged.listen((Duration p) {
      if (!mounted) return;
      setState(() {
        position = p;
        duration = (durationSong - position).inSeconds > 0 ? durationSong - position : Duration(seconds: 0);
      });
    });
  }

  getTranslateValue() async {
    final all = await DBProvider.db.getUserSeting();
    dbVal.clear();
    all.forEach((element) => dbVal.add(UserSetings.fromMap(element)));
    setState(() {});
    if (dbVal.isEmpty) {
      this.val = 5;
    } else {
      this.val = dbVal.last.val;
      setState(() {});
    }
  }

  Duration position = new Duration();
  Duration duration = new Duration();
  Duration durationSong = new Duration();
  //Duration durationSong;
  Duration sec = new Duration(seconds: 15);

  seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    this.widget.audioPlayer.seek(newDuration);
  }

  // seekOnPressRight() async {
  //   var right = await this.widget.audioPlayer.seek(durationSong);
  // }

  // seekOnPressLeft() async {
  //   int left =
  //       await this.widget.audioPlayer.seek();
  // }

  // var val = 5;
  translateValue(radioValue1) {
    setState(() {
      this.val = radioValue1;
    });
  }

  bool isGurmukhi = true;
  bool isEnglish = true;
  bool isLarevaar = false;

  scriptureIsGurmukhi(isGurmukhi) {
    setState(() {
      this.isGurmukhi = isGurmukhi;
    });
  }

  scriptureIsEnglish(isEnglish) {
    setState(() {
      this.isEnglish = isEnglish;
    });
  }

  scriptureIsLarevaar(isLarevaar) {
    setState(() {
      this.isLarevaar = isLarevaar;
    });
  }

  bool fromArtistPage = false;

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              this.widget.shabadId == 0 || this.widget.shabadId == null
                  ? SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                this.widget.showOverlay(
                                    context,
                                    this.widget.title,
                                    this.widget.artistName,
                                    this.widget.attachmentName,
                                    this.widget.image,
                                    this.widget.shabadId,
                                    this.widget.page,
                                    this.widget.id,
                                    is_media: this.widget.is_media,
                                    author_id: this.widget.author_id,
                                    fromFile: this.widget.fromFile);
                                setState(() {
                                  this.widget.showOverlayTrue();
                                  this.widget.setIsOpenFullScreen(false);
                                });
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                            this.widget.fromFile != 1
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image(
                                      height: 300,
                                      width: 400,
                                      image: NetworkImage(this.widget.image),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.file(
                                      File(this.widget.image),
                                      height: 300,
                                      width: 400,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    )
                  : SafeArea(
                      child: Container(
                          height: maxHeight * 0.5735,
                          width: MediaQuery.of(context).size.width,
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.lightBlue[100],
                                blurRadius: 6.0,
                              ),
                            ],
                            borderRadius: new BorderRadius.only(
                              bottomLeft: const Radius.circular(50.0),
                              bottomRight: const Radius.circular(50.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        this.widget.showOverlay(
                                              context,
                                              this.widget.title,
                                              this.widget.artistName,
                                              this.widget.attachmentName,
                                              this.widget.image,
                                              this.widget.shabadId,
                                              this.widget.page,
                                              this.widget.id,
                                              is_media: this.widget.is_media,
                                              author_id: this.widget.author_id,
                                            );
                                        setState(() {
                                          this.widget.showOverlayTrue();
                                          this.widget.setIsOpenFullScreen(false);
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 50,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: maxWidth * 0.0555, right: maxWidth * 0.0555),
                                          child: Container(
                                            height: maxHeight * 0.4008,
                                            child:
                                                // FutureBuilder(
                                                //     future: getLyrics(this.widget.shabadId),
                                                //     builder: (BuildContext context,
                                                //         AsyncSnapshot snapshot) {
                                                //       if (snapshot.connectionState ==
                                                //           ConnectionState.done) {
                                                //         if (snapshot.hasData) {
                                                //           return

                                                ListView.builder(
                                                    padding: EdgeInsets.only(
                                                      top: maxHeight * 0.00,
                                                    ),
                                                    scrollDirection: Axis.vertical,
                                                    itemCount: this.widget.snapshot?.data?.scriptures?.length ?? 0,
                                                    itemBuilder: (BuildContext context, int index) {
                                                      return Padding(
                                                        padding: EdgeInsets.only(bottom: maxHeight * 0.015),
                                                        child: Column(
                                                          children: <Widget>[
                                                            this.isGurmukhi == true
                                                                ? Text(
                                                                    (() {
                                                                      if (this.isGurmukhi == true) {
                                                                        return this
                                                                                    .widget
                                                                                    .snapshot
                                                                                    .data
                                                                                    .scriptures[index]
                                                                                    .scripture !=
                                                                                null
                                                                            ? this
                                                                                .widget
                                                                                .snapshot
                                                                                .data
                                                                                .scriptures[index]
                                                                                .scripture
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
                                                            this.isEnglish == true
                                                                ? Text(
                                                                    (() {
                                                                      if (this.isEnglish == true) {
                                                                        return this
                                                                                    .widget
                                                                                    .snapshot
                                                                                    .data
                                                                                    .scriptures[index]
                                                                                    .scriptureRoman !=
                                                                                null
                                                                            ? this
                                                                                .widget
                                                                                .snapshot
                                                                                .data
                                                                                .scriptures[index]
                                                                                .scriptureRoman
                                                                            : 'No translation';
                                                                      } else {
                                                                        print("error");
                                                                      }
                                                                    })(),
                                                                    style: TextStyle(color: Colors.black, fontSize: 18),
                                                                    textAlign: TextAlign.center,
                                                                  )
                                                                : Container(),
                                                            this.isLarevaar == true
                                                                ? Text(
                                                                    (() {
                                                                      if (this.isLarevaar == true) {
                                                                        return this
                                                                                    .widget
                                                                                    .snapshot
                                                                                    .data
                                                                                    .scriptures[index]
                                                                                    .scriptureOriginal !=
                                                                                null
                                                                            ? this
                                                                                .widget
                                                                                .snapshot
                                                                                .data
                                                                                .scriptures[index]
                                                                                .scriptureOriginal
                                                                            : 'No translation';
                                                                      } else {
                                                                        print("error");
                                                                      }
                                                                    })(),
                                                                    style: TextStyle(color: Colors.black, fontSize: 18),
                                                                    textAlign: TextAlign.center,
                                                                  )
                                                                : Container(),
                                                            this.val != 5
                                                                ? Text(
                                                                    (() {
                                                                      if (this.val == 0) {
                                                                        return this
                                                                                    .widget
                                                                                    .snapshot
                                                                                    .data
                                                                                    .scriptures[index]
                                                                                    .translation
                                                                                    .santSinghKhalsaEnglish !=
                                                                                null
                                                                            ? this
                                                                                .widget
                                                                                .snapshot
                                                                                .data
                                                                                .scriptures[index]
                                                                                .translation
                                                                                .santSinghKhalsaEnglish
                                                                            : 'No translation';
                                                                      } else if (this.val == 1) {
                                                                        return this
                                                                                    .widget
                                                                                    .snapshot
                                                                                    .data
                                                                                    .scriptures[index]
                                                                                    .translation
                                                                                    .manmohanSinghEnglish !=
                                                                                null
                                                                            ? this
                                                                                .widget
                                                                                .snapshot
                                                                                .data
                                                                                .scriptures[index]
                                                                                .translation
                                                                                .manmohanSinghEnglish
                                                                            : 'No translation';
                                                                      } else if (this.val == 2) {
                                                                        return this
                                                                                    .widget
                                                                                    .snapshot
                                                                                    .data
                                                                                    .scriptures[index]
                                                                                    .translation
                                                                                    .sahibSinghPunjabi !=
                                                                                null
                                                                            ? this
                                                                                .widget
                                                                                .snapshot
                                                                                .data
                                                                                .scriptures[index]
                                                                                .translation
                                                                                .sahibSinghPunjabi
                                                                            : 'No translation';
                                                                      } else if (this.val == 3) {
                                                                        return this
                                                                                    .widget
                                                                                    .snapshot
                                                                                    .data
                                                                                    .scriptures[index]
                                                                                    .translation
                                                                                    .harbansSinghPunjabi !=
                                                                                null
                                                                            ? this
                                                                                .widget
                                                                                .snapshot
                                                                                .data
                                                                                .scriptures[index]
                                                                                .translation
                                                                                .harbansSinghPunjabi
                                                                            : 'No translation';
                                                                      } else if (this.val == 4) {
                                                                        return this
                                                                                    .widget
                                                                                    .snapshot
                                                                                    .data
                                                                                    .scriptures[index]
                                                                                    .translation
                                                                                    .manmohanSinghPunjabi !=
                                                                                null
                                                                            ? this
                                                                                .widget
                                                                                .snapshot
                                                                                .data
                                                                                .scriptures[index]
                                                                                .translation
                                                                                .manmohanSinghPunjabi
                                                                            : 'No translation';
                                                                      } else {
                                                                        return '';
                                                                      }
                                                                    })(),
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(height: 1.5, fontSize: 18),
                                                                  )
                                                                : Container(),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                            // } else {
                                            //   return Container(
                                            //     height: maxHeight * 0.3378,
                                            //   );
                                            // }
                                            //   } else {
                                            //     return Container(
                                            //       height: maxHeight * 0.3378,
                                            //       child: Center(
                                            //           child: CircularProgressIndicator()),
                                            //     );
                                            //   }
                                            // }),
                                          ),
                                        ),
                                        SizedBox(
                                          height: maxHeight * 0.0270,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: maxWidth * 0.0555),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) => PlayerTextFild(
                                                    widget.description,
                                                    this.isGurmukhi,
                                                    this.isEnglish,
                                                    this.isLarevaar,
                                                    this.val,
                                                    this.widget.shabadId,
                                                    this.widget.page)));
                                      },
                                      child: Icon(
                                        Icons.zoom_out_map,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: maxWidth * 0.722, right: maxWidth * 0.0555),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(PageRouteBuilder(
                                          opaque: false,
                                          pageBuilder: (BuildContext context, animation, secondaryAnimation) =>
                                              SettingsScreen(
                                            translateValue: translateValue,
                                            scriptureIsGurmukhi: scriptureIsGurmukhi,
                                            scriptureIsEnglish: scriptureIsEnglish,
                                            scriptureIsLarevaar: scriptureIsLarevaar,
                                            val: val,
                                            isGurmukhi: isGurmukhi,
                                            isEnglish: isEnglish,
                                            isLarevaar: isLarevaar,
                                          ),
                                          transitionDuration: Duration(seconds: 1),
                                          transitionsBuilder: (ontext, animation, secondaryAnimation, child) {
                                            var begin = Offset(0.0, -1.0);
                                            var end = Offset.zero;
                                            var curve = Curves.ease;

                                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                            return SlideTransition(
                                              position: animation.drive(tween),
                                              child: child,
                                            );
                                          },
                                        ));
                                      },
                                      child: Icon(
                                        Icons.settings,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: maxWidth * 0.0555, left: maxWidth * 0.0555),
                    child: Container(
                      width: maxWidth * 0.5999,
                      child: Text(
                        this.widget.title,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  this.widget.fromFile != 1
                      ? Padding(
                          padding:
                              EdgeInsets.only(left: maxWidth * 0.200, top: maxWidth * 0.0555, right: maxWidth * 0.0555),
                          child: InkWell(
                            onTap: () {
                              print('inside ontap - attname -> ${widget.attachmentName}');
                              this.widget.is_media == 1
                                  ? Navigator.of(context).push(PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder: (BuildContext context, animation, secondaryAnimation) => SongOptions(
                                        indexOfSong: this.widget.id,
                                        indexOfArtist: this.widget.author_id,
                                        title: this.widget.title,
                                        artistName: this.widget.artistName,
                                        attachmentName: this.widget.attachmentName,
                                        id: this.widget.id,
                                        author_id: this.widget.author_id,
                                        image: this.widget.image,
                                        shabadId: this.widget.shabadId,
                                        page: this.widget.page,
                                        is_media: this.widget.is_media,
                                        fromArtistPage: fromArtistPage,
                                        fromFullMusicPlayer: fromFullMusicPlayer,
                                        showOverlay: this.widget.showOverlay,
                                        showOverlayTrue: this.widget.showOverlayTrue,
                                        showOverlayFalse: this.widget.showOverlayFalse,
                                        setIsOpenFullScreen: this.widget.setIsOpenFullScreen,
                                        currentSong: this.widget.currentSong,
                                        setPropertiesForFullScreen: this.widget.setPropertiesForFullScreen,
                                        play: this.widget.play,
                                        setListLinks: this.widget.setListLinks,
                                        insertRecentlyPlayed: this.widget.insertRecentlyPlayed,
                                        show: this.widget.show,
                                        isPlaying: this.widget.isPlaying,
                                        isDownloaded: widget.isDownloaded,
                                      ),
                                      // transitionDuration: Duration(milliseconds: 5),
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
                                    ))
                                  : Navigator.of(context).push(PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder: (BuildContext context, animation, secondaryAnimation) =>
                                          PodcastThreeDots(
                                        isDownloaded: widget.isDownloaded,
                                        indexOfPodcast: this.widget.id,
                                        title: this.widget.title,
                                        id: this.widget.id,
                                        attachmentName: this.widget.attachmentName,
                                        image: this.widget.image,
                                      ),
                                      // transitionDuration: Duration(seconds: 1),
                                      transitionsBuilder: (ontext, animation, secondaryAnimation, child) {
                                        var begin = Offset(0.0, 1.0);
                                        var end = Offset(0.0, 0.47);
                                        var curve = Curves.ease;
                                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                        return SlideTransition(
                                          position: animation.drive(tween),
                                          child: child,
                                        );
                                      },
                                    ));
                            },
                            child: Icon(
                              CupertinoIcons.ellipsis,
                              color: Colors.grey,
                              size: 26,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: maxHeight * 0.0067, left: maxWidth * 0.0555),
                    child: this.widget.artistName != null
                        ? Text(
                            this.widget.artistName,
                            style: TextStyle(fontSize: 14, color: Color(0xff578ed3)),
                          )
                        : Text(''),
                  )
                ],
              ),
              SizedBox(
                height: maxHeight * 0.047,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: maxWidth * 0.00,
                  right: maxWidth * 0.009,
                ),
                child: Container(
                  height: maxHeight * 0.027,
                  child: SliderTheme(
                    child: Slider(
                      value: durationSong.inSeconds.toDouble() > (position?.inSeconds ?? 0).toDouble()
                          ? (position?.inSeconds ?? 0).toDouble()
                          : 0.0,
                      min: 0.0,
                      max: durationSong.inSeconds.toDouble() >= 0 ? durationSong.inSeconds.toDouble() : 0,
                      onChanged: (double value) {
                        setState(() {
                          seekToSecond(value.toInt());
                          value = value;
                        });
                      },
                      inactiveColor: Colors.grey,
                    ),
                    data: SliderTheme.of(context).copyWith(
                        trackHeight: 4,
                        thumbColor: Color(0xff578ed3),
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10)),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: maxWidth / 17),
                    child: Container(
                      width: maxWidth / 5,
                      child: Text(position.inHours > 0
                          ? position.toString().split('.')[0]
                          : "${position.inMinutes.toString().padLeft(2, '0')}:${position.inSeconds.remainder(60).toString().padLeft(2, '0')}"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: maxWidth / 2.1),
                    child: Container(
                      alignment: Alignment.centerRight,
                      width: maxWidth / 5,
                      child: Text(
                        duration.inHours > 0
                            ? "-" + duration.toString().split('.')[0]
                            : "-${duration.inMinutes.toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: maxHeight * 0.02702),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        this.widget.shuffleListLinks();
                        if (this.widget.shuffle) {
                          this.widget.setShuffle(false);
                        } else {
                          this.widget.setShuffle(true);
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: maxWidth * 0.02777),
                        child: this.widget.shuffle == false
                            ? Icon(
                                Icons.shuffle,
                                size: 20,
                                color: Color(0xff535557),
                              )
                            : Icon(
                                Icons.shuffle,
                                size: 20,
                                color: Color(0xff578ed3),
                              ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        this.widget.playPrevSong();
                      },
                      child: Icon(
                        Icons.skip_previous,
                        size: 60,
                        color: Color(0xff535557),
                      ),
                    ),
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                          color: Color(0xff578ed3),
                          borderRadius: BorderRadius.circular(100.0),
                          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 10)]),
                      child: InkWell(
                        onTap: () {
                          this.widget.isPlaying == true ? this.widget.tapPause() : this.widget.tapPlay();
                        },
                        child: this.widget.isPlaying == true
                            ? Icon(
                                Icons.pause,
                                size: 40,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.play_arrow,
                                size: 40,
                                color: Colors.white,
                              ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        this.widget.playNextSong();
                      },
                      child: Icon(
                        Icons.skip_next,
                        size: 60,
                        color: Color(0xff535557),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (this.widget.repeat) {
                          this.widget.setRepeat(false);
                        } else {
                          this.widget.setRepeat(true);
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: maxWidth * 0.0277),
                        child: this.widget.repeat == false
                            ? Icon(
                                Icons.repeat_one,
                                size: 20,
                                color: Color(0xff535557),
                              )
                            : Icon(
                                Icons.repeat_one,
                                size: 20,
                                color: Color(0xff578ed3),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(
              //       top: maxHeight * 0.0370, left: maxWidth * 0.0555),
              //   child: Row(
              //     children: <Widget>[
              //       InkWell(
              //         onTap: () {
              //           Navigator.of(context).push(PageRouteBuilder(
              //             opaque: false,
              //             pageBuilder: (BuildContext context, animation,
              //                     secondaryAnimation) =>
              //                 BluetoothScreen(),
              //             transitionDuration: Duration(seconds: 1),
              //             transitionsBuilder:
              //                 (ontext, animation, secondaryAnimation, child) {
              //               var begin = Offset(0.0, -1.0);
              //               var end = Offset.zero;
              //               var curve = Curves.ease;

              //               var tween = Tween(begin: begin, end: end)
              //                   .chain(CurveTween(curve: curve));

              //               return SlideTransition(
              //                 position: animation.drive(tween),
              //                 child: child,
              //               );
              //             },
              //           ));
              //         },
              //         child: Icon(
              //           Icons.devices,
              //           size: 25,
              //           color: Color(0xff535557),
              //         ),
              //       ),
              //       SizedBox(
              //         width: maxWidth * 0.7638,
              //       ),
              //       InkWell(
              //         onTap: () {},
              //         child: Icon(
              //           Icons.playlist_play,
              //           size: 25,
              //           color: Color(0xff535557),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: maxHeight * 0.02,
              )
            ],
          ),
        ),
      ),
    );
  }
}
