import 'package:flutter/material.dart';
import 'package:khojgurbani_music/screens/podcast_theme.dart';

// class FeaturedPodcastsThemes {
//   final int id;
//   final String title;
//   final String description;
//   final int featured;
//   final int featured_display_order;
//   final String category_image;

//   FeaturedPodcastsThemes(this.id, this.title, this.description, this.featured,
//       this.featured_display_order, this.category_image);
// }

class FeaturedPodcastThemesCarousel extends StatefulWidget {
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
  var featuredPodcastsThemes;

  FeaturedPodcastThemesCarousel(
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
    this.featuredPodcastsThemes,
  );

  @override
  _FeaturedPodcastThemesCarouselState createState() => _FeaturedPodcastThemesCarouselState();
}

class _FeaturedPodcastThemesCarouselState extends State<FeaturedPodcastThemesCarousel> {
  void initState() {
    // _getFeaturedPodcastsThemes();
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.0694),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Featured Podcast Themes',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: maxWidth * 0.0694),
          height: maxHeight * 0.2256,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: this.widget.featuredPodcastsThemes?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              // Destination destination = destinations[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => PodcastThemePage(
                                showOverlay: this.widget.showOverlay,
                                showOverlayTrue: this.widget.showOverlayTrue,
                                showOverlayFalse: this.widget.showOverlayFalse,
                                show: this.widget.show,
                                play: this.widget.play,
                                setListLinks: this.widget.setListLinks,
                                tapPause: this.widget.tapPause,
                                tapPlay: this.widget.tapPlay,
                                tapStop: this.widget.tapStop,
                                setIsOpenFullScreen: this.widget.setIsOpenFullScreen,
                                isPlaying: this.widget.isPlaying,
                                audioPlayer: this.widget.audioPlayer,
                                id: widget.featuredPodcastsThemes[index].id,
                              )));
                },
                child: Container(
                  margin: EdgeInsets.only(top: maxHeight * 0.0135),
                  width: maxWidth * 0.4111,
                  child: Stack(
                    // alignment: Alignment.topCenter,
                    children: <Widget>[
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: maxWidth * 0.3777,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.featuredPodcastsThemes[index].title,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              // tag: 'recently-played1',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6.0),
                                child: Image(
                                  height: maxHeight * 0.181,
                                  width: maxWidth * 0.3777,
                                  image: NetworkImage(widget.featuredPodcastsThemes[index].categoryImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
