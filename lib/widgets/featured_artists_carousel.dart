import 'package:flutter/material.dart';
import 'package:khojgurbani_music/screens/artist.dart';

import 'package:khojgurbani_music/screens/artist_category.dart';
import 'package:khojgurbani_music/services/services.dart';

import '../service_locator.dart';

// class FeaturedArtists {
//   final int id;
//   final String name;
//   final int status;
//   final String attachmentName;

//   FeaturedArtists(this.id, this.name, this.status, this.attachmentName,
//       );
// }

class FeaturedArtistsCarousel extends StatefulWidget {
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

  FeaturedArtistsCarousel(
    this.showOverlay,
    this.showOverlayTrue,
    this.showOverlayFalse,
    this.show,
    this.play,
    this.setListLinks,
    this.insertRecentlyPlayed,
    this.tapPause,
    this.tapPlay,
    this.tapStop,
    this.setIsOpenFullScreen,
    this.isPlaying,
    this.audioPlayer,
    this.snapshot,
    this.getLyrics,
    this.setPropertiesForFullScreen,
    this.currentSong,
  );

  @override
  _FeaturedArtistsCarouselState createState() => _FeaturedArtistsCarouselState();
}

class _FeaturedArtistsCarouselState extends State<FeaturedArtistsCarousel> {
  var service = getIt<Services>();

  var artists;

  void initState() {
    _fetchFeaturedArtists();
    super.initState();
  }

  bool _isLoading = false;

  _fetchFeaturedArtists() async {
    setState(() {
      _isLoading = true;
    });

    artists = await service.getFeaturedArtists();
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
  }

  updateFeaturedArtists() async {
    setState(() {
      _fetchFeaturedArtists();
    });
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.0555),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Featured Artists',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => ArtistCategory(
                          showOverlay: this.widget.showOverlay,
                          showOverlayTrue: this.widget.showOverlayTrue,
                          showOverlayFalse: this.widget.showOverlayFalse,
                          show: this.widget.show,
                          play: this.widget.play,
                          setListLinks: this.widget.setListLinks,
                          insertRecentlyPlayed: this.widget.insertRecentlyPlayed,
                          setPropertiesForFullScreen: this.widget.setPropertiesForFullScreen,
                          currentSong: this.widget.currentSong),
                    ));
              },
              child: Text(
                "See all",
                style: TextStyle(color: Color(0xff578ed3), fontSize: 14),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: maxHeight * 0.0270),
      Container(
        padding: EdgeInsets.only(left: maxWidth * 0.06944),
        height: maxHeight * 0.2162,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: artists?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            // Destination destination = destinations[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => ArtistPage(
                            indexOfArtist: artists[index].id,
                            id: artists[index].id,
                            name: artists[index].name,
                            attachmentName: artists[index].attachmentName,
                            showOverlay: widget.showOverlay,
                            showOverlayTrue: widget.showOverlayTrue,
                            showOverlayFalse: widget.showOverlayFalse,
                            show: widget.show,
                            play: widget.play,
                            setListLinks: widget.setListLinks,
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
                            currentSong: this.widget.currentSong)));
              },
              child: Container(
                margin: EdgeInsets.only(top: maxHeight * 0.01, left: 0),
                width: maxWidth * 0.2777,
                child: Center(
                  child: Stack(
                    // alignment: Alignment.topCenter,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(top: maxHeight * 0.1216, right: maxWidth * 0.0277, left: maxWidth * 0.0277),
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.only(top: maxHeight * 0.0067),
                            height: maxHeight * 0.270,
                            width: maxWidth * 0.2777,
                            child: Text(
                              artists[index].name,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14),
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: maxHeight * 0.0405,
                          width: maxWidth * 0.277,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(180.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(3.0, 0.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              // tag: 'recently-played1',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(180.0),
                                child: Image(
                                  height: maxHeight * 0.1216,
                                  width: maxWidth * 0.25,
                                  image: NetworkImage(artists[index].attachmentName),
                                  fit: BoxFit.cover,
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
            );
          },
        ),
      ),
    ]);
  }
}
