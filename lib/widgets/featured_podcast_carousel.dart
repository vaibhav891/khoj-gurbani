import 'package:flutter/material.dart';
import 'package:khojgurbani_music/screens/featured_podcasts.dart';

// class FeaturedPodcastsList {
//   int id;
//   String title;
//   final String author = null;
//   final int page = null;
//   String duration;
//   int featured;
//   int featuredDisplayOrder;
//   String media;
//   int is_media = null;
//   final int author_id = null;
//   int shabadId;
//   String thumbnail;

//   FeaturedPodcastsList(
//       {this.id,
//       this.title,
//       this.duration,
//       this.featured,
//       this.featuredDisplayOrder,
//       this.media,
//       this.shabadId,
//       this.thumbnail});

//   FeaturedPodcastsList.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     duration = json['duration'];
//     featured = json['featured'];
//     featuredDisplayOrder = json['featured_display_order'];
//     media = json['media'];
//     shabadId = json['shabad_id'];
//     userPodcastId = json['user_podcast_id'];
//     playlistMediaPodcastId = json['playlist_media_podcast_id'];
//     thumbnail = json['thumbnail'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['author'] = this.author;
//     data['duration'] = this.duration;
//     data['featured'] = this.featured;
//     data['featured_display_order'] = this.featuredDisplayOrder;
//     data['media'] = this.media;
//     data['shabad_id'] = this.shabadId;
//     data['user_podcast_id'] = this.userPodcastId;
//     data['playlist_media_podcast_id'] = this.playlistMediaPodcastId;
//     data['thumbnail'] = this.thumbnail;
//     return data;
//   }
// }

class FeaturedPodcastCarousel extends StatefulWidget {
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
  var featuredPodcasts;

  FeaturedPodcastCarousel(
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
      this.featuredPodcasts);

  @override
  _FeaturedPodcastCarouselState createState() => _FeaturedPodcastCarouselState();
}

class _FeaturedPodcastCarouselState extends State<FeaturedPodcastCarousel> {
  var shabadId = null;

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
                'Featured Podcasts',
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
                          builder: (context) => FeaturedPodcasts(
                              showOverlay: this.widget.showOverlay,
                              showOverlayTrue: this.widget.showOverlayTrue,
                              showOverlayFalse: this.widget.showOverlayFalse,
                              show: this.widget.show,
                              play: this.widget.play,
                              tapPause: this.widget.tapPause,
                              tapPlay: this.widget.tapPlay,
                              tapStop: this.widget.tapStop,
                              setIsOpenFullScreen: this.widget.setIsOpenFullScreen,
                              isPlaying: this.widget.isPlaying,
                              audioPlayer: this.widget.audioPlayer)));
                },
                child: Text(
                  "See all",
                  style: TextStyle(
                    color: Color(0xff578ed3),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: maxWidth * 0.0694),
          height: maxHeight * 0.2478,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: this.widget.featuredPodcasts?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  print('inside carousel -> attname [${widget.featuredPodcasts[index].attachmentName}]');
                  this.widget.showOverlay(
                        context,
                        this.widget.featuredPodcasts[index].title,
                        this.widget.featuredPodcasts[index].author,
                        this.widget.featuredPodcasts[index].attachmentName,
                        this.widget.featuredPodcasts[index].image,
                        this.widget.featuredPodcasts[index].shabadId,
                        this.widget.featuredPodcasts[index].page,
                        this.widget.featuredPodcasts[index].id,
                      );
                  this.widget.play(this.widget.featuredPodcasts[index].attachmentName, context);
                  List links = [];
                  for (int i = index; i < this.widget.featuredPodcasts.length; i++) {
                    links.add(this.widget.featuredPodcasts[i]);
                  }
                  this.widget.setListLinks(links);
                  if (!mounted) return;
                  setState(() {
                    this.widget.showOverlayTrue();
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: maxHeight * 0.0135),
                  width: maxWidth * 0.4111,
                  child: Stack(
                    // alignment: Alignment.topCenter,
                    children: <Widget>[
                      Positioned(
                        top: maxHeight * 0.1891,
                        child: Container(
                          width: maxWidth * 0.27777,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                this.widget.featuredPodcasts[index].title,
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.clip,
                                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black),
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
                              // tag: 'popular-tracks',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6.0),
                                child: Image(
                                  height: maxHeight * 0.181,
                                  width: maxWidth * 0.3777,
                                  image: NetworkImage(this.widget.featuredPodcasts[index].image),
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
