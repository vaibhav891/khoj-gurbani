import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:khojgurbani_music/service_locator.dart';
import 'package:khojgurbani_music/services/services.dart';
import 'package:khojgurbani_music/widgets/bottom_navigation_bar.dart';
import 'package:khojgurbani_music/widgets/featured_podcast_themes_carousel.dart';
import 'package:khojgurbani_music/widgets/live_kirtan_radio_carousel.dart';
import '../widgets/recently_played_carousel.dart';
import '../widgets/popular_tracks_carousel.dart';
import '../widgets/featured_podcast_carousel.dart';
import '../widgets/featured_media_carousel.dart';
import '../widgets/featured_categories_carousel.dart';
import '../widgets/featured_artists_carousel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class MediaPage extends StatefulWidget {
  bool isPlaying;
  // bool icons;
  final Function tapPause;
  final Function tapPlay;
  final Function tapStop;
  final Function play;
  final Function showOverlay;
  final Function showOverlayTrue;
  final Function showOverlayFalse;
  bool show;
  final Function setListLinks;
  final Function insertRecentlyPlayed;
  final Function setIsOpenFullScreen;
  final audioPlayer;
  final snapshot;
  final getLyrics;
  final Function setPropertiesForFullScreen;
  var featuredPodcasts;
  var featuredPodcastsThemes;
  final currentSong;

  MediaPage({
    Key key,
    this.tapPause,
    this.tapPlay,
    this.tapStop,
    this.isPlaying,
    this.play,
    this.showOverlay,
    this.showOverlayTrue,
    this.showOverlayFalse,
    this.show,
    this.setListLinks,
    this.insertRecentlyPlayed,
    this.setIsOpenFullScreen,
    this.audioPlayer,
    this.snapshot,
    this.getLyrics,
    this.setPropertiesForFullScreen,
    this.featuredPodcasts,
    this.featuredPodcastsThemes,
    this.currentSong,
  }) : super(key: key);

  @override
  _MediaPageState createState() => _MediaPageState();
}

class PodcastIndex {
  final String title;
  String updatedAt = '';
  String createdAt = '';
  final String media_data;
  final String duration;

  PodcastIndex(this.title, this.media_data, this.duration);
}

class _MediaPageState extends State<MediaPage> {
  var service = getIt<Services>();

  bool _isLoading = false;
  var homePodcastIndex;
  _fetchHomePodcastIndex() async {
    setState(() {
      _isLoading = true;
    });

    homePodcastIndex = await service.getHomePodcastIndex();

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
  }

  var populars;
  Future getPopularMedia() async {
    var data = await http.get('https://api.khojgurbani.org/api/v1/media/popular-tracks');
    var jsonData = json.decode(data.body);

    PopularTracksSongs s = new PopularTracksSongs.fromJson(jsonData);

    // for (var p in jsonData) {
    //   PopularTracksSongs popular = PopularTracksSongs(
    //       p["id"],
    //       p["shabad_id"],
    //       p["title"],
    //       p["author"],
    //       p["type"],
    //       p["duration"],
    //       p["attachment_name"],
    //       p["play_count"],
    //       p["image"],
    //       p["author_id"]);
    //   populars.add(popular);
    // }
    if (!mounted) return;
    setState(() {
      populars = s.result;
    });
    return s;
  }

