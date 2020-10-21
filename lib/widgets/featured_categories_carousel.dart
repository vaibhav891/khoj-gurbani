import 'package:flutter/material.dart';
import 'package:khojgurbani_music/screens/category_tracks.dart';

import 'package:khojgurbani_music/screens/sub_category.dart';
import 'package:khojgurbani_music/services/services.dart';

import '../service_locator.dart';

class FeaturedCategories {
  String status;
  String message;
  List<Result> result;

  FeaturedCategories({this.status, this.message, this.result});

  FeaturedCategories.fromJson(Map<String, dynamic> json) {
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
  String name;
  String slug;
  int subCategoryCount;
  String attachmentName;

  Result(
      {this.id,
      this.name,
      this.slug,
      this.subCategoryCount,
      this.attachmentName});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    subCategoryCount = json['sub_category_count'];
    attachmentName = json['attachment_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['sub_category_count'] = this.subCategoryCount;
    data['attachment_name'] = this.attachmentName;
    return data;
  }
}

class FeaturedCategoriesCarousel extends StatefulWidget {
  final Function showOverlay;
  final Function showOverlayTrue;
  final Function showOverlayFalse;
  bool show;
  final Function play;
  final Function setListLinks;
  final Function insertRecentlyPlayed;
  final Function setPropertiesForFullScreen;
  final currentSong;

  FeaturedCategoriesCarousel(
    this.showOverlay,
    this.showOverlayTrue,
    this.showOverlayFalse,
    this.show,
    this.play,
    this.setListLinks,
    this.insertRecentlyPlayed,
    this.setPropertiesForFullScreen,
    this.currentSong,
  );

  @override
  _FeaturedCategoriesCarouselState createState() =>
      _FeaturedCategoriesCarouselState();
}

class _FeaturedCategoriesCarouselState
    extends State<FeaturedCategoriesCarousel> {
  var service = getIt<Services>();

  @override
  void initState() {
    service.getFeaturedCategories();
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
              'Featured Categories',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      Container(
          padding:
              EdgeInsets.only(left: maxWidth * 0.0555, top: maxHeight * 0.0135),
          height: maxHeight * 0.1757,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: service.categories?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              // Destination destination = destinations[index];
              return GestureDetector(
                onTap: () {
                  if (service.categories[index].subCategoryCount != 0) {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => CategoryPage(
                                  categories: service.categories[index],
                                  showOverlay: this.widget.showOverlay,
                                  showOverlayTrue: this.widget.showOverlayTrue,
                                  showOverlayFalse:
                                      this.widget.showOverlayFalse,
                                  show: this.widget.show,
                                  play: this.widget.play,
                                  setListLinks: this.widget.setListLinks,
                                  insertRecentlyPlayed:
                                      this.widget.insertRecentlyPlayed,
                                  setPropertiesForFullScreen:
                                      this.widget.setPropertiesForFullScreen,
                                  currentSong: this.widget.currentSong,
                                )));
                  } else {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => CategoryTracksPage(
                                  id: service.categories[index].id,
                                  name: service.categories[index].name,
                                  api:
                                      'https://api.khojgurbani.org/api/v1/android/sub-categories-new/' +
                                          service.categories[index].id
                                              .toString(),
                                  showOverlay: this.widget.showOverlay,
                                  showOverlayTrue: this.widget.showOverlayTrue,
                                  showOverlayFalse:
                                      this.widget.showOverlayFalse,
                                  show: this.widget.show,
                                  play: this.widget.play,
                                  setListLinks: widget.setListLinks,
                                  insertRecentlyPlayed:
                                      this.widget.insertRecentlyPlayed,
                                  setPropertiesForFullScreen:
                                      this.widget.setPropertiesForFullScreen,
                                  currentSong: this.widget.currentSong,
                                )));
                  }
                },
                child: Container(
                  width: maxWidth * 0.30555,
                  child: Stack(
                    // alignment: Alignment.topCenter,
                    children: <Widget>[
                      Positioned(
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: maxHeight * 0.300),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  service.categories[index].name,
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
                          // alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              // tag: 'recently-played1',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6.0),
                                child: Image(
                                  height: maxHeight * 0.134,
                                  width: maxWidth * 0.289,
                                  image: NetworkImage(
                                      service.categories[index].attachmentName),
                                  fit: BoxFit.fill,
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
