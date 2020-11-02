import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khojgurbani_music/models/Downloads.dart';
import 'package:khojgurbani_music/screens/podcast_on_three_dots.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:khojgurbani_music/service_locator.dart';
import 'package:khojgurbani_music/services/Database.dart';
import 'package:khojgurbani_music/services/downloadFiles.dart';

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class PodcastThemeCard extends StatefulWidget {
  final id;
  final title;
  final description;
  final duration;
  final thumbnail;
  final author;
  final shabadId;
  final created_at;
  final attachmentName;
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
  bool isPlaying;
  final audioPlayer;
  var allPodcasts;
  final Function resetSelectedProp;
  final indexOfPodcast;

  PodcastThemeCard(
      {Key key,
      this.id,
      this.title,
      this.description,
      this.duration,
      this.thumbnail,
      this.author,
      this.shabadId,
      this.created_at,
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
      this.allPodcasts,
      this.resetSelectedProp,
      this.indexOfPodcast})
      : super(key: key);
  @override
  _PodcastThemeCardState createState() => _PodcastThemeCardState();
}

class _PodcastThemeCardState extends State<PodcastThemeCard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  var service = getIt<Downloader>();
  Downloads downloads = new Downloads();

  // bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    songMaxDuration();
    songPosition();
  }

  Duration position = new Duration();
  Duration duration = new Duration();
  Duration durationSong = new Duration();
  Duration sec = new Duration(seconds: 15);

  songMaxDuration() {
    this.widget.audioPlayer.onDurationChanged.listen((Duration d) {
      durationSong = d;
      if (!mounted) return;
      setState(() => duration =
          (d - position).inSeconds > 0 ? d - position : Duration(seconds: 0));
    });
  }

  songPosition() {
    this.widget.audioPlayer.onAudioPositionChanged.listen((Duration p) {
      if (!mounted) return;
      setState(() => position = p);
    });
  }

  var playerState;
  var s;

  audioPlayerState() {
    this
        .widget
        .audioPlayer
        .onPlayerStateChanged
        .listen((AudioPlayerState s) => {
              if (mounted)
                {
                  setState(() {
                    if (s == AudioPlayerState.PAUSED) {
                      this.widget.isPlaying = false;
                      // this.widget.allPodcasts.isSelected = false;
                    } else if (s == AudioPlayerState.STOPPED) {
                      this.widget.isPlaying = false;
                      this.widget.allPodcasts.isSelected = false;
                    } else if (s == AudioPlayerState.PLAYING) {
                      this.widget.isPlaying = true;
                    } else {}
                  })
                }
            });
  }

  seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    this.widget.audioPlayer.seek(newDuration);
  }

  var months = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC"
  ];

  var page = null;

  downloading() {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop();
          });
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            title: Center(
              child: Text(
                "Downloading...",
                style: TextStyle(fontSize: 14),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    var newDT = DateTime.parse(widget.created_at);
    return Card(
      elevation:
          this.widget.allPodcasts.isSelected && this.widget.isPlaying == true
              ? 30
              : 2,

      // semanticContainer: false,
      margin: EdgeInsets.only(
          left: maxWidth * 0.05555, top: 0, right: maxWidth * 0.05555),
      child: Container(
        // width: 500,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: maxHeight * 0.027027, left: maxWidth * 0.05555),
              child: Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: Image(
                            height: maxHeight / 14,
                            width: maxWidth / 6,
                            image: NetworkImage(widget.thumbnail.contains(
                                    'https://api.khojgurbani.org/uploads/thumbnail/')
                                ? widget.thumbnail
                                : 'https://api.khojgurbani.org/uploads/thumbnail/' +
                                    widget.thumbnail),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: maxWidth * 0.03, bottom: maxHeight * 0.01),
                        child: Container(
                          width: maxWidth * 0.45,
                          child: Text(
                            widget.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: maxWidth * 0.07,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, animation,
                                secondaryAnimation) =>
                            PodcastThreeDots(
                          title: this.widget.title,
                          artistName: this.widget.author,
                          image: this.widget.thumbnail,
                          attachmentName: this.widget.attachmentName,
                          id: this.widget.id,
                          playlist_id: null,
                          indexOfPodcast: this.widget.indexOfPodcast,
                        ),
                        // transitionDuration: Duration(seconds: 1),
                        transitionsBuilder:
                            (ontext, animation, secondaryAnimation, child) {
                          var begin = Offset(0.0, 1.0);
                          var end = this.widget.show == true
                              ? Offset(0.0, 0.30)
                              : Offset(0.0, 0.47);
                          var curve = Curves.ease;
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ));
                    },
                    child: Container(
                      width: maxWidth * 0.0555,
                      padding: EdgeInsets.only(bottom: maxHeight * 0.009459),
                      child: Icon(
                        CupertinoIcons.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: maxWidth * 0.05555,
                top: maxHeight * 0.02027,
                right: maxWidth * 0.0555,
              ),
              child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.description != null ? widget.description : '',
                    maxLines: 2,
                    style: TextStyle(fontSize: 13),
                  )),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: maxWidth * 0.0277, top: maxHeight * 0.0270),
                  child: IconButton(
                      color: Color(0xff578ed3),
                      icon: this.widget.allPodcasts.isSelected == true &&
                              this.widget.isPlaying
                          ? Icon(
                              Icons.pause_circle_filled,
                              size: 40.0,
                            )
                          : Icon(
                              Icons.play_circle_filled,
                              size: 40.0,
                              color: Colors.grey[600],
                            ),
                      onPressed: () {
                        var isSelectedTMP = this.widget.allPodcasts.isSelected;
                        this.widget.resetSelectedProp();
                        this.widget.showOverlay(
                              context,
                              this.widget.title,
                              this.widget.author,
                              this.widget.attachmentName,
                              this.widget.thumbnail,
                              this.widget.shabadId,
                              page,
                              this.widget.id,
                            );
                        // List links = [];
                        // for (int i = index + 1; i < snapshot.data.length; i++) {
                        //   links.add(snapshot.data[i]);
                        // }
                        // this.widget.setListLinks(links);
                        // if (!mounted) return;
                        if (this.widget.attachmentName != null)
                          setState(() {
                            if (this.widget.allPodcasts != null) {
                              this.widget.allPodcasts.isSelected = true;
                            }
                            this.widget.isPlaying = !this.widget.isPlaying;
                            this.widget.showOverlayTrue();
                            audioPlayerState();
                            !this.widget.isPlaying && isSelectedTMP
                                ? this.widget.tapPause()
                                : this
                                    .widget
                                    .play(this.widget.attachmentName, context);
                          });
                      }),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 10, top: 30),
                //   child: Text('Feb 19-'),
                // ),
                Padding(
                  padding: EdgeInsets.only(
                      top: maxHeight * 0.035, left: maxWidth * 0.013888),
                  child: Container(
                      width: maxWidth * 0.43777,
                      child: Row(
                        children: <Widget>[
                          // Text(widget.duration + " MIN"),
                          Text(
                            DateFormat.MMM().add_d().format(newDT) +
                                " - " +
                                widget.duration +
                                " MIN",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () async {
                    downloading();
                    service.downloadImage(
                        this.widget.thumbnail, this.widget.title);
                    service
                        .downloadFile(
                      this.widget.attachmentName,
                      this.widget.title,
                    )
                        .then(
                      (value) async {
                        Downloads newDT = Downloads(
                          id: widget.id,
                          title: this.widget.title,
                          author: this.widget.author,
                          attachmentName: service.pathName.toString(),
                          image: service.imagePath.toString(),
                          is_media: 0,
                          duration: value,
                          //author_id: no author id for podcast
                          timestamp: DateTime.now().millisecondsSinceEpoch,
                        );
                        await DBProvider.db.newDownload(newDT);
                      },
                      onError: (_) => print(
                          'Something went wrong, download returned error'),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: maxHeight * 0.04054, left: maxWidth / 5.8),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(
                        Icons.arrow_downward,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: maxHeight * 0.027027,
            ),
            this.widget.allPodcasts.isSelected && this.widget.isPlaying == true
                ? Container(
                    width: 500,
                    height: maxHeight * 0.003,
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          activeTickMarkColor: Color(0xff578ed3),
                          thumbColor: Colors.transparent,
                          trackShape: CustomTrackShape(),
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 0.0)),
                      child: Slider(
                        value: durationSong.inSeconds.toDouble() >
                                (position?.inSeconds ?? 0).toDouble()
                            ? (position?.inSeconds ?? 0).toDouble()
                            : 0.0,
                        min: 0.0,
                        max: durationSong.inSeconds.toDouble() > 0
                            ? durationSong.inSeconds.toDouble()
                            : 0,
                        onChanged: (double value) {
                          setState(() {
                            seekToSecond(value.toInt());
                            value = value;
                          });
                        },
                        inactiveColor: Colors.grey,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