  bool isOpen;

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.month}/${dateTime.day}/${dateTime.year}';
  }

  void initState() {
    _fetchHomePodcastIndex();
    super.initState();
    // getPodcastIndex();
    SystemChrome.setEnabledSystemUIOverlays([]);
    getPopularMedia();
    // getFeaturedMedia();
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //       statusBarColor: Colors.transparent,
    //       systemNavigationBarColor: Colors.black, // navigation bar color
    //       statusBarIconBrightness: Brightness.dark),
    // );
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;

    var newDT = _isLoading == false ? DateTime.parse(homePodcastIndex[0].createdAt) : '';
    // if (_indexs != null) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xffF5F5F5),
            title:
                // Image.asset(
                //   'assets/images/Khoj Gurbani logo.png',
                //   width: maxWidth * 0.5,
                //   height: maxHeight * 0.06,
                //   color: Color(0xff578ED3),
                // ),

                Text(
              'Media',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          bottomNavigationBar: MyBottomNavBar(),
          backgroundColor: Colors.white,
          body: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: maxWidth / 20, right: maxWidth / 20, top: maxHeight / 30),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    image: DecorationImage(image: AssetImage('assets/images/media.png'), fit: BoxFit.cover),
                  ),
                  child: _isLoading == false
                      ? Stack(
                          children: [
                            Positioned(
                              top: maxHeight / 25,
                              left: maxWidth / 20,
                              child: Container(
                                width: maxWidth / 3,
                                child: Text(
                                  homePodcastIndex[0].title,
                                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Positioned(
                              top: maxHeight / 16,
                              left: maxWidth / 20,
                              child: Container(
                                width: maxWidth / 1.7,
                                child: Text(
                                  DateFormat.yMMMd().format(newDT),
                                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Positioned(
                              top: maxHeight / 25,
                              left: maxWidth / 2.4,
                              child: GestureDetector(
                                onTap: () {
                                  this.widget.showOverlay(
                                      context,
                                      homePodcastIndex[0].title,
                                      null,
                                      homePodcastIndex[0].englishPodcastSrc,
                                      homePodcastIndex[0].thumbnail,
                                      null,
                                      null,
                                      null,
                                      isRadio: homePodcastIndex[0].is_radio);
                                  this.widget.play(homePodcastIndex[0].englishPodcastSrc, context);
                                  if (!mounted) return;
                                  setState(() {
                                    this.widget.showOverlayTrue();
                                  });
                                },
                                child: Container(
                                  height: 32.7,
                                  width: maxWidth / 6,
                                  child: Container(
                                    // padding: EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: maxWidth / 100,
                                        ),
                                        Text(
                                          "ENG",
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
                            ),
                            Positioned(
                              top: maxHeight / 25,
                              left: maxWidth / 1.5,
                              child: GestureDetector(
                                onTap: () {
                                  this.widget.showOverlay(
                                      context,
                                      homePodcastIndex[0].pTitle,
                                      null,
                                      homePodcastIndex[0].punjabiPodcardSrc,
                                      homePodcastIndex[0].thumbnail,
                                      null,
                                      null,
                                      null,
                                      isRadio: homePodcastIndex[0].is_radio);
                                  this.widget.play(homePodcastIndex[0].punjabiPodcardSrc, context);
                                  if (!mounted) return;
                                  setState(() {
                                    this.widget.showOverlayTrue();
                                  });
                                },
                                child: Container(
                                  height: 32.7,
                                  width: maxWidth / 6,
                                  child: Container(
                                    // padding: EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: maxWidth / 100,
                                        ),
                                        Text(
                                          "PUN",
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
                            ),
                          ],
                        )
                      : Container(),
                ),
              ),
              SizedBox(
                height: maxHeight * 0.019,
              ),
              RecentlyPlayedCarousel(
                this.widget.showOverlay,
                this.widget.showOverlayTrue,
                this.widget.showOverlayFalse,
                this.widget.show,
                this.widget.play,
                this.widget.setListLinks,
                this.widget.currentSong,
              ),
              SizedBox(
                height: maxHeight * 0.0285,
              ),
              PopularTracksCarousel(
                  this.widget.showOverlay,
                  this.widget.showOverlayTrue,
                  this.widget.showOverlayFalse,
                  this.widget.show,
                  this.widget.play,
                  this.widget.setListLinks,
                  this.populars,
                  this.getPopularMedia,
                  this.widget.insertRecentlyPlayed),
              SizedBox(
                height: maxHeight * 0.0311,
              ),
              FeaturedMedia(
                this.widget.showOverlay,
                this.widget.showOverlayTrue,
                this.widget.showOverlayFalse,
                this.widget.show,
                this.widget.play,
                this.widget.setListLinks,
                this.widget.setPropertiesForFullScreen,
                this.widget.insertRecentlyPlayed,
                this.widget.currentSong,
              ),
              SizedBox(
                height: maxHeight * 0.0325,
              ),
              FeaturedCategoriesCarousel(
                this.widget.showOverlay,
                this.widget.showOverlayTrue,
                this.widget.showOverlayFalse,
                this.widget.show,
                this.widget.play,
                this.widget.setListLinks,
                this.widget.insertRecentlyPlayed,
                this.widget.setPropertiesForFullScreen,
                this.widget.currentSong,
              ),
              SizedBox(
                height: maxHeight * 0.0325,
              ),
              FeaturedArtistsCarousel(
                this.widget.showOverlay,
                this.widget.showOverlayTrue,
                this.widget.showOverlayFalse,
                this.widget.show,
                this.widget.play,
                this.widget.setListLinks,
                this.widget.insertRecentlyPlayed,
                this.widget.tapPause,
                this.widget.tapPlay,
                this.widget.tapStop,
                this.widget.setIsOpenFullScreen,
                this.widget.isPlaying,
                this.widget.audioPlayer,
                this.widget.snapshot,
                this.widget.getLyrics,
                this.widget.setPropertiesForFullScreen,
                this.widget.currentSong,
              ),
              SizedBox(
                height: maxHeight * 0.0205,
              ),
              FeaturedPodcastCarousel(
                  this.widget.showOverlay,
                  this.widget.showOverlayTrue,
                  this.widget.showOverlayFalse,
                  this.widget.show,
                  this.widget.play,
                  this.widget.setListLinks,
                  this.widget.tapPause,
                  this.widget.tapPlay,
                  this.widget.tapStop,
                  this.widget.setIsOpenFullScreen,
                  this.widget.isPlaying,
                  this.widget.audioPlayer,
                  this.widget.featuredPodcasts),
              SizedBox(height: 20),
              FeaturedPodcastThemesCarousel(
                  this.widget.showOverlay,
                  this.widget.showOverlayTrue,
                  this.widget.showOverlayFalse,
                  this.widget.show,
                  this.widget.play,
                  this.widget.setListLinks,
                  this.widget.tapPause,
                  this.widget.tapPlay,
                  this.widget.tapStop,
                  this.widget.setIsOpenFullScreen,
                  this.widget.isPlaying,
                  this.widget.audioPlayer,
                  this.widget.featuredPodcastsThemes),
              SizedBox(
                height: maxHeight * 0.0325,
              ),
              LiveKirtanRadioCarousel(
                this.widget.showOverlay,
                this.widget.showOverlayTrue,
                this.widget.showOverlayFalse,
                this.widget.show,
                this.widget.play,
                this.widget.tapPause,
                this.widget.tapPlay,
                this.widget.tapStop,
                this.widget.isPlaying,
                this.widget.audioPlayer,
              ),
              SizedBox(
                height: maxHeight * 0.0150,
              ),
            ],
          )),
    );

    // } else {
    //   return Scaffold(body: Center(child: CircularProgressIndicator()));
    // }
  }
}
