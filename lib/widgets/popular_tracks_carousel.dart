import 'package:flutter/material.dart';

class PopularTracksSongs {
  String success;
  String message;
  List<Result> result;

  PopularTracksSongs({this.success, this.message, this.result});

  PopularTracksSongs.fromJson(Map<String, dynamic> json) {
    success = json['success'];
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
    data['success'] = this.success;
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
  String playCount;
  int page;
  int is_media;
  int author_id;
  String image;

  Result(
      {this.id,
      this.shabadId,
      this.title,
      this.author,
      this.type,
      this.duration,
      this.attachmentName,
      this.playCount,
      this.page,
      this.is_media,
      this.author_id,
      this.image});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    shabadId = json['shabad_id'];
    title = json['title'];
    author = json['author'];
    type = json['type'];
    duration = json['duration'];
    attachmentName = json['attachment_name'];
    playCount = json['play_count'];
    page = json['page'];
    is_media = json['is_media'];
    author_id = json['author_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shabad_id'] = this.shabadId;
    data['title'] = this.title;
    data['author'] = this.author;
    data['type'] = this.type;
    data['duration'] = this.duration;
    data['attachment_name'] = this.attachmentName;
    data['play_count'] = this.playCount;
    data['page'] = this.page;
    data['is_media'] = this.is_media;
    data['author_id'] = this.author_id;
    data['image'] = this.image;
    return data;
  }
}

class PopularTracksCarousel extends StatefulWidget {
  final Function showOverlay;
  final Function showOverlayTrue;
  final Function showOverlayFalse;
  bool show;
  final Function play;
  final Function setListLinks;
  final populars;
  final Function getPopularMedia;
  final Function insertRecentlyPlayed;

  PopularTracksCarousel(
      this.showOverlay,
      this.showOverlayTrue,
      this.showOverlayFalse,
      this.show,
      this.play,
      this.setListLinks,
      this.populars,
      this.getPopularMedia,
      this.insertRecentlyPlayed);

  @override
  _PopularTracksCaruselState createState() => _PopularTracksCaruselState();
}

class _PopularTracksCaruselState extends State<PopularTracksCarousel> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              'Popular Tracks',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      Container(
          padding: EdgeInsets.only(left: maxWidth * 0.0555),
          height: maxHeight * 0.250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: (this.widget.populars?.length ?? 0) < 20
                ? (this.widget.populars?.length ?? 0)
                : 20,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(top: maxHeight * 0.0134),
                width: maxWidth * 0.4055,
                child: GestureDetector(
                  onTap: () {
                    this.widget.showOverlay(
                          context,
                          this.widget.populars[index].title,
                          this.widget.populars[index].author,
                          this.widget.populars[index].attachmentName,
                          this.widget.populars[index].image,
                          this.widget.populars[index].shabadId,
                          this.widget.populars[index].page,
                          this.widget.populars[index].id,
                          is_media: this.widget.populars[index].is_media,
                          author_id: this.widget.populars[index].author_id,
                        );
                    this.widget.play(
                        this.widget.populars[index].attachmentName, context);
                    List links = [];
                    for (int i = index; i < this.widget.populars.length; i++) {
                      links.add(this.widget.populars[i]);
                    }
                    this.widget.setListLinks(links);
                    if (!mounted) return;
                    setState(() {
                      this.widget.showOverlayTrue();
                    });
                    this
                        .widget
                        .insertRecentlyPlayed(this.widget.populars[index].id);
                  },
                  child: Stack(
                    // alignment: Alignment.topCenter,
                    children: <Widget>[
                      Positioned(
                        top: maxHeight * 0.200,
                        child: Container(
                          // height: 65.0,
                          width: maxWidth * 0.378,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                this.widget.populars[index].title,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                this.widget.populars[index].author,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
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
                                  width: maxWidth * 0.378,
                                  image: NetworkImage(
                                      this.widget.populars[index].image),
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
          ))
    ]);
  }
}
