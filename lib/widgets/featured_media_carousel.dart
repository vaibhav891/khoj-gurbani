import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khojgurbani_music/screens/three_dots_on_song.dart';
import 'package:khojgurbani_music/services/services.dart';

import '../service_locator.dart';

class FeaturedMediaSongs {
  String status;
  String message;
  List<Result> result;

  FeaturedMediaSongs({this.status, this.message, this.result});

  FeaturedMediaSongs.fromJson(Map<String, dynamic> json) {
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
  int shabadId;
  String title;
  String author;
  String type;
  String duration;
  String attachmentName;
  String image;
  int favourite;
  int page;
  int is_media;
  int author_id;

  Result({
    this.id,
    this.shabadId,
    this.title,
    this.author,
    this.type,
    this.duration,
    this.attachmentName,
    this.image,
    this.favourite,
    this.page,
    this.is_media,
    this.author_id,
  });

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shabadId = json['shabad_id'];
    title = json['title'];
    author = json['author_name'];
    type = json['type'];
    duration = json['duration'];
    attachmentName = json['attachment_name'];
    image = json['image'];
    favourite = json['favourite'];
    page = json['page'];
    is_media = json['is_media'];
    author_id = json['author_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shabad_id'] = this.shabadId;
    data['title'] = this.title;
    data['author_name'] = this.author;
    data['type'] = this.type;
    data['duration'] = this.duration;
    data['attachment_name'] = this.attachmentName;
    data['image'] = this.image;
    data['favourite'] = this.favourite;
    data['page'] = this.page;
    data['is_media'] = this.is_media;
    data['author_id'] = this.author_id;
    return data;
  }
}

class FeaturedMedia extends StatefulWidget {
  final Function showOverlay;
  final Function showOverlayTrue;
  final Function showOverlayFalse;
  bool show;
  final Function play;
  final Function setListLinks;
  final Function setPropertiesForFullScreen;
  final Function insertRecentlyPlayed;
  final currentSong;

  FeaturedMedia(
    this.showOverlay,
    this.showOverlayTrue,
    this.showOverlayFalse,
    this.show,
    this.play,
    this.setListLinks,
    // this.medias,
    // this.getFeaturedMedia,
    this.setPropertiesForFullScreen,
    this.insertRecentlyPlayed,
    this.currentSong,
  );

  @override
  _FeaturedMediaState createState() => _FeaturedMediaState();
}

class _FeaturedMediaState extends State<FeaturedMedia> {
  var service = getIt<Services>();
  var medias;
  bool fromArtistPage;

  @override
  void initState() {
    medias = service.medias;
    service.getFeaturedMedia();
    setState(() {
      service.medias = medias;
    });
    fromArtistPage = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.only(left: maxWidth * 0.0555),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Featured Media',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      Container(
          padding: EdgeInsets.only(left: maxWidth * 0.0694, top: maxHeight * 0.014),
          height: maxHeight * 0.3,
          child: GridView.count(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(right: 5),
              // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: false,
              childAspectRatio: 0.195,
              crossAxisCount: 4,
              crossAxisSpacing: 4,
              // itemCount: snapshot.data.length,
              children: List.generate(service.medias?.length ?? 0, (index) {
                return Container(
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
                            this.widget.showOverlay(
                                  context,
                                  service.medias[index].title,
                                  service.medias[index].author,
                                  service.medias[index].attachmentName,
                                  service.medias[index].image,
                                  service.medias[index].shabadId,
                                  service.medias[index].page,
                                  service.medias[index].id,
                                  is_media: service.medias[index].is_media,
                                  author_id: service.medias[index].author_id,
                                );
                            this.widget.play(service.medias[index].attachmentName, context);
                            List links = [];
                            for (int i = index; i < service.medias.length; i++) {
                              links.add(service.medias[i]);
                            }
                            this.widget.setListLinks(links);
                            if (!mounted) return;
                            setState(() {
                              this.widget.showOverlayTrue();
                            });
                            this.widget.insertRecentlyPlayed(service.medias[index].id);
                          },
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                  top: maxHeight * 0.005,
                                  left: maxWidth * 0.159,
                                ),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: maxWidth * 0.45,
                                      child: Text(
                                        service.medias[index].title,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                    SizedBox(
                                      height: maxHeight * 0.007,
                                    ),
                                    Container(
                                      width: maxWidth * 0.4,
                                      child: Text(
                                        service.medias[index].author,
                                        style: TextStyle(
                                            fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.grey),
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
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
                                    image: NetworkImage(service.medias[index].image),
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
                                padding: EdgeInsets.only(top: maxHeight * 0.005, right: maxWidth * 0.0555),
                                child: Text(
                                  service.medias[index].duration,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder: (BuildContext context, animation, secondaryAnimation) => SongOptions(
                                      indexOfSong: service.medias[index].id,
                                      indexOfArtist: service.medias[index].author_id,
                                      title: service.medias[index].title,
                                      artistName: service.medias[index].author,
                                      attachmentName: service.medias[index].attachmentName,
                                      id: service.medias[index].id,
                                      author_id: service.medias[index].author_id,
                                      shabadId: service.medias[index].shabadId,
                                      page: service.medias[index].page,
                                      image: service.medias[index].image,
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
                                      //  this.widget.show == true ?  end = Offset(0.0, -0.08) :
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
                                  alignment: Alignment.centerRight,
                                  width: maxWidth * 0.238888,
                                  // height: maxHeight * 0.01399,
                                  padding: EdgeInsets.only(
                                    // top: maxHeight * 0.002750,
                                    right: maxWidth * 0.047,
                                  ),
                                  child: Icon(
                                    CupertinoIcons.ellipsis,
                                    size: 28,
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
              })))
    ]);
    //     } else {
    //       return Center(child: Container());
    //     }
    //   } else {
    //     return Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   }
    // })
  }
}
